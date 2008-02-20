#! /usr/bin/perl
#---------------------------------------------------------------------
# $Id: t/01-load.t 226 2008-02-20 00:50:08 -0600 cmadsn $
#---------------------------------------------------------------------

use Test::More tests => 1;

BEGIN {
    use_ok('Win32::ChangeNotify');
}

diag("Testing Win32::ChangeNotify $Win32::ChangeNotify::VERSION");
