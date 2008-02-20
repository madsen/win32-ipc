# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..9\n"; }
END {print "not ok 1\n" unless $loaded;}
use Win32::Semaphore;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

my $test = 1;

my $s = Win32::Semaphore->new(3,3) or die "Can't create semaphore";
++$test; print "ok $test\n";

print 'not ' unless $s->wait(10);
++$test; print "ok $test\n";

print 'not ' unless $s->wait(0);
++$test; print "ok $test\n";

printf "If you don't see `ok %d' immediately, you'd better hit Ctrl-C\n",
       $test+1;
print 'not ' unless $s->wait;
++$test; print "ok $test\n";

print 'not ' if $s->wait(0);
++$test; print "ok $test\n";

print 'not ' unless $s->release;
++$test; print "ok $test\n";

print 'not ' unless $s->release(1);
++$test; print "ok $test\n";

my $result;
print 'not ' unless $s->release(1,$result) and $result == 2;
++$test; print "ok $test\t(\$result is $result)\n";
