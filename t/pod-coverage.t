#! /usr/bin/perl
#---------------------------------------------------------------------
# $Id: t/pod-coverage.t 224 2008-02-19 22:28:30 -0600 cmadsn $
#---------------------------------------------------------------------

use Test::More;

eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;

my @private = map { qr/^$_$/ } qw(
  constant Create Open
);

all_pod_coverage_ok({ also_private => \@private });
