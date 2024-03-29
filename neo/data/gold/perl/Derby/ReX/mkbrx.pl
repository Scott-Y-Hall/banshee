#!/usr/bin/perl
# Scott Hall
# Jennifer Jones
# mkbrx.pl
# 20050421
# Create board.rx for ghetto rex
# Send refdes list on STDIN
# Output to STDOUT
use strict;
use warnings;
use POSIX 'ceil';

print "VERSION 1.1 RX-DIF\n",
  "RESOLUTION\n{\nUNIT_SCALE    1\nUNIT_TYPE    INCHES\n}\n",
  "LAYER_INFO\n{\n0 {DRILL} DRILL\n1 {TOP} TOP\n",
  "2 {BOTTOM} BOTTOM\n3 {OUTLINE} OUTLINE\n}\n",
  "FLASHLAYER 1\n{\n}\n", "TRACELAYER 1\n{\n}\n", "DRILL\n{\n}\n",
  "APERTURE\n{\n}\n", "COMPONENT_DEFINITIONS \n{\n";
my $width  = 7;
my $height = 5;
print "0 1 -$height $height $width -$width\n", "PADS 1\n{\n1 -4 0\n}\n}\n",
  "COMPONENT_LIST\n{\n";
my $count = 0;
my $x;
my $y;
chomp( my @refdes = 
    grep !/\$BOARD/,
    map { /^PD\|([^\|]*)\|/ ? $1 : $_ }
    grep /\w+/,
    sort <> );
my $root = ceil sqrt(@refdes);
#print $root; print for @refdes; exit;
for my $refdes (@refdes) {
    $x = ( $count % $root ) * $width * 3;
    $y = -int( $count / $root ) * $height * 3;
    print "$count" . ( " " x ( 5 - length $count ) ),
      "$refdes" . ( " " x ( 30 - length $refdes ) ),
      ( " " x ( 8 - length $x ) ) . "$x", ( " " x ( 8 - length $y ) ) . "$y",
      " 4 T 1\n";
    $count++;
}

print "}\nNETS\n{\n}\nCOMPONENT_GROUP\n{\n}\n";

#SSprint "}\nNETS\n{\n}\nCOMPONENT_GROUP \"CLASSES\"\n{\nGROUP BOARD 1\n{\n";
#SSprint "$_\n" for @refdes;
#SSprint "}\n}\nCOMPONENT_GROUP \"PART NUMBERS\"\n{\nGROUP 1 1\n{\n";
#SSprint "$_\n" for @refdes;
#SSprint "}\n}\nCOMPONENT_GROUP \"PACKAGES\"\n{\nGROUP 1 1\n{\n";
#SSprint "$_\n" for @refdes;
#SSprint "}\n}\n";
