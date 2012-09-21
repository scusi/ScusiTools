#!/usr/bin/perl -w
#
# script to decode base64 files
#
# use like this: 
#  ./decode_b64_file.pl myfile.b64 > myfile.bin
#  ./decode_b64_file.pl myfile.b64 | hexdump -c
#
# scusi@snurn.de
# 15.09.2010
use strict;
use MIME::Base64;

my $in_file = shift || die "USAGE: $0 <file>";
chomp($in_file);
print("Input File is: $in_file\n");

my $data;

if ($in_file eq "-") {
    open(IN,<>); 
    binmode(IN);
    while (<IN>) {
	$data .= $_;
    }
    close IN;

} else {
    open(IN,"<$in_file");
    binmode(IN);
    while (<IN>) {
        $data .= $_;
    }
    close IN;
}

my $decoded_data = decode_base64("$data");
print("\n");
print("$decoded_data");
print("\n");

