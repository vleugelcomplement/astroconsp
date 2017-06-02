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

%language setting to handle cyrrilic in expansions

%% pdf search
\RequirePackage{cmap}
\RequirePackage{etoolbox}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[english,russian]{babel}
\RequirePackage[a4paper]{geometry}


\newcommand*\set@bool@opt[1]{
  \newtoggle{#1}
  \DeclareOption{#1}{\toggletrue{#1}}
}
\forcsvlist{\set@bool@opt}{hardcopy,timbord,ebook,tikz,draft}

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

% processing toggles
\iftoggle{hardcopy}{
  \geometry{
    left=1.5cm,
    right=1.5cm,
    top=1.5cm,
    bottom=1.5cm,
    bindingoffset=0cm
  }
}{}%
\iftoggle{timbord}{
  \geometry{
    landscape,
    left=5cm, 
    right=2cm,
    top=0.5cm, 
    bottom=0.5cm,
    marginparsep=5mm, 
    marginparwidth=4cm
  }
  \RequirePackage{cmbright}
% \renewcommand\bfseries{\protect \usefont{T2A}{cmss}{bx}{n}}
  \renewcommand\bfdefault{sb}
}{}%
\iftoggle{ebook}{
  \geometry{a4paper,top=2cm,bottom=2cm,right=3cm,left=3cm}
}{}


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
{2em plus 1ex minus 0.5ex}%
{1.5em plus 1ex minus 0.5ex}

\RequirePackage{chngcntr} % tools for counters 
\@definecounter{paragraph}
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

% a bit faster
\iftoggle{timbord}%
{\newcommand{\note}[1]{\marginpar{\footnotesize #1}}}%
{\newcommand{\note}[1]{\footnote{#1}}}


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

\@addtoreset{imp}{lem}
\@addtoreset{imp}{stat}
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
