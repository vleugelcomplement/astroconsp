#!/usr/bin/env perl

use strict;
use warnings;
use open qw< :encoding(UTF-8) >;

my ($texdocname, $type) = @ARGV;
my $DEBUG = $ENV{DEBUG};
if (not defined($texdocname) or not defined($type) ) { die "wrong args"; }

my $tmpname = "/tmp/settype_temp";
open my $texin, '<', $texdocname or die $!;
open my $texout, '>', $tmpname or die $!;

while (<$texin>) {
    if (/^\\documentclass/) {
        my ($cmd, $opts, $cls) = /\\(\w+)(?:\[((?:\d|\w|,)+)\])?\{(\w+)\}/;
        if (defined($opts)) {
            $opts =~ s/draft/final/;
            my @opts = split /,/, $opts;
            $opts[$#opts] = $type;
            $opts = join ",", @opts;
            $opts = "[$opts]";
        } else {
            $opts='';
        }
        $_ = "\\$cmd"."$opts"."{$cls}\n";
        print $_ if ($DEBUG);
    }
    print $texout $_;
}
close $texin;
close $texout;

system("cp $tmpname $texdocname");
