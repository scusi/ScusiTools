#!/usr/bin/perl -w
#
# encode a given file base64
#
use MIME::Base64 qw(encode_base64);
my $file = $ARGV[0] or die "USAGE: $0 <file_to_encode>";
open(FILE, "$file") or die "$!";

while (read(FILE, $buf, 60*57)) {
    print encode_base64($buf);
}
