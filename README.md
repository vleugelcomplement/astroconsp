# astroconsp

Если вы просто ищете пдфки, вам сюда: [« wiki »](https://github.com/tis-p30/astroconsp/wiki) \

If google led your here, you may look below for technical details
or follow the link above to download lecture notes from wiki page.
Additional information about content is provided on the wiki page, too.


### Code

Latex compiler with `e-TeX` support is required to build notes.
Luckily, modern distributions (E.g `texlive` > 2012) provide `e-TeX`
by default.

One may use makefile to produce desired pdf, or follow links on [project wiki](https://github.com/tis-p30/astroconsp/wiki)

Current version of Makefile assumes `latexmk` preinstalled. However, you may try to build `main.tex` directly. In this case,
you should edit class options to get a desired style.

At some undetectable point in the history we have finally adopted [tarantas](https://github.com/taxus-d/tarantas) for our joint works.
So, to build several modern notes you should consider cloning the aforementioned vehicle 
and install it in your preferred way.
Mine is manual `.latexmkrc` editing, stuff is really unstable now and is likely to change almost every day.

In the process of tarantas adoption style selection syntax has been altered.
For us it seems to be much more consise: `\setlayout{what}`

##### Layout
We are preserving this stuff during transition process. Some day, it will be done.
<pre font="Hack">
╠ sty ┐      
║     ├ 'styles'     ══ see below, have the same name as a corresponding option
║     ├ tmath.sty    ── list of \DeclareMathOperator's
║     ├ cussymb.sty  ── custom notation and hackery
║     ├ thranges.sty ── header ranges (like §§1--2 )
║     └ tlegacy.sty  ── old crutches, include if nothing helps
║
╠ cls   ══ classes for lecture notes
║
╠ tools ┐   
║       ├ Perl scripts to change styles automagically
║       ├ Makefile
║       └ vim ┐
║             ├ abbreviations and maps for common symbols
║             └ tex.vim ftplugin with vimtex setup
╠ ...
╠ A number of dirs with courses content
╠ their names are assumed to be self-explainatory
</pre>


### Styles

Notes come in a number of styles listed below.
Each style corresponds to specific option to `notes` class OR `\setlayot{it}` in modern papers.

| Option|Description|
|-----:|:----|
| _hardcopy_ | reduced margins, suitable for printing, paper economy and so on |
| _timbord_  | landscape orientation, sans-serif fonts. Supposed to be more readable from LCD|
| _ebook_    | increased margins, targeted for e-ink readers and other devices with small screens|
to be expanded
