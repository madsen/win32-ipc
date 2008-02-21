#! /usr/bin/perl
#---------------------------------------------------------------------
# $Id: t/40-Semaphore.t 238 2008-02-20 22:09:52 -0600 cmadsn $
#
# Test Win32::Semaphore
#---------------------------------------------------------------------

use strict;
use Test::More tests => 12;

use Win32::Semaphore;

diag(<<'END_WARNING');
This test should take no more than 10 seconds.
If it takes longer, please kill it with Ctrl-Break (Ctrl-C won't work right).
END_WARNING

my $s = Win32::Semaphore->new(3,3);
ok(1, 'created $s');

isa_ok($s, 'Win32::Semaphore');

is($s->wait(10), 1, 'wait(10)');

is($s->wait(0), 1, 'wait(0)');

is($s->wait, 1, 'wait()');

is($s->wait(0), 0, 'wait(0) times out');

is($s->wait(10), 0, 'wait(10) times out');

ok($s->release, 'release');

is($s->wait(0), 1, 'wait(0) succeeds now');

ok($s->release(1), 'release(1)');

my $result;
ok($s->release(1,$result), 'release(1,$result)');
is($result, 1, 'count was 1');
