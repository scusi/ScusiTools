#!/usr/bin/perl -w
#
# script to delete all entries from the abuse cache used be whois_ip_list.pl
#
# written by fwalther@vz.net
# 
use lib "/opt/local/lib/perl5/site_perl/5.8.9/";
use lib "/opt/local/lib/perl5/vendor_perl/5.8.9/";
use strict;
use Data::Dumper;
use Net::Abuse::Utils qw( :all );
use Cache::FileCache;
my $whois_cache   = new Cache::FileCache( { cache_root => "/tmp/mycache", namespace => "Whois" } );
my $country_cache = new Cache::FileCache( { cache_root => "/tmp/mycache", namespace => "Country" } );

$whois_cache->clear();
print("Whois cache cleared\n");
$country_cache->clear();
print("Country cache cleared\n");
