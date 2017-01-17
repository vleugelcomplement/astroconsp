%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Класс для всяких конспектов и заметок
%  Определены всякие нужные окружения 
%+ и настроены(вроде) перекрёстные ссылки
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}

\newcommand\hmmax{0}
\newcommand\bmmax{0}
% \RequirePackage{stix}
% \RequirePackage{cyravantgar}
% \renewcommand{\familydefault}{\sfdefault}
%pdf search
\RequirePackage{cmap}
\RequirePackage{ifthen}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T2A]{fontenc}
\RequirePackage[english,russian]{babel}

% report options
\DeclareOption{10pt}{
    \PassOptionsToClass{\CurrentOption}{report}
}
\DeclareOption{12pt}{
    \PassOptionsToClass{\CurrentOption}{report}
}

\newboolean{hardcopy}
\newboolean{timbord}
\newboolean{ebook}
\setboolean{hardcopy}{false}
\setboolean{timbord}{false}
\setboolean{ebook}{false}

\DeclareOption{hardcopy}{ \setboolean{hardcopy}{true}}
\DeclareOption{timbord}{\setboolean{timbord}{true}}
\DeclareOption{ebook}{\setboolean{ebook}{true}}

%% Fallback                                  
\DeclareOption*{
    \ClassWarning{myclass}{Unknown option '\CurrentOption'}
}

\ExecuteOptions{10pt}
\ProcessOptions\relax

\LoadClass[a4paper]{report}



\ifthenelse{\boolean{hardcopy}}
{\RequirePackage[left=1.5cm,right=1.5cm,top=1.5cm,bottom=1.5cm,bindingoffset=0cm]{geometry}}
{
  \ifthenelse{\boolean{timbord}}
  {
    \RequirePackage[a4paper,landscape,left=5cm, right=2cm,top=0.5cm, bottom=0.5cm,
      marginparsep=5mm, marginparwidth=4cm]{geometry}
    \RequirePackage{cmbright}
%     \renewcommand\bfseries{\protect \usefont{T2A}{cmss}{bx}{n}}
    \renewcommand\bfdefault{sb}
  }
  {
    \ifthenelse{\boolean{ebook}}
    {\RequirePackage[a4paper,top=2cm,bottom=2cm,right=3cm,left=3cm]{geometry}}
    {\RequirePackage{geometry}}
  }
}
% 
\RequirePackage[intlimits]{amsmath}
\RequirePackage{amsfonts,amsthm, amssymb}
\RequirePackage{mathtools}
% \RequirePackage[intlimits]{esint}

\RequirePackage[pdftex]{graphicx}
\RequirePackage{xcolor}
% 🔥
\RequirePackage{verbatim}
\RequirePackage{epigraph}
\RequirePackage[nointegrals]{wasysym}
\RequirePackage{marvosym}
\RequirePackage{hyperref}
\RequirePackage{array}
\RequirePackage{tabulary}

\RequirePackage{titlesec}
\RequirePackage{tocloft}
\RequirePackage{calc}
\RequirePackage{changepage}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{perpage}

\RequirePackage{chngcntr} % tools for counters 
\RequirePackage{bbm}      %} more math fonts
% \RequirePackage{mathrsfs} %}
\RequirePackage{accents}  % extra dots over chars
%\RequirePackage{xfrac} % better slashed fractions --> Font Warning --> Loads too many fonts --> not useful 

\RequirePackage{tikz}
\usetikzlibrary{calc,decorations.markings}

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
\counterwithin*{equation}{paragraph}

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
\titleformat{name=\paragraph,numberless}{\normalfont\bfseries}{\S*}{2ex}{\normalfont\bfseries}{}

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

\reversemarginpar
%for margin notes
% \setlength{\marginparwidth}{3cm}
% due to their nature, notes are usually placed in free space. And free space
%+ heavily depends on page orientation. Hence:

