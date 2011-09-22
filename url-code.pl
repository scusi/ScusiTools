#!/usr/bin/perl -w
#
# script to encode and decode URL strings
# 
# written by: fwalther@vz.net
# Q2 2010
#
use strict;
my $help = <<EOF;
$0 help

USAGE:
  $0 "string" <action>

string is a text string either url-encoded or not.

<action> can be either 'd' or 'e'.
'd' means (URL-)decode string
'e' means (URL-)encode string

EXAMPLES:

 $0 "florian%2Ewalther%40gmail%2Ecom" d
 url decodes the give string

 $0 "florian.walther\@gmail.com" e
 url encodes the given string

AUTHOR:
$0 was written by fwalther\@vz.net
EOF

my $action = $ARGV[1] || "d";
my $str = $ARGV[0] || die "$help";

if ($action eq "d") {
    # d == decode string
    $str =~ s/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg;
    print ("$str");
} else {
    # e == encode string
    $str =~ s/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg;
    print ("$str");
}
print "\n";
