#!/usr/bin/perl -w
#
# Ein Script um zu checken wohin eine Kurz-URL verweist.
#
# scusi@snurn.de 03.08.2010
#
use lib "/opt/local/lib/perl5/site_perl/5.8.9/";
use lib "/opt/local/lib/perl5/vendor_perl/5.8.9/";
use strict;
use CGI;
use Data::Validate::URI qw(is_web_uri);
require LWP::UserAgent;
use Data::Dumper;
use HTTP::Response;

my $q = CGI->new;
my $usurl = $q->param('surl');
my $surl = "";
# input validieren
if ( is_web_uri( $usurl ) ) {
    # URL ist gueltig
    $surl = $usurl;
    #print (" $surl\n");	# DEBUG
} else {
    # URL ist ungueltig
    #die "url was not valid!";
    $surl = $usurl;
}

# kurz-url anfragen
my $ua = LWP::UserAgent->new;
$ua->requests_redirectable([]);
$ua->timeout(10);
$ua->env_proxy;

my $response = $ua->get($surl);

if ($response->is_success) {
    #print $response->decoded_content;  # or whatever
    #print Dumper( $response->header_field_names );
    print ("Location: " . $response->header("Location") . "\n");
    #print Dumper( $response ); 
} else {
    print ("Location: " . $response->header("Location") . "\n");
    print ("Response Code: " . $response->status_line . "\n");
}
