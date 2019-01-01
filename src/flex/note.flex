\let\note\relax
\newflexcommand{\note}{
  type:\footnote;
}{%
  \ifexpmode{}{\flexvar{type}}%
}

% vim:ft=tex
