#---------------------------------------------------------------------
package tools::IPCTemplate;
#
# Copyright 2010 Christopher J. Madsen
#
# Author: Christopher J. Madsen <perl@cjmweb.net>
# Created:  8 Dec 2010
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either the
# GNU General Public License or the Artistic License for more details.
#
# ABSTRACT: Pod::Loom template for Win32-IPC
#---------------------------------------------------------------------

our $VERSION = '1.08';

use 5.008;
use Moose;
extends 'Pod::Loom::Template::Default';
##with 'Pod::Loom::Role::Extender';

##sub remap_sections { {
##  AUTHOR => [qw[ AUTHOR ACKNOWLEDGMENTS ]],
##} }

my %was_activeware = map { $_ => 1 } qw(
  Win32::ChangeNotify
  Win32::IPC
  Win32::Mutex
  Win32::Semaphore
);

#---------------------------------------------------------------------
sub was_activeware
{
  return $was_activeware{shift->module};
} # end was_activeware

#---------------------------------------------------------------------
override section_AUTHOR => sub {
  my ($self, $title) = @_;

  my $section = super();

  $section .= <<'END AUTHOR' if $self->was_activeware;

Loosely based on the original module by ActiveWare Internet Corp.,
L<http://www.ActiveState.com>
END AUTHOR

  return $section;
}; # end section_AUTHOR

#---------------------------------------------------------------------
override section_CONFIGURATION_AND_ENVIRONMENT => sub {

  return super() . <<"END CONFIGURATION";

It runs under 32-bit or 64-bit Microsoft Windows, either natively or
under Cygwin.
END CONFIGURATION
}; # end section_CONFIGURATION_AND_ENVIRONMENT

#---------------------------------------------------------------------
override section_COPYRIGHT_AND_LICENSE => sub {
  my ($self, $title) = @_;

  return super() unless $self->was_activeware;

  return <<"END COPYRIGHT";
=head1 $title

Copyright 1998-{{\$zilla->copyright_year}} Christopher J. Madsen

Created: 3 Feb 1998 from the ActiveWare version
  (c) 1995 Microsoft Corporation. All rights reserved.
      Developed by ActiveWare Internet Corp., http://www.ActiveState.com

  Other modifications (c) 1997 by Gurusamy Sarathy <gsar AT cpan.org>

This module is free software; you can redistribute it and/or modify it
under the same terms as the Perl 5 programming language system itself.
END COPYRIGHT
}; # end section_COPYRIGHT_AND_LICENSE

#---------------------------------------------------------------------
sub section_INCOMPATIBILITIES
{
  my ($self, $title) = @_;

  return <<"END INCOMPATIBILITIES";
=head1 $title

Prior to version 1.06, the Win32 IPC modules treated C<undef> values
differently.  In version 1.06 and later, passing C<undef> as the value
of an optional parameter is the same as omitting that parameter.  In
previous versions, C<undef> was interpreted as either the empty string
or 0 (along with a warning about "Use of uninitialized value...").
END INCOMPATIBILITIES
} # end section_INCOMPATIBILITIES

#=====================================================================
# Package Return Value:

no Moose;
__PACKAGE__->meta->make_immutable;
1;