\newcommand{\note}[1]{%
  \ifthenelse{\boolean{timbord}}%
  {\marginpar{\footnotesize #1}}%
  {\footnote{#1}}%
}

% \patchcmd{\@addmarginpar}%
%     {\box \@marbox}%
%     {\hbox{%
%         \ifmpar@rule@rside
%         \hskip-\mparrulefactor\marginparsep\mparrule
%         \hskip\mparrulefactor\marginparsep
%         \fi
%                           \box \@marbox
%         \ifmpar@rule@lside
%         \hskip\mparrulefactor\marginparsep\mparrule
%         \fi}%
%      \global\mpar@rule@lsidefalse
%      \global\mpar@rule@rsidefalse
%     }%
%     {\typeout{*** SUCCESS ***}}{\typeout{*** FAIL ***}}

% \patchcmd{\@addmarginpar}%
%     {\global\setbox\@marbox\box\@currbox}%
%     {\global\setbox\@marbox\box\@currbox
%      \global\mpar@rule@lsidetrue
%      \else
%      \global\mpar@rule@rsidetrue
%     }%
%     {\typeout{*** SUCCESS ***}}{\typeout{*** FAIL ***}}

% \newif\ifmpar@rule@lside
% \newif\ifmpar@rule@rside

% % \marginparrule generates the \vrule but should use no space horizontally
% \newcommand\mparrule{\hskip-2pt\vrule width 4pt\hskip-2pt}

% placement factor: .5 places the rule midway in the space made available 
% by \marginparsep
% \newcommand\mparrulefactor{.4}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% new formatting cmds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{ittproof}[1][\noskip]{\noindent$\square$\ifx\noskip#1\relax\else~(\textit{#1})\fi~\nopagebreak}%
{\nopagebreak\noindent$\blacksquare$\par}
\newenvironment{itlproof}[1][\noskip]{\noindent$\blacktriangledown$\ifx\noskip#1\relax\else~(\textit{#1})\fi\\* }%
{\nopagebreak\par\noindent\nopagebreak$\blacktriangle$\par}

\newenvironment{itaux}[1][1cm]{\begin{small}\begin{adjustwidth}{#1}{}}{\end{adjustwidth}\end{small}}

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
\DeclareMathOperator\codim{codim}
\DeclareMathOperator\Spec{Spec}

\DeclareMathOperator\Res{Res}
\DeclareMathOperator\Aut{Aut}
\DeclareMathOperator\Stab{Stab}
\DeclareMathOperator*{\argmin}{arg\,min}

\renewcommand\C{\mathbbm{C}} 
\newcommand\exC{\overline{\mathbbm{C}}} 
\newcommand\D{\mathbbm{D}} 
\newcommand\R{\mathbbm{R}} 
\newcommand\Q{\mathbbm{Q}}
\newcommand\Z{\mathbbm{Z}}
\newcommand\N{\mathbbm{N}}

\newcommand\convex{\,\underline\cup\,}
\newcommand\concave{\,\overline\cap\,}
\newcommand\circlearound[1]{#1\hspace{\widthof{#1}*(-1)}$\bigcirc$}
\newcommand{\diffin}{\textit{дифференцируема в }} 
\newcommand{\pneigh}[1]{\overset{\circ}{#1}} 
\providecommand{\xRightarrow}[2][]{\mathop{\Longrightarrow}\limits_{#1}^{#2}}
\providecommand{\xequal}[2][]{\mathop{=}\limits_{#1}^{#2}}

\newcommand\del{\ensuremath\mathrm{d}}
\newcommand\pder[2]{\ensuremath \frac{\partial #1}{\partial #2}}
\newcommand\pdder[3]{\ensuremath \frac{\partial^2 #1}{\partial #2 \partial #3}}

\newcommand{\gearmacro}[5]{%
% #1 number of teeths
% #2 radius intern
% #3 radius extern
% #4 angle from start to end of the first arc
% #5 angle to decale the second arc from the first 
  \foreach \i in {1,...,#1} {%
    [rotate=(\i-1)*360/#1]  (0:#2)  arc (0:#4:#2) {[rounded corners=0pt]
    -- (#4+#5:#3)  arc (#4+#5:360/#1-#5:#3)} --  (360/#1:#2)
  }
}  

% \newcommand{\gear}{\begin{tikzpicture}[scale=0.15]
%     \fill[black] (0,0) circle (2em);
%     \draw[thick,rotate=12,fill=black] \gearmacro{8}{1.8em}{2.4em}{20}{10};
%     \draw[thick,fill=white] (0em,0em) circle(1.35em);
% \end{tikzpicture}}
% \newsavebox\gearbox
% \sbox\gearbox{\raisebox{-0.1em}{\gear{}} }
% unfortunately tikz has problems with toc 
\newcommand{\underdev}{\texorpdfstring{\MineSign{}}{}} 
\newcommand{\flame}{\texttt{:set aflame}} 
\newcommand{\sour}{$\ddot\sim$} 
\newcommand{\plholdev}[1]{\texttt{<+{#1}+>}} 

\renewcommand*{\dot}[1]{\accentset{\mbox{\bfseries .}}{#1}}
\renewcommand*{\ddot}[1]{\accentset{\mbox{\bfseries .\hspace{-0.1ex}.}}{#1}}
\newcommand{\coori}{\mathop{\uparrow\!\uparrow}} 
\newcommand{\conori}{\mathop{\uparrow\!\downarrow}} 
% probability theory
 \DeclareMathOperator{\Exp}{M} 
 \DeclareMathOperator{\Var}{D} 
 \DeclareMathOperator{\cov}{cov} 
 \newcommand{\av}[1]{\overline{#1}} 
 \newcommand{\intR}{\int_{-\infty}^{+\infty}} 

\endinput
% vim: nofoldenable
