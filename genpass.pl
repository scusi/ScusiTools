#!/usr/bin/perl -w
#
# generate passwords
#
#
use strict;
use Getopt::Std;

$Getopt::Std::STANDARD_HELP_VERSION = "true";

getopt('hl:n:t:');
our ($opt_h,$opt_v,$opt_l,$opt_n,$opt_t);

# Password length
my $pwd_len = $opt_l || "12";
$pwd_len = int($pwd_len);

# number of passwords
my $num_pwds = $opt_n || "3";
$num_pwds = int($num_pwds);
my $gen_pwds = "0";

# type of password (alpha, num, alphanum, special, hex)
my $pwd_type = $opt_t || "alphanum";

# Standard Messages
sub VERSION_MESSAGE {print "Version 0.1 alpha";}
sub HELP_MESSAGE {
    print "USAGE: $0 [-l 12] [-n 3] [-t alphanum]\n";
    print ("-l    length of password to generate\n");
    print ("-n    number of passwords to generate\n");
    print ("-t    type of passwords to generate, can be easy, alpha, num, alphanum, hex, special\n");
}
if ($opt_h) {
    HELP_MESSAGE();
    exit;
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
    } elsif ($pwd_type eq "easy") {
        @chars = ("A" .. "F", 0 .. 9, "a" .. "z", 0 .. 9);
    } else {
        die ("Check your password type! No supported type found!\n");
    }
    my $password = "";
    if ($pwd_type eq "easy") {
        my $part1 = join("", @chars[map { rand @chars } (1 .. 4) ]);
        my $part2 = join("", @chars[map { rand @chars } (1 .. 4) ]);
        my $part3 = join("", @chars[map { rand @chars } (1 .. 4) ]);
        my $part4 = join("", @chars[map { rand @chars } (1 .. 4) ]);
        $password = join("-", $part1, $part2, $part3, $part4);
    } else {
        $password = join("", @chars[ map { rand @chars } ( 1 .. $pwd_len ) ]);
    }
    print ("$password\n");
}
