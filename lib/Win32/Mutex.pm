#---------------------------------------------------------------------
package Win32::Mutex;
#
# Copyright 1998-2008 Christopher J. Madsen
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
# ABSTRACT: Use Win32 mutex objects from Perl
#---------------------------------------------------------------------

use strict;
use warnings;
use vars qw($VERSION @ISA @EXPORT_OK);

use Win32::IPC 1.00 '/./';      # Import everything

BEGIN
{
  $VERSION = '1.08';
  # This file is part of {{$dist}} {{$dist_version}} ({{$date}})

  @ISA = qw(Win32::IPC);        # Win32::IPC isa Exporter
  @EXPORT_OK = qw(
    wait_any wait_all INFINITE
  );

  require XSLoader;
  XSLoader::load('Win32::Mutex', $VERSION);
} # end BEGIN bootstrap

# Deprecated ActiveWare functions:
sub Create  { $_[0] = Win32::Mutex->new(@_[1..2]) }
sub Open  { $_[0] = Win32::Mutex->open($_[1]) }
*Release = \&release;           # Alias release to Release

1;
__END__

=head1 SYNOPSIS

	require Win32::Mutex;

	$mutex = Win32::Mutex->new($initial,$name);
	$mutex->wait;

=head1 DESCRIPTION

This module allows access to the Win32 mutex objects.  The C<wait>
method and C<wait_all> & C<wait_any> functions are inherited from the
L<Win32::IPC> module.

=head2 Methods

=over 4

=item $mutex = Win32::Mutex->new([$initial, [$name]])

Constructor for a new mutex object.  If C<$initial> is true, requests
immediate ownership of the mutex (default false).  If C<$name> is
omitted or C<undef>, creates an unnamed mutex object.

If C<$name> signifies an existing mutex object, then C<$initial> is
ignored and the object is opened.  If this happens, C<$^E> will be set
to 183 (ERROR_ALREADY_EXISTS).

=item $mutex = Win32::Mutex->open($name)

Constructor for opening an existing mutex object.

=item $mutex->release

Release ownership of a C<$mutex>.  You should have obtained ownership
of the mutex through C<new> or one of the wait functions.  Returns
true if successful, or zero if it fails (additional error
information can be found in C<$^E>).

=item $mutex->wait([$timeout])

Wait for ownership of C<$mutex>.  See L<Win32::IPC>.

If this thread has already obtained ownership of C<$mutex>, additional
calls to C<wait> will always succeed.  You must call C<release> once
for each successful call to C<wait>.

=back

=head2 Deprecated Functions and Methods

Win32::Mutex still supports the ActiveWare syntax, but its use is
deprecated.

=over 4

=item Create($MutObj,$Initial,$Name)

Use C<$MutObj = Win32::Mutex-E<gt>new($Initial,$Name)> instead.

=item Open($MutObj,$Name)

Use C<$MutObj = Win32::Mutex-E<gt>open($Name)> instead.

=item $MutObj->Release()

Use C<$MutObj-E<gt>release> instead.

=back

=head1 DIAGNOSTICS

None.


=head1 DEPENDENCIES

L<Win32::IPC>

=cut

# Local Variables:
# tmtrack-file-task: "Win32::Mutex"
# End:
