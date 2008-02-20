#! /usr/bin/perl
#---------------------------------------------------------------------
# $Id: t/pod.t 224 2008-02-19 22:28:30 -0600 cmadsn $
#---------------------------------------------------------------------

use Test::More;

eval "use Test::Pod 1.14";
plan skip_all => "Test::Pod 1.14 required for testing POD" if $@;

all_pod_files_ok();
