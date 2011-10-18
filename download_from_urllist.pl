#!/usr/bin/perl -w
#
# script to download all urls contained in a textfile.
# 
# USAGE: cat urllist.txt | ./dwonload_from_urllist.pl
#
use strict;
use File::Basename;
use LWP::Simple;

#my $OutputDir = $ARGV[0] || ".";

my $OutputDir = "/tmp";
chomp($OutputDir);
print ("OutputDir is: $OutputDir\n");

while (<>) {
    chomp $_;
    print ("URL is: $_\n");
    my $file = $OutputDir ."/". basename($_);
    print ("File will be: $file\n");
    my $resp_code = getstore($_, $file);
    if ($resp_code eq '200') {
    	print ("downloaded $_ to $file\n");
    } else {
    	print ("something went wrong for $_, response code was: '$resp_code'\n");
    }
}
