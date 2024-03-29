#!/usr/bin/perl
# Scott Hall
# mkdd.pl
# 20220120
# Create device_description file for ghetto rex
# Send refdes list on STDIN
# Output to STDOUT
use strict;
use warnings;

print 'PD|$BOARD|$BOARD_1|$BOARD_2|$BOARD_3|$BOARD_4|$BOARD_5|
';
my @refdes;
if ( $ARGV[0] eq "PART" ) {
    @refdes = map sprintf("PART%02d", $_), 1 .. $ARGV[1];
} else {
    chomp( @refdes = grep /\w+/, sort <> );
}

for my $refdes (@refdes) {
    print "PD|$refdes|GENERIC|PARTNO|DESC|LOCATION|BIN|\n";
}
