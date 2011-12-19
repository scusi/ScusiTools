#!/usr/bin/perl
#
# script to convert human readable IPs into intgers or the other way round.
#
# written by: scusi@snurn.de
# somewhen 2010
#
use Socket;

$type = shift || die ("USAGE $0 <TYPE> <IP(N)>");
$ipnumber = shift || die ("USAGE $0 <TYPE> <IP(N)>");

if ( $type eq "ip" ) {
    print "IP   : $ipnumber\n";
    $ipn = ip2ipn( $ipnumber );
    if ( $ipn ) {
        print "IPN  : $ipn\n";
    }
} elsif ( $type eq "ipn" ) {
    print "IPN : $ipnumber\n";
    $ip = ipn2ip( $ipnumber );
    if ($ip) {
        print "IP  : $ip\n";
    }

}

sub ip2ipn {
     return unpack 'N', inet_aton(shift);
}

sub ipn2ip {
    return inet_ntoa( pack 'N', shift );
}
