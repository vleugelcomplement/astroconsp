%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Класс для всяких конспектов и заметок
%  Определены всякие нужные окружения 
%+ и настроены(вроде) перекрёстные ссылки
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
% plain notes have only sections
% long notes are more like a report, with chapters and paragraphs
\ProvidesClass{longnotes}[2017/05/27 Long version of notes]
\def\@baseclass{report}
\def\@styles{timbord,ebook,hardcopy}
\def\@stylesfs{12pt,timbord,12pt,ebook,10pt,hardcopy}

%language setting to handle cyrrilic in expansions

%% pdf search
\RequirePackage{cmap}
\RequirePackage{etoolbox}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[english,russian]{babel}
\RequirePackage[a4paper]{geometry}

% \RequirePackage{trace}

\newcommand\for@expnd@list[2]{\expandafter\forcsvlist\expandafter#1\expandafter{#2}}
\newcommand\do@expnd@list[1]{\expandafter\docsvlist\expandafter\expandafter{#1}}
\newcommand*\set@bool@opt[1]{
  \newtoggle{#1}
  \DeclareOption{#1}{\toggletrue{#1}}
}
\for@expnd@list{\set@bool@opt}{tikz,draft,exam}

% hackery, no variants here
\newtoggle{parseopt}\toggletrue{parseopt}
\def\tmp@def#1#2{
  \newtoggle{#2}
  \DeclareOption{#2}{\PassOptionsToClass{#1}{\@baseclass}\toggletrue{#2}}
} % too much \expandafters's, hence additional macro above
\let\ex@f\expandafter
\newcommand*\set@sty@opt[1]{
  \iftoggle{parseopt}
  {\def\@opt{#1}\togglefalse{parseopt}}
  {\ex@f\tmp@def\ex@f{\@opt}{#1}\toggletrue{parseopt}}
}
\for@expnd@list{\set@sty@opt}{\@stylesfs}
% one can only increase a font in opts, seems to be temporary limitation

\newcommand*\set@passing@opt[1]{
  \DeclareOption{#1}{\PassOptionsToClass{\CurrentOption}{\@baseclass}}
}
\forcsvlist{\set@passing@opt}{10pt,12pt}

%% Fallback                                  
\DeclareOption*{
    \ClassWarning{notes}{'Notes' class don't know about '\CurrentOption'}
    \PassOptionsToClass{\CurrentOption}{\@baseclass}
}

\ProcessOptions\relax

\LoadClass{\@baseclass}

% processing style toggles
\newcommand*\req@pkg@opt[1]{\iftoggle{#1}{\RequirePackage{#1}}{}}
\for@expnd@list{\req@pkg@opt}{\@styles}


\RequirePackage[pdftex]{graphicx}
\RequirePackage{xcolor}
\RequirePackage{verbatim}
\RequirePackage{epigraph}

% table stuff
\RequirePackage{tabulary}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{array}


\RequirePackage{calc}
% hspace somehow not fixed by calc, fixing it here
\def\@hspace#1{\begingroup\setlength\dimen@{#1}\hskip\dimen@\endgroup}

\RequirePackage[shortlabels]{enumitem}

\iftoggle{tikz}{
  \RequirePackage{tikz}
  \usetikzlibrary{calc,babel,arrows}
  \usetikzlibrary{arrows,decorations.markings,quotes,angles}
}{}

\iftoggle{draft}{
  \newcommand\texorpdfstring[2]{#1}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sectioning styles (ToC, numbering,etc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{titlesec}
\RequirePackage{titletoc}

\titleformat{\chapter}%
{\normalfont\LARGE\bfseries}%
{Глава \ \thechapter:}%
{1ex}%
{\normalfont\LARGE\bfseries}{}

\titlespacing{\chapter}%
{1em}%
{4em plus 2ex minus 1ex}%
{1.5em plus 1ex minus 0.5ex}

\RequirePackage{chngcntr} % tools for counters 
%\@definecounter{paragraph}

% still a bit hacky
% \renewcommand{\thesection}{\arabic{section}.}
\renewcommand{\theparagraph}{\S\thinspace\arabic{paragraph}}
\titleformat {\paragraph}[block]%
{\normalfont\bfseries}%
{\theparagraph}%
{2ex}%
{\normalfont\bfseries}{}

\titlespacing{name=\paragraph}%
{1ex}%
{1em plus 1ex minus 0.5ex}%
{0.7em plus 1ex minus 0.5ex}
\titleformat {name=\paragraph,numberless}%
{\normalfont\bfseries}{\S*}{2ex}{\normalfont\bfseries}{}

\iftoggle{exam}{
  \counterwithout*{paragraph}{chapter}
  \counterwithout*{paragraph}{section}
  \counterwithout*{paragraph}{subsection}
  \counterwithout*{paragraph}{subsubsection}
  \renewcommand{\theparagraph}{№\thinspace\arabic{paragraph}}
  \titleformat\paragraph[block]{\normalfont\bfseries}%
  {Билет\ \theparagraph:}{1ex}{\normalfont\bfseries}{}
}{}

\RequirePackage{tocloft}
\cftsetindents{paragraph}{3.0em}{\widthof{\theparagraph--\arabic{paragraph}}+1em}


\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4}


\RequirePackage{perpage}
\MakePerPage{footnote}

\iftoggle{draft}{}{
  % nice hyperlinks
  \RequirePackage{hyperref}
  % fixes bookmark level
  \RequirePackage{bookmark}
  \hypersetup{%
    pdfencoding=auto,
    unicode=true,
    colorlinks=true,
    linkcolor=blue, 
    citecolor=green!50!black
    %linkbordercolor=blue,% hyperlink borders will be red
    %pdfborderstyle={/S/U/W 1}% border style will be underline of width 1pt
}}

\reversemarginpar
%for margin notes
% \setlength{\marginparwidth}{3cm}
% due to their nature, notes are usually placed in free space. And free space
%+ heavily depends on page orientation. Hence:
% : see style files for \note


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% math envs setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{amsthm}
\theoremstyle{plain}
\newtheorem{thrm}{Теорема}[paragraph]
\newtheorem{lem}[thrm]{Лемма}
\newtheorem{stat}[thrm]{Утверждение}
\newtheorem{prop}[thrm]{Утверждение}
\newtheorem{imp}{Следствие}[thrm]
\newtheorem{cor}{Следствие}[thrm]
\newtheorem*{cor*}{Следствие}

\theoremstyle{definition}
\newtheorem{defn}{Определение}[paragraph]
\newtheorem*{denot}{Обозначение}
\newtheorem{exmp}{Пример}[defn]
\newtheorem*{exmp*}{E.g}

\theoremstyle{remark}
\newtheorem{rem}{Замечание}[defn]
\newtheorem*{rem*}{Замечание}

% \@addtoreset{imp}{lem}
% \@addtoreset{imp}{stat}
\counterwithin*{rem}{thrm}
\counterwithin*{equation}{paragraph}

% % we are redefining a macro that is used by a loop
% % to redefine 9 another macros that have been defined
% % when have defined them by a macro from amsmath
% % which uses 4 another nested macros, last of which
% % finally defines this evil counter we are trying to redefine
\renewcommand*{\do}[1]{
  \expandafter\def\csname the#1\endcsname{\arabic{#1}}%
}
% hoped to be fastest loop
% if have any proofs of contrary, make me know 
\docsvlist{thrm,lem,stat,prop,imp,cor,defn,exmp,rem}

\renewcommand*{\do}[1]{
  \expandafter\edef\csname p@#1\endcsname{%
    \noexpand\arabic\noexpand{chapter}.\noexpand\arabic\noexpand{paragraph}.%
\expandafter\noexpand\csname the#1\endcsname\noexpand\expandafter\noexpand\@gobble}
}
\docsvlist{thrm,defn,exmp}

\renewcommand{\p@equation}{\theequation\expandafter\@gobble}

%manual resetting
\newcommand*{\re@setter}[1]{
  \expandafter\newcommand\csname reset#1\endcsname{
    \setcounter{#1}{0}
  }
}
\forcsvlist{\re@setter}{defn,thrm,rem}
\newcommand\resetall{\resetdefs \resetthrm \resetrem}


\endinput
% vim: nofoldenable
