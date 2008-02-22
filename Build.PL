#! /usr/bin/perl
#---------------------------------------------------------------------
# $Id: Build.PL 244 2008-02-21 23:28:42 -0600 cmadsn $
# Copyright 2008 Christopher J. Madsen
#
# Build.PL for Win32::IPC
#---------------------------------------------------------------------

use strict;
use warnings;

use FindBin;
use lib $FindBin::Bin; # Make sure we're using My_Build from our distribution

use My_Build;          # Our customized version of Module::Build

unless ($^O eq "MSWin32" || $^O eq "cygwin") {
  die "OS unsupported\n";
}

my $builder = My_Build->new(
  dist_name           => 'Win32-IPC',
  license             => 'perl',
  dist_abstract       => 'Use Win32 synchronization objects',
  dist_author         => 'Christopher J. Madsen <perl@cjmweb.net>',
  dist_version_from   => 'lib/Win32/IPC.pm',
  requires => {
    perl                 => '5.6.0',
    XSLoader             => 0,
  },
  build_requires => {
    'File::Spec'         => 0,
    'FindBin'            => 0,
    'Module::Build'      => '0.21',
    'ExtUtils::ParseXS'  => 0, # Had problems with 5.8.8's xsubpp
    'ExtUtils::CBuilder' => '0.15',
    'Test::More'         => 0,
  },
  create_makefile_pl => 'passthrough',
  dynamic_config     => 0,
  meta_merge         => {
    no_index  => { file     => ['My_Build.pm'] },
    resources => { homepage => 'http://code.google.com/p/libwin32/' },
  },
);

$builder->create_build_script();
