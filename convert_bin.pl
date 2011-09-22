#!/usr/bin/perl -w
#
# ascript to convert decimal to binary and binary to decimal.
#
# scusi at snurn dot de
# 20100917 20:20 CEST
#
use strict;

my $mode = $ARGV[0] || die "USAGE: $0 <mode> <num>";
my $num  = $ARGV[1] || die "USAGE: $0 $mode <num>";
my $out = "";

if ($mode eq "dec2bin") {
    $out = dec2bin($num);
} elsif ($mode eq "bin2dec") {
    $out = bin2dec($num);
}

print("$num $mode = $out\n");

#my $bin_num = "0010100100111";
#print ("binary: $bin_num \n");
#my $dec_num = bin2dec( $bin_num );
#print ("decimal: $dec_num \n");


## SUBS ######################################################################
# isbin - checks if input is binary
# isdec - checks if input is decimal input

# dec2bin - takes a decimal number and returns binary representation
sub dec2bin {
    my $str = unpack("B32", pack("N", shift));
    $str =~ s/^0+(?=\d)//; # otherwise you get leading zeros
    return $str;
}

# bin2dec - takes binary number and returns decimal representation
sub bin2dec {
    return unpack("N", pack("B32", substr("0" x 32 . shift, -32)));
}
