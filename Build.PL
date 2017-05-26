#! /usr/bin/perl
#---------------------------------------------------------------------
# Build.PL for Win32::IPC
#
# Copyright 2010 Christopher J. Madsen
#---------------------------------------------------------------------

use strict;
use warnings;

use lib '.';
use inc::My_Build;           # Our customized version of Module::Build

unless ($^O eq "MSWin32" || $^O eq "cygwin") {
  die "OS unsupported\n";
}

my $builder = inc::My_Build->new(
  dist_name           => 'Win32-IPC',
  license             => 'perl',
  dist_abstract       => 'Use Win32 synchronization objects',
  dist_author         => 'Christopher J. Madsen <perl@cjmweb.net>',
  dist_version_from   => 'lib/Win32/IPC.pm',
  add_to_cleanup      => ['vc*.pdb'],
  # Prerequisites inserted by DistZilla:
##{ $plugin->get_prereqs ##}
);

$builder->create_build_script();
