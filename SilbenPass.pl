#!/usr/bin/perl -w
#
# Silben Listen von http://www.sttmedia.de/silbenhaeufigkeit-deutsch
# Erstellt durch: Stefan Trost, stefantrost.de, http://www.stefantrost.de/kontakt
#
# 3stellige Silben 
my @silben_3 = qw(ABE ACH AND AUF AUS BEN BER CHE CHT DAS DEN DER DIE EIN EIT END ERE ERS ESE GEN HEN ICH IGE INE IST LIC LLE MEN MIT NDE NEN NGE NIC NTE REN SCH SEI SEN SIC SIE STE TEN TER UND UNG VER ICH EIN DER SCH DIE UND CHE CHT DEN GEN INE TEN UNG HEN NDE LIC VER SIE STE NEN EIT BER TER NGE DAS ACH ERS AND REN NIC ERE SIC IST LLE BEN AUF ABE END SEN SEI MIT MEN IGE AUS NTE ESE);
#
# 2 stellige Silben
my @silben_2 = qw(AN AU BE CH DA DE DI EI EL EN ER ES GE HE HT IC IE IN IT LE LI ND NE NG RE SC SE SI ST TE UN EN ER CH DE EI IE IN TE GE UN ND IC ES BE HE ST NE AN RE SE DI SC AU NG SI LE DA IT HT EL LI);
#
# 
#print ( join("-", @silben_2[map { rand @silben_2 } (1 .. 4) ]), "\n");
#print ( join("-", @silben_3[map { rand @silben_3 } (1 .. 4) ]), "\n");

print ( chr(0x263a) , "\n" );
print ( map(chr, qw(65 66 67)), "\n");
