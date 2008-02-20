#! /usr/bin/perl
#---------------------------------------------------------------------
# $Id: t/04-load.t 226 2008-02-20 00:50:08 -0600 cmadsn $
#---------------------------------------------------------------------

use Test::More tests => 1;

BEGIN {
    use_ok('Win32::Semaphore');
}

diag("Testing Win32::Semaphore $Win32::Semaphore::VERSION");
