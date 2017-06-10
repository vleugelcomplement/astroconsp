#!/usr/bin/perl
use strict;
use warnings;

## How about a generic template engine?
# Or just use snips manager instead of this stuff?
# Require considerations
# Not today (2017-06-03)
##

foreach (@ARGV) {
my ($fname, $type) = split ' ', $_;
my ($dirname) = ($fname =~ m/^(.*)\//);
system("mkdir -p $dirname") if ( $dirname ); 
open my $file, '>', $fname or die $!;

my $com  = '#'; #comment sign
my $lang = ''; #some default language constructions
my $modeline = '';
my $shabang = '';
if ($fname =~ m/(?:\.c|\.cpp|\.cxx|\.cc)$/) {
    $com = '//';
}
elsif ($fname =~ m/(?:\.h|\.hpp)$/) {
    $com = '//';
    print $fname;
    $fname =~ m/(\w+)\.(\w+)$/;
    my $hname = uc $1.'_'.$2; 
    $lang = <<"END";
#ifndef $hname
#define $hname

#endif // $hname
END
    $lang = "#pragma once\n";
}
elsif ($fname =~ m/(?:\.sql|\.hs)$/) {
    $com = '--';
}
elsif ($fname =~ m/\.pl/) {
    $shabang = '#!/usr/bin/perl'."\n";
    $com = '#';
    $lang = "use strict;\nuse warnings;\n"
}
elsif ($fname =~ m/(?:\.tex|\.ltx)$/) {
    $com = '%';
    my $subfile =<< 'EOS';
\documentclass[12pt,draft,timbord]{longnotes}
\usepackage{tmath}
\usepackage{cussymb}
\usepackage{silence}
\WarningFilter{latex}{Reference}
\graphicspath{{../../img/}}

\begin{document}

\end{document}
EOS
    my $mainfile =<<'EOS'; 
\documentclass[timbord]{longnotes}
\usepackage{tmath}
\usepackage{cussymb}
\graphicspath{{img/}}

\begin{document}

\end{document}
EOS
    $lang = (defined($type) && $type eq "sub") ? $subfile : $mainfile; chomp $lang;
    $modeline = $com." "."vim:tw=100 cc=100";
}

my $border = '-'x60;
my $name = `git config user.name`; chomp $name;
my $email = `git config user.email`; chomp $email;
my $date = `LANG=C date`; chomp $date;
print $file <<EOS;
$com$border
$com Description : 
$com Author      : $name <$email>
$com Created at  : $date
$com$border
$lang
EOS
print $file $modeline if ($modeline);
}

