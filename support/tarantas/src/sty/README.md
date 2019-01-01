# about this folder

Not all files here  have a `.sty` extension.
Consider this folder as an internal machinery section of tarantas -- wheels, spokes, springs

## General rules

* `foo.code.tex` contains most \def's. Look here if you want to know details.
* `foo.sty` -- sets real behaviour using tools in aforementioned file 
    and provides a public API of a package. It seems to be a convenient way to avoid name
    clushes with other packages.
* `foo.def` -- boring definitions. Something like long list of math arrows. 
    Quite often is used to set default values (pair separator etc.)
  
See `trkv.code.tex`, `trkv.sty`, `trkv.def` for (not quite perfect) example of this scheme.

## Exceptions 
The rule above does not apply if package code is just too short.
Like `trly.sty`.
