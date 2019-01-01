% Sample class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{trsample}
\RequirePackage{tropt}
\def\@baseclass{article}

\DeclFlagOpt{kek,pep}
\DeclCompOpt{draft<>final}
\DeclPackOpt{microtype,tikz}
\DeclPassOpt{a4paper}

\DeclareOption*{
  \ClassWarning{trsample}{Undefined option: \CurrentOption}{}
  \PassOptionsToClass{article}{\CurrentOption}
}

\ProcOpts
\LoadCls{article}

\RequirePackage{hyperref}
\RequirePackage{geometry}

\HasFlag{kek}{
  \AtBeginDocument{kek}
}
\HasFlag{pep}{
  \AtBeginDocument{\noindent pep \\}
}
\endinput
