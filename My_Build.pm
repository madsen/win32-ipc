#---------------------------------------------------------------------
package My_Build;
#
# Copyright 2007 Christopher J. Madsen
#
# Author: Christopher J. Madsen <perl@cjmweb.net>
# Created: 18 Feb 2007
# $Id: My_Build.pm 233 2008-02-20 19:02:43 -0600 cmadsn $
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

  # Get the version number from the corresponding .pm file:
  $pm_file =~ s/\.xs$/.pm/i or die "$pm_file: Not an .xs file";
  my $pm_info = Module::Build::ModuleInfo->new_from_file($pm_file)
      or die "Can't find file $pm_file to determine version";

  # Tell dist_version to use it:
  local $self->{My_Build__pm_version} = $pm_info->version
      or die "Can't find version in $pm_file";

  # Now that dist_version is lying, process the XS file:
  $self->SUPER::process_xs(@_);
} # end process_xs

#---------------------------------------------------------------------
# Lie about the version number when necessary:

sub dist_version
{
  my $self = shift @_;

  return $self->{My_Build__pm_version}
      if defined $self->{My_Build__pm_version};

  $self->SUPER::dist_version(@_);
} # end dist_version

#=====================================================================
# Package Return Value:

1;
