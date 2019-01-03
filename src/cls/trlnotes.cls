%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Класс для всяких конспектов и заметок
%  Определены всякие нужные окружения 
%+ и настроены(вроде) перекрёстные ссылки
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}
% plain notes have only sections
% long notes are more like a report, with chapters and paragraphs
\ProvidesClass{trlnotes}[2017/05/27 Long version of notes]

\RequirePackage{trcore}
\RequirePackage{trly}
\RequirePackage{trclstools}


%%% ===========
%%%  Variables
%%% ===========

\def\@baseclass{report}
\listdef\@complyt{timbord,ebook,hardcopy} % compatible layouts


%%% =======================
%%% Option processing stuff
%%% =======================

\DeclFlagOpt{tikz,draft,exam}
\DeclPassOpt{10pt,12pt}

%% Fallback                                  
\DeclOpt*{
    \ClassWarning{trlnotes}{does not know about `\CurrentOption'. 
    Please, clarify your intentions}{}
    \PassOptionsToClass{\CurrentOption}{\@baseclass}
}

\ProcOpts

\LoadCls{\@baseclass}

%%% =================
%%% language packages
%%% =================

\RequirePackagePack{trulang}

\RequirePackage{verbatim}
\RequirePackage{epigraph}

\RequirePackagePack{trtables}
\RequirePackage[shortlabels]{enumitem}
\RequirePackagePack{trgraphics}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Рубрикация. Это сложно
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% is not fully compatible with biblatex and hyperref
% consider removal
% \RequirePackage[explicit]{titlesec}
% \RequirePackage{titletoc}
\RequirePackage{chngcntr} % tools for counters 

% \providetoggle{nostdsections}
% \toggletrue{nostdsections}
% \iftoggle{nostdsections}{
% \firestdsections
% }{}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
% we do not need to redefine chapters a lot
\let \enotesectiontype=\chapter

\renewcommand{\theparagraph}{\S\thinspace\arabic{paragraph}}
\def\@seccntformat#1{%
  \unexpanded{\csuse{#1labelformat}}
  {\csname the#1\endcsname}%
  \ifcsdef{#1headsep}%
    {\ex@f\hspace\ex@f{\csname #1headsep\endcsname}}
    {\hspace{1em}}%
}
\newcommand{\paragraphheadsep}{1.4ex}
\newcommand{\paragraphlabelformat}{\Large}
\renewcommand{\paragraph}{
  \@startsection{paragraph}{2}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {3ex}%
  {\normalfont\large\bfseries}
}
\renewcommand*\l@paragraph{\@dottedtocline{2}{2em}{2em}}

% \def \trr@section@define#1{
%   \edef\@trr@cursect@name{\ex@f\@gobble\detokenize{#1}}
%   \renewcommand{#1}{
%   \@startsection{}{2}{\z@}%
%   {3.25e \@plus1ex \@minus.2ex}%
%   {3ex}%
%   {\normalfont\large\bfseries}
%   }
% }


\newcounter{clause}
\newcommand{\clauseheadsep}{1.4ex}
\newcommand{\clause}{
  \@startsection{clause}{3}{\z@}%
  {3.25ex \@plus1ex \@minus.2ex}%
  {-1em}%
  {\normalfont\normalsize\bfseries}
}
\renewcommand\theclause{\arabic{clause}.\ }
\counterwithin*{clause}{paragraph}
\newcommand\clausemark{\@gobble}
\newcommand*\l@clause{\@dottedtocline{3}{4em}{1em}}

% \titleformat{\chapter}[hang]%
% {\normalfont\LARGE\bfseries}%
% {\chaptertitlename\ \thechapter\hspace{0.2ex}:}%
% {1ex}
% {\normalfont\LARGE\bfseries#1}
%
% \titlespacing{\chapter}%
% {-1em}%
% {4em plus 2ex minus 1ex}%
% {1.5em plus 1ex minus 0.5ex}
%
%
% \titleclass{\paragraph}{straight}[\chapter]
% \newcommand{\theparagraph}{\S\thinspace\arabic{paragraph}}
% \titleformat {\paragraph}[block]%
% {\large\bfseries}%
% {\theparagraph}%
% {3ex}%
% {\normalfont\bfseries#1}
%
% \titleformat {name=\paragraph,numberless}%
% {\normalfont\bfseries}
% {\S*}
% {2ex}
% {\normalfont\bfseries#1}
%
% \titlespacing{name=\paragraph}%
% {-1em}%
% {1.5em plus 1.2ex minus 0.8ex}%
% {0.7em plus 1ex minus 0.5ex}
%
%
% \newcounter{clause}
% \titleclass{\clause}{straight}[\paragraph]
% \renewcommand\theclause{\arabic{clause}.}
%
% \titleformat{\clause}[runin]
% {\normalfont\bfseries} {\theclause} {1ex}
% {\normalfont\bfseries#1}[.]
%
% \titlespacing{\clause}
% {0ex}{0ex}{0ex}
% \titlecontents{clause}{}{}{}{}

\iftoggle{exam}{
  \counterwithout*{paragraph}{chapter}
  \renewcommand{\theparagraph}{№\thinspace\arabic{paragraph}}
  \titleformat\paragraph[block]{\normalfont\bfseries}%
  {Билет\ \theparagraph:}{1ex}{\normalfont\bfseries}{}
}{}

% \RequirePackage{tocloft}
% \cftsetindents{paragraph}{3.0em}{\widthof{\theparagraph--\arabic{paragraph}}+1em}
% % \cftsetindents{clause}{3.0em}{1em}




\RequirePackage{perpage}
\MakePerPage{footnote}

% \reversemarginpar --> in layout files
%for margin notes
% due to their nature, notes are usually placed in free space. And free space
%+ heavily depends on page layout. Hence, see `flex` files for \note

\RequirePackagePack{trhyplinks}
% should be overrided in layout file
% this is nice default setup
\hypersetup{%
  colorlinks=true,
  linkcolor=blue, 
  citecolor=green!50!black
}

\def\toclevel@paragraph{2}
\def\toclevel@clause{3}

\endinput
% vim: nofoldenable
