#!/usr/bin/perl -w
#
# HTTP Header auslesen
#
#
#use lib "/opt/local/lib/perl5/site_perl/5.8.9/";
#use lib "/opt/local/lib/perl5/vendor_perl/5.8.9/";
use lib "/opt/local/lib/perl5/site_perl/5.12.3/";
use strict;
use LWP::UserAgent;
use Getopt::Std;
use Data::Validate::URI qw(is_web_uri);

## initialize Getopt
getopt('r:a:u:m:');
our ($opt_h, $opt_r, $opt_a, $opt_u, $opt_m);
$opt_r = 1 unless $opt_r;
$opt_m = 'HEAD' unless $opt_m;

# pre set variables 
my $url = "http://localhost/";
my $ua = undef;

## build HELP message ########################################################
my $help = <<EOF;
$0 help

$0 - 'speak' HTTP from the commandline

USAGE:
    $0 -u http://scusiblog.org/

OPTIONS:
    -u <URL>		- set URL (mandantory)

    -r 1 		- follow redirect
    -r 0		- do not follow redirect
    			  default is not follow redirects

    -a "Mozilla/5.2"	- set UserAgent (optional)
    			  default is no UserAgent

    -m "GET"		- http method to use ( HEAD | GET | POST | TRACE )
                          default is HEAD

AUTHOR:
    Florian 'scusi' Walther <scusi at snurn dot de>

EOF
#############################################################################
## print HELP
if ($opt_h) {
    print $help;
    exit;
} 

## SETUP and REDIRECT Settings
if ($opt_r=~m/0/) {
    $ua = LWP::UserAgent->new(
        max_redirect => 0,
        requests_redirectable => [],
    );
    $ua->redirect_ok("false");
} elsif ($opt_r=~m/1/) {
    $ua = LWP::UserAgent->new(
        max_redirect => 3,
        requests_redirectable => ['GET', 'HEAD'],
    );
} else {
    $ua = LWP::UserAgent->new(
        max_redirect => 3,
        requests_redirectable => [],
    );
}

## set USER AGENT
if ($opt_a) {
    $ua -> agent("$opt_a");
} else {
    $ua->agent("");	# do not identify
}

## set and validate URI
if ($opt_u) {
    $url = is_web_uri($opt_u) || die ("usage: $0 -u <valid URL>");
}

## set METHOD
my $method = undef;
if ($opt_m) {
    $method = "$opt_m";
}

## build REQUEST
my $request = new HTTP::Request $method => $url;
print "$method Request to $url...\n\n";

## print RESPONSE
my $result = $ua->request($request);
print ( $result -> as_string . "\n");
