#!/usr/bin/perl -w
#
# generate passwords
#
#
use strict;
use Getopt::Std;

$Getopt::Std::STANDARD_HELP_VERSION = "1";

getopt('hl:n:t:');
our ($opt_l,$opt_n,$opt_t);

# Password length
my $pwd_len = int $opt_l || "12";

# number of passwords
my $num_pwds = int $opt_n || "3";
my $gen_pwds = "0";

# type of password (alpha, num, alphanum, special, hex)
my $pwd_type = $opt_t || "alphanum";

# Standard Messages
sub VERSION_MESSAGE {print "Version 0.1 alpha";}
sub HELP_MESSAGE {
    print "USAGE: $0 [-l 12] [-n 3] [-t alphanum]\n";
    print ("-l    length of password to generate\n");
    print ("-n    number of passwords to generate\n");
    print ("-t    type of passwords to generate, can be alpha, num, alphanum, hex, special\n");
}

while ($gen_pwds < $num_pwds) {
    &gen_passwd();
    $gen_pwds++;
}

sub gen_passwd {
    my @chars = ( "A" .. "Z", "a" .. "z", 0 .. 9 );
    if ($pwd_type eq "num") {
        @chars = ( 0 .. 9 );
    } elsif ($pwd_type eq "alpha") {
        @chars = ( "A" .. "Z", "a" .. "z" );
    } elsif ($pwd_type eq "alphanum") {
        @chars = ( "A" .. "Z", "a" .. "z", 0 .. 9 );
    } elsif ($pwd_type eq "special") {
        @chars = ( "A" .. "Z", "a" .. "z", 0 .. 9, qw(+ - _ ? = ! @ $ % ^ & * :) );
    } elsif ($pwd_type eq "hex") {
        @chars = ( "A" .. "F", 0 .. 9 );
    } else {
        die ("Check your password type! No supported type found!\n");
    }
    my $password = join("", @chars[ map { rand @chars } ( 1 .. $pwd_len ) ]);
    print ("$password\n");
}
