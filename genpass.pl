#!/usr/bin/perl -w
#
# generate passwords
#
#
use strict;
use Getopt::Std;

$Getopt::Std::STANDARD_HELP_VERSION = "1";

getopt('hl:n:');
our ($opt_l,$opt_n);

# Password length
my $pwd_len = $opt_l || "12";

# number of passwords
my $num_pwds = $opt_n || "3";
my $gen_pwds = "0";

sub VERSION_MESSAGE {print "Version 0.1 alpha";}
sub HELP_MESSAGE {print "Don't Panic!";}

while ($gen_pwds < $num_pwds) {
    &gen_passwd();
    $gen_pwds++;
}

sub gen_passwd {
    my @chars = ( "A" .. "Z", "a" .. "z", 0 .. 9, qw(+ - _ ? = ! @ $ % ^ & * :) );
    my $password = join("", @chars[ map { rand @chars } ( 1 .. $pwd_len ) ]);
    print ("$password\n");
}
