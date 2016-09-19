%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Класс для всяких конспектов и заметок
%  Определены всякие нужные окружения 
%+ и настроены(вроде) перекрёстные ссылки
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}

% report options
\DeclareOption{10pt}{
    \PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{12pt}{
    \PassOptionsToClass{\CurrentOption}{report}
}

%% Fallback                                  
\DeclareOption*{
    \ClassWarning{myclass}{Unknown option '\CurrentOption'}
}

\ExecuteOptions{10pt}
\ProcessOptions\relax

\LoadClass[a4paper]{report}


%pdf search
\RequirePackage{cmap}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[english,russian]{babel}
\RequirePackage[left=1cm,right=1cm,
top=1cm,bottom=1cm,bindingoffset=0cm]{geometry}
\RequirePackage[intlimits]{amsmath}
\RequirePackage{amsfonts, amssymb, amsthm}
\RequirePackage{mathtools}

\RequirePackage[pdftex]{graphicx}
\RequirePackage{xcolor}

\RequirePackage{verbatim}
\RequirePackage{epigraph}
\RequirePackage{wasysym}
\RequirePackage{hyperref}

\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{calc}

\RequirePackage[shortlabels]{enumitem}
\RequirePackage{perpage}

\RequirePackage{chngcntr} % tools for counters 
\RequirePackage{bbm}      %} more math fonts
\RequirePackage{mathrsfs} %}
%\RequirePackage{xfrac} % better slashed fractions --> Font Warning --> Loads too many fonts --> not useful 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% packages setup & fixes 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hspace somehow not fixed by calc, fixing it here
\def\@hspace#1{\begingroup\setlength\dimen@{#1}\hskip\dimen@\endgroup}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% styles setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
\newtheorem{exmp}{Пример}[defn]
\newtheorem*{exmp*}{E.g}

\theoremstyle{remark}
\newtheorem{rem}{Замечание}[defn]
\newtheorem*{rem*}{Замечание}

\@addtoreset{imp}{lem}
\@addtoreset{imp}{stat}
\counterwithin*{rem}{thrm}

\renewcommand{\thethrm}{\arabic{thrm}}
\renewcommand{\thelem}{\arabic{lem}}
\renewcommand{\thestat}{\arabic{stat}}
\renewcommand{\theprop}{\arabic{prop}}
\renewcommand{\theimp}{\arabic{imp}}
\renewcommand{\thecor}{\arabic{cor}}

\renewcommand{\thedefn}{\arabic{defn}}
\renewcommand{\theexmp}{\arabic{exmp}}

\renewcommand{\therem}{\arabic{rem}}

\renewcommand{\p@thrm}{\arabic{chapter}.\arabic{paragraph}.\thethrm\expandafter\@gobble}
%\renewcommand{\p@lem}{\arabic{chapter}.\arabic{paragraph}.\thelem\expandafter\@gobble}
%\renewcommand{\p@stat}{\arabic{chapter}.\arabic{paragraph}.\thestat\expandafter\@gobble}
\renewcommand{\p@defn}{\arabic{chapter}.\arabic{paragraph}.\thedefn\expandafter\@gobble}
\renewcommand{\p@exmp}{\arabic{chapter}.\arabic{paragraph}.\theexmp\expandafter\@gobble}
\renewcommand{\p@equation}{\theequation\expandafter\@gobble}

%%%%% <---- Starting chapter without a pagebreak
%\makeatletter 
\renewcommand\chapter{\par%
\thispagestyle{plain}% \global\@topnum\z@
\@afterindentfalse \secdef\@chapter\@schapter} 
%\makeatother 

\titleformat{\chapter}{%
    \normalfont\LARGE\bfseries
}{Глава \ \thechapter:}{1ex}{\normalfont\LARGE\bfseries}{}  
\titlespacing\chapter{1em}{2em plus 1ex minus 0.5ex}{1.5em plus 1ex minus 0.5ex}

\counterwithout{paragraph}{chapter}
\renewcommand{\theparagraph}{\S\thinspace\arabic{paragraph}}
\titleformat\paragraph[block]{\normalfont\bfseries}{\theparagraph}{2ex}{\normalfont\bfseries}{}  
\titlespacing\paragraph{1ex}{1em plus 1ex minus 0.5ex}{0.7em plus 1ex minus 0.5ex}

