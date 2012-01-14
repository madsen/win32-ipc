#---------------------------------------------------------------------
package Win32::IPC;
#
# Copyright 1998-2012 Christopher J. Madsen
#
# Created: 3 Feb 1998 from the ActiveWare version
#   (c) 1995 Microsoft Corporation. All rights reserved.
#       Developed by ActiveWare Internet Corp., http://www.ActiveState.com
#
#   Other modifications (c) 1997 by Gurusamy Sarathy <gsar@cpan.org>
#
# Author: Christopher J. Madsen <perl@cjmweb.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either the
# GNU General Public License or the Artistic License for more details.
#
# ABSTRACT: Base class for Win32 synchronization objects
#---------------------------------------------------------------------

use 5.006;
use strict;
use warnings;

BEGIN
{
  our $VERSION = '1.09';
  # This file is part of {{$dist}} {{$dist_version}} ({{$date}})

  require Exporter;
  our @ISA       = qw( Exporter );
  our @EXPORT    = qw( INFINITE WaitForMultipleObjects );
  our @EXPORT_OK = qw( wait_any wait_all );

  require XSLoader;
  XSLoader::load('Win32::IPC', $VERSION);

  # Generate INFINITE constant function:
  my $INFINITE = constant('INFINITE');
  do { local $@; eval "sub INFINITE () { $INFINITE } 1" } or die;
} # end BEGIN bootstrap

# How's this for cryptic?  Use wait_any or wait_all!
sub WaitForMultipleObjects
{
    my $result = (($_[1] ? &wait_all($_[0], $_[2])
                   : &wait_any($_[0], $_[2]))
                  ? 1
                  : 0);
    @{$_[0]} = (); # Bug for bug compatibility!  Use wait_any or wait_all!
    $result;
} # end WaitForMultipleObjects

1;
__END__

=head1 SYNOPSIS

    use Win32::Event 1.00 qw(wait_any);
    #Create objects.

    wait_any(@ListOfObjects, $timeout);

=head1 DESCRIPTION

This module is loaded by the other Win32 synchronization modules.  You
shouldn't need to load it yourself.  It supplies the wait functions to
those modules.

The synchronization modules are L<Win32::ChangeNotify>,
L<Win32::Event>, L<Win32::Mutex>, & L<Win32::Semaphore>.

In addition, you can use C<wait_any> and C<wait_all> with
L<Win32::Console> and L<Win32::Process> objects.  (However, those
modules do not export the wait functions; you must load one of the
synchronization modules (or just Win32::IPC)).

=head2 Methods

Win32::IPC supplies one method to all synchronization objects.

=over 4

=item $obj->wait([$timeout])

Waits for C<$obj> to become signalled.  C<$timeout> is the maximum time
to wait (in milliseconds).  If C<$timeout> is omitted or C<undef>,
waits forever.  If C<$timeout> is 0, returns immediately.

Returns:

   +1    The object is signalled
   -1    The object is an abandoned mutex
    0    Timed out
  undef  An error occurred (check C<$^E> for details)

=back

=head2 Functions

=over 4

=item wait_any(@objects, [$timeout])

Waits for at least one of the C<@objects> to become signalled.
C<$timeout> is the maximum time to wait (in milliseconds).  If
C<$timeout> is omitted or C<undef>, waits forever.  If C<$timeout> is
0, returns immediately.

The return value indicates which object ended the wait:

   +N    $object[N-1] is signalled
   -N    $object[N-1] is an abandoned mutex
    0    Timed out
  undef  An error occurred (check C<$^E> for details)

If more than one object became signalled, the one with the lowest
index is used.

=item wait_all(@objects, [$timeout])

This is the same as C<wait_any>, but it waits for all the C<@objects>
to become signalled.  The return value indicates the last object to
become signalled, and is negative if at least one of the C<@objects>
is an abandoned mutex.

=back

=head2 Deprecated Functions and Methods

Win32::IPC still supports the ActiveWare syntax, but its use is
deprecated.

=over 4

=item INFINITE

Constant value for an infinite timeout.  Omit the C<$timeout> argument
(or pass C<undef>) instead.

C<INFINITE> is only mildly deprecated.  If you have a good use for it,
feel free to continue to use it.  That is, C<< $object->wait(INFINITE) >>
is pointless, but C<< $object->wait($timeout) >> (where C<$timeout>
may or may not equal C<INFINITE>) may make sense.

=item WaitForMultipleObjects(\@objects, $wait_all, $timeout)

Warning: C<WaitForMultipleObjects> erases C<@objects>!
Use C<wait_all> or C<wait_any> instead.

=item $obj->Wait($timeout)

Similar to C<not $obj-E<gt>wait($timeout)>.

=back

=head1 INTERNALS

The C<wait_any> and C<wait_all> functions support two kinds of
objects.  Objects derived from C<Win32::IPC> are expected to consist
of a reference to a scalar containing the Win32 HANDLE as an IV.

Other objects (for which C<UNIVERSAL::isa($object, "Win32::IPC")> is
false), are expected to implement a C<get_Win32_IPC_HANDLE> method.
When called in scalar context with no arguments, this method should
return a Win32 HANDLE (as an IV) suitable for passing to the Win32
WaitForMultipleObjects API function.


=head1 DIAGNOSTICS

None.


=head1 DEPENDENCIES

None.


=head1 BUGS AND LIMITATIONS

If your program uses signal handlers (installed using C<%SIG>), and a
handled signal arrives while the program is in one of the IPC wait
functions (C<wait>, C<wait_any>, or C<wait_all>), the signal handler
will not be executed until the wait ends.  For instance, this means
you can't interrupt a wait with Control-C if you have installed a
C<$SIG{INT}> handler.

The root cause of this is that Perl defers running the signal handler
until the Perl interpreter is in a safe state.
See L<perlipc/"Deferred Signals (Safe Signals)">.  I don't know of any
proper solution to this; if you do, please let me know.

One possible workaround is to use threads, and do the wait in a
secondary thread while the main thread continues to handle signals.
The main thread could signal the secondary thread using a
L<Win32::Event> object.

Another workaround is to use a relatively short timeout.  You can
retry the wait as needed.  Each timeout gives any queued-up signal
handlers a chance to run.

=for Pod::Coverage
^constant$

=cut

# Local Variables:
# tmtrack-file-task: "Win32::IPC"
# End:
