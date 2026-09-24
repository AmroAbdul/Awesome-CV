# Awesome CV

A LaTeX template for résumés, CVs, and cover letters. This repository is a fork of [posquit0/Awesome-CV](https://github.com/posquit0/Awesome-CV).

## Requirements

- A full TeX Live installation with LuaLaTeX, `fontspec`, `polyglossia`, `fontawesome6`, and the Arabic direction packages. XeLaTeX also works when its required fonts and `bidi` package are installed.
- Source Sans 3 and Roboto for the original layout. Arabic text needs Amiri, Noto Naskh Arabic, or DejaVu Sans. The class chooses the first available Arabic font in that order.

## Build

From the repository root, run:

```bash
make
```

This builds the English résumé, CV, and cover letter samples in `examples/`. To compile a single document, use LuaLaTeX from the repository root:

```bash
lualatex -output-directory=examples examples/languages-arabic.tex
lualatex -output-directory=examples examples/languages-turkish.tex
```

Edit the contact details and section files in `examples/` to make your own document. The main class is `awesome-cv.cls`.

## Language and text direction

English is the default. Set the main language in the document preamble:

```tex
\acvSetLanguage{arabic} % english, turkish, or arabic
```

For short passages inside another language, use `\acvRTL{نص عربي}`, `\acvLTR{English text}`, or `\acvTurkish{Türkçe metin}`. For a full right-aligned Arabic paragraph:

```tex
\begin{acvArabic}
هذه فقرة باللغة العربية.
\end{acvArabic}
```

Arabic headings use the Arabic font and stay intact rather than splitting the first three characters for accent coloring. The CV entry tables retain their original column arrangement. See the two `examples/languages-*.tex` files for working samples.

## Colors

Set the accent in the preamble:

```tex
\colorlet{awesome}{awesome-catppuccin-mocha}
```

Catppuccin accents are available as `awesome-catppuccin-latte`, `awesome-catppuccin-frappe`, `awesome-catppuccin-macchiato`, and `awesome-catppuccin-mocha`. Each uses the official [Catppuccin](https://github.com/catppuccin/catppuccin) Mauve color for that flavor. They change accent elements on the existing white page; they do not recolor the page background. The original `awesome-red`, `awesome-emerald`, and other Awesome CV accents remain available.

## Credits and license

Awesome CV was created by Claud D. Park and contributors. The class file is licensed under [LPPL 1.3c](LICENCE). The example documents retain their original license notices. See the [upstream project](https://github.com/posquit0/Awesome-CV) for its full history and documentation.