%setting up ToC and numbering
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{4}
\cftsetindents{paragraph}{3.0em}{\widthof{\theparagraph--\arabic{paragraph}}+1em}


\MakePerPage{footnote}

\hypersetup{%
  colorlinks=true,% hyperlinks will be colorful
  linkcolor=blue %they will be blue!
  %linkbordercolor=blue,% hyperlink borders will be red
  %pdfborderstyle={/S/U/W 1}% border style will be underline of width 1pt
}

%for margin notes
\setlength{\marginparwidth}{3cm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% new formatting cmds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{ittproof}[1][\noskip]{\noindent$\square$\ifx\noskip#1\relax\else~(\textit{#1})\fi~\nopagebreak}%
{\nopagebreak\noindent$\blacksquare$\par}
\newenvironment{itlproof}[1][\noskip]{\noindent$\blacktriangledown$\ifx\noskip#1\relax\else~(\textit{#1})\fi\\* }%
{\nopagebreak\par\noindent\nopagebreak$\blacktriangle$\par}

\def\resetdefs{ \setcounter{defn}{0} }
\def\resetthrm{ \setcounter{thrm}{0} }
\def\resetrem{ \setcounter{rem}{0} }
\def\resetall{ \resetdefs \resetthrm \resetrem}

\newcounter{tmp}%
\def\parrange#1#2{%
  %\makeatletter%
  \addtocounter{paragraph}{1}%
  \setcounter{tmp}{\value{paragraph}}%
  \addtocounter{paragraph}{#1-2}% one day I will rewrite this. But not today :)
  \renewcommand\theparagraph{\hspace{\widthof{\S}*(-2)}\S\S\thinspace\arabic{tmp}--\arabic{paragraph}}%
  \titleformat\paragraph[block]{\normalfont\bfseries}{\hspace{\widthof{\S}*2}%
\theparagraph}{2ex}{\normalfont\bfseries}{}  
  \paragraph{#2}
  \renewcommand{\theparagraph}{\S\thinspace\arabic{paragraph}}%
  \titleformat\paragraph[block]{\normalfont\bfseries}{\theparagraph}{2ex}{\normalfont\bfseries}{}%  
  %\makeatother%
}

\def\itemrange#1{%
  \addtocounter{enumi}{1}%
  \edef\labelenumi{\theenumi--\noexpand\theenumi.}%
  \addtocounter{enumi}{-1}%
  \addtocounter{enumi}{#1}%
  \item
  \def\labelenumi{\theenumi.}
}

\def\itemskip#1{\addtocounter{enumi}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% various niceties                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\lfrac#1#2{{}^{#1}\!/_{\!#2}}
%\renewcommand\lfrac[2]{\sfrac{#1}{#2}}


\def\dint{\displaystyle\int}
\def\dsum{\displaystyle\sum}

\def\conv{\ensuremath \textit{ сх }}
\def\noconv{\ensuremath \textit{ расх }}

\DeclareMathOperator\Ln{Ln}
\DeclareMathOperator\clos{clos}
\DeclareMathOperator\grad{grad}
\DeclareMathOperator\rk{rk}
\DeclareMathOperator\End{End}
\DeclareMathOperator\Ker{Ker}
\let\Im\relax
\DeclareMathOperator\Im{Im}
\DeclareMathOperator\Tr{Tr}
\DeclareMathOperator\id{id}
\DeclareMathOperator\Spec{Spec}


\renewcommand\C{\mathbbm{C}} 
\newcommand\R{\mathbbm{R}} 
\newcommand\Q{\mathbbm{Q}}
\newcommand\Z{\mathbbm{Z}}
\newcommand\N{\mathbbm{N}}

\newcommand\convex{\,\underline\cup\,}
\newcommand\concave{\,\overline\cap\,}
\newcommand\circlearound[1]{#1\hspace{\widthof{#1}*(-1)}$\bigcirc$}

\endinput
% vim: set sw=2 nofoldenable:

