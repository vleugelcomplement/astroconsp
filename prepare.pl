#!/usr/bin/perl
use strict;
use warnings;

my ($fname) = @ARGV;
my ($dirname) = ($fname =~ m/^(.*)\//);
system("mkdir -p $dirname") if ( $dirname ); 
open my $file, '>', $fname or die $!;

my $com; #look of comment sign
my $lang; #some default language constructions
if ($fname =~ m/(?:\.c|\.cpp|\.cxx|\.cc|\.h)/) {
    $com = '//';
    
}
elsif ($fname =~ m/(?:\.sql|\.hs)/) {
    $com = '--';
}
elsif ($fname =~ m/\.pl/) {
    $com = '#';
    $lang = "use strict;\nusewarnings;\n"
}
elsif ($fname =~ m/\.tex/) {
    $com = '%';
    $lang =<< 'EOS'
\documentclass[12pt]{../../../notes}
\usepackage{silence}
\WarningFilter{latex}{Reference}
\graphicspath{{../../img/}}

\begin{document}

\end{document}
EOS
}
else {
    $com = '#';
}
my $border = '-'x60;
my $name = `git config user.name`; chomp $name;
my $email = `git config user.email`; chomp $email;
my $date = `LANG=C date`; chomp $date;
print $file <<EOS
$com$border
$com Description : 
$com Author      : $name <$email>
$com Created at  : $date
$com$border
$lang
EOS


