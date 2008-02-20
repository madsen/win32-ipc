#---------------------------------------------------------------------
package My_Build;
#
# Copyright 2007 Christopher J. Madsen
#
# Author: Christopher J. Madsen <perl@cjmweb.net>
# Created: 18 Feb 2007
# $Id: My_Build.pm 224 2008-02-19 22:28:30 -0600 cmadsn $
#
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See either the
# GNU General Public License or the Artistic License for more details.
#
# Customize Module::Build for Win32::IPC
#---------------------------------------------------------------------

use strict;
use File::Spec ();
use base 'Module::Build';

#=====================================================================
# Package Global Variables:

our $VERSION = '0.01';

#=====================================================================
sub ACTION_distdir
{
  my $self = shift @_;

  $self->SUPER::ACTION_distdir(@_);

  # Process README, inserting version number & removing comments:

  my $out = File::Spec->catfile($self->dist_dir, 'README');
  my @stat = stat($out) or die;

  unlink $out or die;

  open(IN,  '<', 'README') or die;
  open(OUT, '>', $out)     or die;

  while (<IN>) {
    next if /^\$\$/;            # $$ indicates comment
    s/\$\%v\%\$/ $self->dist_version /ge;

    print OUT $_;
  } # end while IN

  close IN;
  close OUT;

  utime @stat[8,9], $out;       # Restore modification times
  chmod $stat[2],   $out;       # Restore access permissions
} # end ACTION_distdir

#---------------------------------------------------------------------
# Compile an XS file, but use the version number from the module
# instead of the distribution's version number

sub process_xs
{
  my $self = shift @_;
  my $pm_file = $_[0];

  # Save the distribution version:
  my $dist_version = $self->dist_version;

  # Override it with the version number from the corresponding .pm file:
  $pm_file =~ s/\.xs$/.pm/i or die "$pm_file: Not an .xs file";
  my $pm_info = Module::Build::ModuleInfo->new_from_file($pm_file)
      or die "Can't find file $pm_file to determine version";

  $self->{properties}{dist_version} = $pm_info->version
      or die "Can't find version in $pm_file";

  # Now that we've tricked dist_version into lying, process the XS file:
  my $result = $self->SUPER::process_xs(@_);

  # Restore the real dist_version:
  $self->{properties}{dist_version} = $dist_version;

  return $result;
} # end process_xs

#=====================================================================
# Package Return Value:

1;
