#!/usr/bin/perl -w
#
# script that takes a list of IP adresses (one per line) on STDIN
# and returns country, name, abuse and origin AS on STDOUT 
# for the given IP 
#
# The Information returned is taken from whois records.
#
# This script is using a local caches in order to avoid duplicate 
# whois requests as well as country lookups. The caches are held in 
# /tmp/mycache. There a two seperate namespaces within the cache,
# one called 'Country' for Country lookups and another one for
# whois requests called 'Whois'.
#
# written by fwalther@vz.net
# date: Mi  6 Okt 2010 11:57:11 CEST
#
use lib "/opt/local/lib/perl5/site_perl/5.8.9/";
use lib "/opt/local/lib/perl5/vendor_perl/5.8.9/";
use Net::Whois::IP qw(whoisip_query);
use Cache::FileCache;
use Data::Dumper;
use strict;

my $country_cache = new Cache::FileCache( { cache_root => "/tmp/mycache", namespace => "Country" } );
my $whois_cache   = new Cache::FileCache( { cache_root => "/tmp/mycache", namespace => "Whois" } );
# IP HASH
# $ip => [$stamp, $stamp, $stamp]
my %ip_hash;

# RESULT HASH
# $ip => "$country\t$netname\t$abuse\t$origin";
my %result_hash;

while (<>) {
    my @stamp_list = ();
    chomp($_);
    my ($stamp,$ip) = split(/\t/, $_);
    #print("DEBUG: $stamp, $ip\n");
    if (exists $ip_hash{"$ip"}) {
        # wir haben die IP schon gesehen
	# esistierende stamps holen
	@stamp_list = $ip_hash{"$ip"};
	push(@stamp_list, $stamp);
	$ip_hash{"$ip"} = @stamp_list;;

    } else {
        # die IP ist neu
	push(@stamp_list, $stamp);
	$ip_hash{"$ip"} = @stamp_list;;
    }
    my $country = "??";
    my $netname = "UNKNOWN_NAME";
    my $abuse   = "NO_ABUSE";
    my $origin  = "NO_ORIGIN_AS";
    my $optional_multiple_flag = 0;
    my $option_array_of_search_options = 0;
    my $resp;
    $resp = $whois_cache->get( $ip );
    if ( not defined $resp ) {
        ($resp) = whoisip_query($ip);
	$whois_cache->set( $ip, $resp, "72 hours" );
    }
    #print Dumper($resp);
    my @keys = keys %$resp;
    #print Dumper(@keys);
    foreach my $k (@keys) {
        my $lk = lc($k);
	if ($lk=~m/country/) {
	    $country = $resp->{"$k"} || "XX";
	    #print("DEBUG Country: $country\n");
	    $country = $country_cache->get( $country  );
	    #print("DEBUG Country: $country\n");
	} elsif ($lk=~m/netname/) {
	    $netname = $resp->{"$k"} || "$netname";
	} elsif ($lk=~m/abuse|email/) {
	    $abuse = $resp->{"$k"} || "$abuse";
	} elsif ($lk=~m/origin/) {
	    $origin = $resp->{"$k"} || "$origin";
	}
    }
    ## Anzeige
    # IP	LAND	NETNAME	ABUSE	ORIGIN
    print("$stamp\t$ip\t$country\t$netname\t$abuse\t$origin\n");
    $result_hash{"$ip"} = "$country\t$netname\t$abuse\t$origin";
}

#print Dumper(%ip_hash);
#printf("=" x 79 . "\n");
#print Dumper(%result_hash);
