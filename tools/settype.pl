#!/usr/bin/env perl

use strict;
use warnings;
use open qw< :encoding(UTF-8) >;

my ($texdocname, $type) = @ARGV;
if (not defined($texdocname) or not defined($type) ) { die "wrong args"; }

my $tmpname = "/tmp/settype_temp";
open my $texin, '<', $texdocname or die $!;
open my $texout, '>', $tmpname or die $!;

while (<$texin>) {
    if (/\\documentclass/) {
        s/\\documentclass(?:\[(\d\dpt,)?[^]]*\])?{/\\documentclass[$1$type]{/
    }
    print $texout $_;
}
close $texin;
close $texout;

system("cp $tmpname $texdocname"); 
