#! /usr/bin/perl
#---------------------------------------------------------------------
# $Id: Build.PL 224 2008-02-19 22:28:30 -0600 cmadsn $
# Copyright 2008 Christopher J. Madsen
#
# Build.PL for Win32::IPC
#---------------------------------------------------------------------

use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin; # Make sure we're using My_Build from our distribution

use My_Build;          # Our customized version of Module::Build

my $builder = My_Build->new(
  dist_name           => 'Win32-IPC',
  license             => 'perl',
  dist_author         => 'Christopher J. Madsen <perl@cjmweb.net>',
  dist_version_from   => 'lib/Win32/IPC.pm',
  requires => {
      perl               => '5.6.0',
  },
  build_requires => {
      'File::Spec'         => 0,
      'FindBin'            => 0,
      'Module::Build'      => '0.21',
      'ExtUtils::CBuilder' => '0.15',
      'Test::More'         => 0,
  },
  create_makefile_pl => 'passthrough',
  dynamic_config     => 0,
  meta_merge         => { no_index => { file => ['My_Build.pm'] }},
);

$builder->create_build_script();
