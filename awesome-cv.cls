% Awesome CV class: layout, typography, contact details, and language helpers.
% Original project:
% https://github.com/posquit0/Awesome-CV
% Original author:
% Claud D. Park <posquit0.bj@gmail.com>
% http://www.posquit0.com
% How this class is used:
% The class defines layout for cv.tex, resume.tex, and cover letters.
% Most users can change their content and colors without editing this file.
% License for this class:
% LPPL v1.3c (http://www.latex-project.org/lppl)



% Class identity and TeX format requirements
\ProvidesClass{awesome-cv}[2017/02/05 v1.6.1 Awesome Curriculum Vitae Class]
\NeedsTeXFormat{LaTeX2e}



% Process class options before loading the article layout
% Process options now: geometry needs page dimensions from the base class.
% Draft draws a marker beside overfull lines; final hides it.
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
% Forward unrecognized options, such as paper size, to article.
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}



% Packages used for layout, typography, links, and icons
% Array and tabularx keep multi-column entries at the page width.
\RequirePackage{array}
\RequirePackage{tabularx}
% Enumitem controls spacing and indentation in bullet lists.
\RequirePackage{enumitem}
% Ragged2e supplies the justified paragraph environment.
\RequirePackage{ragged2e}
% Geometry defines the margins and usable text width.
\RequirePackage{geometry}
% Fancyhdr places the three footer fields without a rule.
\RequirePackage{fancyhdr}
% Xcolor defines the text palette and the selected accent.
\RequirePackage{xcolor}
% Keep the existing XeTeX engine conditional available.
\RequirePackage{ifxetex}
% Xifthen handles optional fields and layout choices.
\RequirePackage{xifthen}
% Xstring removes punctuation from phone link targets.
\RequirePackage{xstring}
% Etoolbox provides booleans, string checks, and empty checks.
\RequirePackage{etoolbox}
% Setspace controls the recipient address line spacing.
\RequirePackage{setspace}
% Fontspec selects installed Unicode fonts; use XeLaTeX or LuaLaTeX.
\RequirePackage[quiet]{fontspec}
% Map TeX-style quotes to their Unicode glyphs.
\defaultfontfeatures{Ligatures=TeX}
% Unicode-math keeps math symbols compatible with Unicode fonts.
\RequirePackage{unicode-math}
% Polyglossia supplies Turkish language rules and Arabic text direction.
% A full TeX installation needs the bidi package when using XeLaTeX.
\RequirePackage{polyglossia}
\setdefaultlanguage{english}
\setotherlanguages{arabic,turkish}
% Select an installed Arabic font so the class can shape Arabic words.
% Redefine \arabicfont in the document preamble to choose a different font.
\IfFontExistsTF{Amiri}
  {\newfontfamily\arabicfont[Script=Arabic]{Amiri}}
  {\IfFontExistsTF{Noto Naskh Arabic}
    {\newfontfamily\arabicfont[Script=Arabic]{Noto Naskh Arabic}}
    {\newfontfamily\arabicfont[Script=Arabic]{DejaVu Sans}}}
\newbool{acvArabicMode}
\setbool{acvArabicMode}{false}
% In the preamble, call \acvSetLanguage{arabic} or {turkish} for a whole CV.
% Arabic also changes the fonts used by class headings and entry styles.
\newcommand*{\acvSetLanguage}[1]{%
  \ifstrequal{#1}{arabic}
    {\setdefaultlanguage{arabic}\setbool{acvArabicMode}{true}}
    {\ifstrequal{#1}{turkish}
      {\setdefaultlanguage{turkish}\setbool{acvArabicMode}{false}}
      {\ifstrequal{#1}{english}
        {\setdefaultlanguage{english}\setbool{acvArabicMode}{false}}
        {\ClassError{awesome-cv}{Unsupported language `#1'}{Choose english, turkish, or arabic.}}}}%
}
% For a mixed-language line, use \acvRTL{Arabic}, \acvLTR{English},
% or \acvTurkish{Turkish}; the surrounding document language stays intact.
\newcommand*{\acvRTL}[1]{\textarabic{#1}}
\newcommand*{\acvLTR}[1]{\textenglish{#1}}
\newcommand*{\acvTurkish}[1]{\textturkish{#1}}
% Wrap whole Arabic paragraphs in acvArabic for right alignment and RTL order.
\newenvironment{acvArabic}{\begingroup\setbool{acvArabicMode}{true}\begin{arabic}\raggedleft}
  {\end{arabic}\endgroup}
% Font Awesome supplies the contact and social icons.
\RequirePackage{fontawesome6}
\RequirePackage{accsupp}
\defaultfontfeatures{
  Renderer=HarfBuzz,
}
\setmainfont{Source Sans 3}[
  UprightFont=*,
  ItalicFont=* Italic,
  BoldFont=* Bold,
  BoldItalicFont=* Bold Italic,
  FontFace={l}{n}{Font=* Light},
  FontFace={l}{it}{Font=* Light Italic},
]
\setsansfont{Source Sans 3}[
  UprightFont=*,
  ItalicFont=* Italic,
  BoldFont=* Bold,
  BoldItalicFont=* Bold Italic,
  FontFace={l}{n}{Font=* Light},
  FontFace={l}{it}{Font=* Light Italic},
]
\newfontfamily\roboto{Roboto}[
  UprightFont=*,
  ItalicFont=* Italic,
  BoldFont=* Bold,
  BoldItalicFont=* Bold Italic,
  FontFace={l}{n}{Font=* Light},
  FontFace={l}{it}{Font=* Light Italic},
]
% Tcolorbox and TikZ draw an optional framed profile photo.
\RequirePackage[skins]{tcolorbox}
% Parskip spaces paragraphs without first-line indentation.
\RequirePackage{parskip}
% Hyperref makes contact details clickable and keeps link boxes hidden.
\RequirePackage[hidelinks,unicode,pdfpagelabels=false]{hyperref}
\hypersetup{%
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={}
}
% Bookmark stabilizes the PDF outline written by hyperref.
\RequirePackage{bookmark}


% Legacy font directory setting
% Accept the old fontdir setting used by existing documents.
% The current fonts come from the system, so this setting is only for compatibility.
\newcommand*{\fontdir}[1][fonts/]{\def\@fontdir{#1}}


% Page margins, headers, and footers
% Default page dimensions.
% Provide usable defaults; a document can call geometry again to override them.
\geometry{left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.0cm, footskip=.5cm}

% Page chrome shared by CVs and cover letters.
% Align header and footer content with the text block.
\fancyhfoffset{0em}
% Keep the top of the page free of a decorative line.
\renewcommand{\headrulewidth}{0pt}
% Start with empty header and footer slots.
\fancyhf{}
% Activate fancyhdr so makecvfooter can fill its slots.
\pagestyle{fancy}



% Text colors and selectable accent colors
% Neutral colors used throughout the existing white-page layout.
\definecolor{white}{HTML}{FFFFFF}
\definecolor{black}{HTML}{000000}
\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{5D5D5D}
\definecolor{lightgray}{HTML}{999999}
% Legacy named colors retained for existing documents.
\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}
% Map semantic text roles to neutral colors.
\definecolor{darktext}{HTML}{414141}
\colorlet{text}{darkgray}
\colorlet{graytext}{gray}
\colorlet{lighttext}{lightgray}
\colorlet{sectiondivider}{gray}
% Original accents; choose one with \colorlet{awesome}{awesome-red}.
\definecolor{awesome-emerald}{HTML}{00A388}
\definecolor{awesome-skyblue}{HTML}{0395DE}
\definecolor{awesome-red}{HTML}{DC3522}
\definecolor{awesome-pink}{HTML}{EF4089}
\definecolor{awesome-orange}{HTML}{FF6138}
\definecolor{awesome-nephritis}{HTML}{27AE60}
\definecolor{awesome-concrete}{HTML}{95A5A6}
\definecolor{awesome-darknight}{HTML}{131A28}
% Catppuccin's Mauve accent in each of its four official flavors.
% These colors change accents on the existing white page; they do not recolor it.
\definecolor{awesome-catppuccin-latte}{HTML}{8839EF}
\definecolor{awesome-catppuccin-frappe}{HTML}{CA9EE6}
\definecolor{awesome-catppuccin-macchiato}{HTML}{C6A0F6}
\definecolor{awesome-catppuccin-mocha}{HTML}{CBA6F7}
\colorlet{awesome}{awesome-red}

% When true, the first three characters of Latin section titles use the accent.
\newbool{acvSectionColorHighlight}
\setbool{acvSectionColorHighlight}{true}


% Font choices for each part of the CV
\newcommand*{\headerfont}{\ifbool{acvArabicMode}{\arabicfont}{\roboto\selectfont}}
\newcommand*{\headerfontlight}{\ifbool{acvArabicMode}{\arabicfont}{\roboto\fontseries{l}\selectfont}}
\newcommand*{\footerfont}{\ifbool{acvArabicMode}{\arabicfont}{\sffamily}}
\newcommand*{\bodyfont}{\ifbool{acvArabicMode}{\arabicfont}{\sffamily}}
\newcommand*{\bodyfontlight}{\ifbool{acvArabicMode}{\arabicfont}{\sffamily\fontseries{l}\selectfont}}


% Typography used by headers, entries, and letters
% Each style takes already-supplied content and applies its font and color.
% Header, section, and paragraph typography.
\newcommand*{\headerfirstnamestyle}[1]{{\fontsize{32pt}{1em}\headerfontlight\color{graytext} #1}}
\newcommand*{\headerlastnamestyle}[1]{{\fontsize{32pt}{1em}\headerfont\bfseries\color{text} #1}}
\newcommand*{\headerpositionstyle}[1]{{\fontsize{7.6pt}{1em}\bodyfont\scshape\color{awesome} #1}}
\newcommand*{\headeraddressstyle}[1]{{\fontsize{8pt}{1em}\headerfont\itshape\color{lighttext} #1}}
\newcommand*{\headersocialstyle}[1]{{\fontsize{6.8pt}{1em}\headerfont\color{text} #1}}
\newcommand*{\headerquotestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\itshape\color{darktext} #1}}
\newcommand*{\footerstyle}[1]{{\fontsize{8pt}{1em}\footerfont\scshape\color{lighttext} #1}}
\newcommand*{\sectionstyleface}[1]{{\fontsize{16pt}{1em}\bodyfont\bfseries #1}}
\newcommand*{\sectionstyle}[1]{%
  \def\@acvSectionTmp{#1}
  \ifbool{acvArabicMode}{\color{text}\sectionstyleface{#1}}{%
  \ifthenelse{\boolean{acvSectionColorHighlight}}{%
    \StrSplit{\@acvSectionTmp}{3}{\acvSectionStringAwesome}{\acvSectionStringPlain}%
      \color{awesome}\sectionstyleface{\acvSectionStringAwesome%
      \color{text}{\acvSectionStringPlain}}}%
      {\color{text}\sectionstyleface{\@acvSectionTmp}}}}
\newcommand*{\subsectionstyle}[1]{{\fontsize{12pt}{1em}\bodyfont\scshape\textcolor{text}{#1}}}
\newcommand*{\paragraphstyle}{\fontsize{9pt}{1em}\bodyfontlight\upshape\color{text}}

% Typography for work and education entries.
\newcommand*{\entrytitlestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\entrypositionstyle}[1]{{\fontsize{8pt}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\entrydatestyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\entrylocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\slshape\color{awesome} #1}}
\newcommand*{\descriptionstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\upshape\color{text} #1}}

% Smaller typography for nested entries.
\newcommand*{\subentrytitlestyle}[1]{{\fontsize{8pt}{1em}\bodyfont\mdseries\color{graytext} #1}}
\newcommand*{\subentrypositionstyle}[1]{{\fontsize{7pt}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\subentrydatestyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\subentrylocationstyle}[1]{{\fontsize{7pt}{1em}\bodyfontlight\slshape\color{awesome} #1}}
\newcommand*{\subdescriptionstyle}[1]{{\fontsize{8pt}{1em}\bodyfontlight\upshape\color{text} #1}}

% Typography for awards and honors.
\newcommand*{\honortitlestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\color{graytext} #1}}
\newcommand*{\honorpositionstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\honordatestyle}[1]{{\fontsize{9pt}{1em}\bodyfont\color{graytext} #1}}
\newcommand*{\honorlocationstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\slshape\color{awesome} #1}}

% Typography for skill names and descriptions.
\newcommand*{\skilltypestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\skillsetstyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\color{text} #1}}

% Typography for recipient details and letter text.
\newcommand*{\lettersectionstyleface}[1]{{\fontsize{14pt}{1em}\bodyfont\bfseries #1}}
\newcommand*{\lettersectionstyle}[1]{%
  \def\@acvLetterSectionTmp{#1}
  \ifbool{acvArabicMode}{\color{text}\lettersectionstyleface{#1}}{%
  \ifthenelse{\boolean{acvSectionColorHighlight}}{%
    \StrSplit{\@acvLetterSectionTmp}{3}{\acvLetterSectionStringAwesome}{\acvLetterSectionStringPlain}%
      \color{awesome}\sectionstyleface{\acvLetterSectionStringAwesome%
      \color{text}{\acvLetterSectionStringPlain}}}%
      {\color{text}\lettersectionstyleface{\@acvLetterSectionTmp}}}}
\newcommand*{\recipientaddressstyle}[1]{{\fontsize{9pt}{1em}\bodyfont\scshape\color{graytext} #1}}
\newcommand*{\recipienttitlestyle}[1]{{\fontsize{11pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\lettertitlestyle}[1]{{\fontsize{10pt}{1em}\bodyfontlight\bfseries\color{darktext} \underline{#1}}}
\newcommand*{\letterdatestyle}[1]{{\fontsize{9pt}{1em}\bodyfontlight\slshape\color{graytext} #1}}
\newcommand*{\lettertextstyle}{\fontsize{10pt}{1.4em}\bodyfontlight\upshape\color{graytext}}
\newcommand*{\letternamestyle}[1]{{\fontsize{10pt}{1em}\bodyfont\bfseries\color{darktext} #1}}
\newcommand*{\letterenclosurestyle}[1]{{\fontsize{10pt}{1em}\bodyfontlight\slshape\color{lighttext} #1}}



% Public commands for contact details and letter metadata
% Store the optional image and parse its shape, border, and side settings.
% Call \photo[circle|rectangle,edge|noedge,left|right]{<path-to-image>}.
\newcommand{\photo}[2][circle,edge,left]{%
  \def\@photo{#2}
  \@for\tmp:=#1\do{%
    \ifthenelse{\equal{\tmp}{circle} \or \equal{\tmp}{rectangle}}%
      {\let\@photoshape\tmp}{}%
    \ifthenelse{\equal{\tmp}{edge} \or \equal{\tmp}{noedge}}%
      {\let\@photoedge\tmp}{}%
    \ifthenelse{\equal{\tmp}{left} \or \equal{\tmp}{right}}%
      {\let\@photoalign\tmp}{}%
  }%
}
\def\@photoshape{circle}
\def\@photoedge{edge}
\def\@photoalign{left}

% Store the given and family names used in the header and letter closing.
% Call \name{<firstname>}{<lastname>}.
% Call \firstname{<firstname>}.
% Call \lastname{<lastname>}.
% Call \familyname{<familyname>}.
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}

% Store the address shown beneath the job title.
% Call \address{<address>}.
\newcommand*{\address}[1]{\def\@address{#1}}

% Store the professional title shown in the header.
% Call \position{<position>}.
\newcommand*{\position}[1]{\def\@position{#1}}

% Save a readable phone number and a punctuation-free tel link.
% Call \mobile{<mobile number>}.
\newcommand*{\mobile}[1]
{
  \def\@mobile{#1}
  \def\@teluri{tel:\@mobile}
  % Keep spaces and punctuation out of the tel URI.
  \StrDel{\@teluri}{ }[\@teluri]%
  \StrDel{\@teluri}{-}[\@teluri]%
  \StrDel{\@teluri}{(}[\@teluri]%
  \StrDel{\@teluri}{)}[\@teluri]%
}

% Save a readable number and a wa.me link without formatting characters.
% Call \whatsapp{<mobile number>}.
\newcommand*{\whatsapp}[1]
{
  \def\@whatsapp{#1}
  \def\@wameuri{https://wa.me/\@whatsapp}
  % WhatsApp requires digits only in its wa.me URL.
  \StrDel{\@wameuri}{ }[\@wameuri]%
  \StrDel{\@wameuri}{+}[\@wameuri]%
  \StrDel{\@wameuri}{-}[\@wameuri]%
  \StrDel{\@wameuri}{(}[\@wameuri]%
  \StrDel{\@wameuri}{)}[\@wameuri]%
}

% Store the optional email shown in the contact header.
% Call \email{<email address>}.
\newcommand*{\email}[1]{\def\@email{#1}}

% Store the optional date of birth shown in the contact header.
% Call \dateofbirth{<date>}.
\newcommand*{\dateofbirth}[1]{\def\@dateofbirth{#1}}

% Store the optional homepage shown in the contact header.
% Call \homepage{<url>}.
\newcommand*{\homepage}[1]{\def\@homepage{#1}}

% Store the GitHub username linked from the contact header.
% Call \github{<github-nick>}.
\newcommand*{\github}[1]{\def\@github{#1}}

% Store the GitLab username linked from the contact header.
% Call \gitlab{<gitlab-nick>}.
\newcommand*{\gitlab}[1]{\def\@gitlab{#1}}

% Store the Bitbucket username linked from the contact header.
% Call \bitbucket{<bitbucket-nick>}.
\newcommand*{\bitbucket}[1]{\def\@bitbucket{#1}}

% Store the Stack Overflow user ID for the link and a readable display name.
% Call \stackoverflow{<so userid>}{<so username>}.
% For example, a Stack Overflow URL ending in /users/123456/sam-smith
% uses \stackoverflow{123456}{sam-smith}.
\newcommand*{\stackoverflow}[2]{\def\@stackoverflowid{#1}\def\@stackoverflowname{#2}}

% Store the LinkedIn username linked from the contact header.
% Call \linkedin{<linked-in-nick>}.
\newcommand*{\linkedin}[1]{\def\@linkedin{#1}}

% Store the ORCID identifier linked from the contact header.
% Call \orcid{<orcid-num>}.
\newcommand*{\orcid}[1]{\def\@orcid{#1}}

% Store the Twitter handle linked from the contact header.
% Call \twitter{<twitter handle>}.
\newcommand*{\twitter}[1]{\def\@twitter{#1}}

% Store the X account linked from the contact header.
% Call \x{<x account>}.
\newcommand*{\x}[1]{\def\@x{#1}}

% Store the optional Mastodon shown in the contact header.
% Call \mastodon{<instance>}{<mastodon-nick>}.
\newcommand*{\mastodon}[2]{\def\@mastodoninstance{#1}\def\@mastodonname{#2}}

% Store the ResearchGate profile linked from the contact header.
% Call \researchgate{<researchgate-account>}.
\newcommand*{\researchgate}[1]{\def\@researchgate{#1}}

% Store the optional skype shown in the contact header.
% Call \skype{<skype account>}.
\newcommand*{\skype}[1]{\def\@skype{#1}}

% Store the optional reddit shown in the contact header.
% Call \reddit{<reddit account>}.
\newcommand*{\reddit}[1]{\def\@reddit{#1}}

% Store the optional xing shown in the contact header.
% Call \xing{<xing name>}.
\newcommand*{\xing}[1]{\def\@xing{#1}}

% Store the optional medium profile shown in the contact header.
% Call \medium{<medium account>}.
\newcommand*{\medium}[1]{\def\@medium{#1}}

% Store the optional kaggle shown in the contact header.
% Call \kaggle{<kaggle handle>}.
\newcommand*{\kaggle}[1]{\def\@kaggle{#1}}

% Store the optional Hackerrank shown in the contact header.
% Call \hackerrank{<Hackerrank profile name>}.
\newcommand*{\hackerrank}[1]{\def\@hackerrank{#1}}

% Store the optional Telegram shown in the contact header.
% Call \telegram{<Telegram username>}.
\newcommand*{\telegram}[1]{\def\@telegram{#1}}

% Store the Scholar profile ID and its display label.
% Call \googlescholar{<googlescholar userid>}{<googlescholar username>}.
% For example, a Scholar URL ending in user=wpZDx1cAAAAJ
% uses \googlescholar{wpZDx1cAAAAJ}{Visible name}.
% An empty display name falls back to the given and family names:
% the stored first and last names.
\newcommand*{\googlescholar}[2]{%
  \def\@googlescholarid{#1}%
  \ifthenelse{\equal{#2}{}}{%
    \def\@googlescholarname{\@firstname~\@lastname}%
  }{%
    \def\@googlescholarname{#2}%
  }%
}

% Store the optional extra information shown in the contact header.
% Call \extrainfo{<extra information>}.
\newcommand*{\extrainfo}[1]{\def\@extrainfo{#1}}

% Store the optional quote shown in the contact header.
% Call \quote{<quote>}.
\renewcommand*{\quote}[1]{\def\@quote{#1}}

% Store the recipient name and address for the letter heading.
% Call \recipient{<recipient name>}{<recipient address>}.
% Call \recipientname{<recipient name>}.
% Call \recipientaddress{<recipient address>}.
\newcommand*{\recipient}[2]{\def\@recipientname{#1}\def\@recipientaddress{#2}}
\newcommand*{\recipientname}[1]{\def\@recipientname{#1}}
\newcommand*{\recipientaddress}[1]{\def\@recipientaddress{#1}}

% Store an optional subject line for the cover letter.
% Call \lettertitle{<title>}.
\newcommand*{\lettertitle}[1]{\def\@lettertitle{#1}}

% Store the date printed opposite the recipient name.
% Call \letterdate{<date>}.
\newcommand*{\letterdate}[1]{\def\@letterdate{#1}}

% Store the salutation printed below the letter heading.
% Call \letteropening{<message>}.
\newcommand*{\letteropening}[1]{\def\@letteropening{#1}}

% Store the sign-off printed above the writer name.
% Call \letterclosing{<message>}.
\newcommand*{\letterclosing}[1]{\def\@letterclosing{#1}}

% Store an optional attachment label and description.
% Call \letterenclosure[<enclosure name>]{<enclosure>}.
\newcommand*{\letterenclname}[1][Enclosure]{\def\@letterenclname{#1}}
\newcommand*{\letterenclosure}[2][]{%
  % if an optional argument is provided, use it to redefine \enclname
  \ifthenelse{\equal{#1}{}}{}{\def\@letterenclname{#1}}
  \def\@letterenclosure{#2}
}



% Spacing knobs that documents may override
% Documents may redefine these lengths and separators in the preamble.
% Header spacing and separators.
\newcommand{\acvHeaderNameDelim}{\space}
\newcommand{\acvHeaderAfterNameSkip}{.4mm}
\newcommand{\acvHeaderAfterPositionSkip}{.4mm}
\newcommand{\acvHeaderAfterAddressSkip}{-.5mm}
\newcommand{\acvHeaderIconSep}{\space}
\newcommand{\acvHeaderSocialSep}{\BeginAccSupp{ActualText={}}\quad\textbar\quad\EndAccSupp{}}
\newcommand{\acvHeaderAfterSocialSkip}{6mm}
\newcommand{\acvHeaderAfterQuoteSkip}{5mm}

% Spacing before and inside CV sections.
\newcommand{\acvSectionTopSkip}{3mm}
\newcommand{\acvSectionContentTopSkip}{2.5mm}



% Small helpers shared by the layout commands
% Define left, centered, and right aligned columns for entry tables.
\renewcommand{\tabularxcolumn}{p}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}

% Fill remaining line width with a rule of the given thickness.
\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

% Choose a branch when optional content is empty.
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}

\newcommand{\faAlt}[3]{%
  \BeginAccSupp{ActualText={#1}}%
    \mbox{#2\acvHeaderIconSep#3}%
  \EndAccSupp{}%
}


% Render the CV header, footer, and content sections
% Compose the photo, name, title, contact links, and quotation.
% Call \makecvheader.
\newcommand*{\makecvheader}[1][C]{%
  % Build the photo only when a path was supplied. Shape, edge, and side come
  % from the optional argument of \photo; without a photo the text gets full width.
  \newcommand*{\drawphoto}{%
    \ifthenelse{\isundefined{\@photo}}{}{%
      \newlength{\photodim}
      \ifthenelse{\equal{\@photoshape}{circle}}%
        {\setlength{\photodim}{1.3cm}}%
        {\setlength{\photodim}{1.8cm}}%
      \ifthenelse{\equal{\@photoedge}{edge}}%
        {\def\@photoborder{darkgray}}%
        {\def\@photoborder{none}}%
      \begin{tikzpicture}%
        \node[\@photoshape, draw=\@photoborder, line width=0.3mm, inner sep=\photodim, fill overzoom image=\@photo] () {};
      \end{tikzpicture}
    }%
  }
  \newlength{\headertextwidth}
  \newlength{\headerphotowidth}
  \ifthenelse{\isundefined{\@photo}}{
    \setlength{\headertextwidth}{\textwidth}
    \setlength{\headerphotowidth}{0cm}
  }{%
    \setlength{\headertextwidth}{0.76\textwidth}
    \setlength{\headerphotowidth}{0.24\textwidth}
  }%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{left}}{\raggedright\drawphoto}{}
  \end{minipage}
  \begin{minipage}[c]{\headertextwidth}
    % L, R, and the default C control the header as a whole.
    \ifthenelse{\equal{#1}{L}}{\raggedright}{\ifthenelse{\equal{#1}{R}}{\raggedleft}{\centering}}
    \headerfirstnamestyle{\@firstname}\headerlastnamestyle{{}\acvHeaderNameDelim\@lastname}%
    \\[\acvHeaderAfterNameSkip]%
    \ifthenelse{\isundefined{\@position}}{}{\headerpositionstyle{\@position\\[\acvHeaderAfterPositionSkip]}}%
    \ifthenelse{\isundefined{\@address}}{}{\headeraddressstyle{\@address\\[\acvHeaderAfterAddressSkip]}}%
    \headersocialstyle{%
      % Each optional field prints only when defined. isstart prevents a
      % separator before the first visible contact method.
      \newbool{isstart}%
      \setbool{isstart}{true}%
      \ifthenelse{\isundefined{\@mobile}}%
        {}%
        {%
          \href{\@teluri}{\faAlt{tel:\@mobile}{\faMobile}{\@mobile}}%
          \setbool{isstart}{false}%
        }%
      \ifthenelse{\isundefined{\@whatsapp}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{\@wameuri}{\faAlt{WhatsApp: \@whatsapp}{\faSquareWhatsapp}{\@whatsapp}}%
        }%
      \ifthenelse{\isundefined{\@email}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{mailto:\@email}{\faAlt{mailto:\@email}{\faEnvelope}{\@email}}%
        }%
      \ifthenelse{\isundefined{\@dateofbirth}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \faAlt{DoB: \@dateofbirth}{\faCakeCandles}{\@dateofbirth}%
        }%
      \ifthenelse{\isundefined{\@homepage}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{\@homepage}{\faAlt{homepage: \@homepage}{\faHouseChimney}{\@homepage}}%
        }%
      \ifthenelse{\isundefined{\@github}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://github.com/\@github}{\faAlt{GitHub: @\@github}{\faSquareGithub}{\@github}}%
        }%
      \ifthenelse{\isundefined{\@gitlab}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://gitlab.com/\@gitlab}{\faAlt{GitLab: @\@gitlab}{\faGitlab}{\@gitlab}}%
        }%
      \ifthenelse{\isundefined{\@bitbucket}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://bitbucket.com/\@bitbucket}{\faAlt{BitBucket: @\@bitbucket}{\faBitbucket}{\@bitbucket}}%
        }%
      \ifthenelse{\isundefined{\@stackoverflowid}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://stackoverflow.com/users/\@stackoverflowid}{\faAlt{StackOverflow: @\@stackoverflowname}{\faStackOverflow}{\@stackoverflowname}}%
        }%
      \ifthenelse{\isundefined{\@linkedin}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.linkedin.com/in/\@linkedin}{\faAlt{LinkedIn: /in/\@linkedin}{\faLinkedin}{\@linkedin}}%
        }%
      \ifthenelse{\isundefined{\@orcid}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://orcid.org/\@orcid}{\faAlt{OrcID: \@orcid}{\faOrcid}{\@orcid}}%
        }%
      \ifthenelse{\isundefined{\@twitter}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://twitter.com/\@twitter}{\faAlt{Twitter: @\@twitter}{\faTwitter}{\@twitter}}%
        }%
      \ifthenelse{\isundefined{\@x}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://x.com/\@x}{\faAlt{X: @\@x}{\faXTwitter}{\@x}}%
        }%
      \ifthenelse{\isundefined{\@mastodonname}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://\@mastodoninstance/@\@mastodonname}{\faAlt{Mastodon: \@mastodonname{}@\@mastodoninstance}{\faMastodon}{\@mastodonname}}%
        }%
      \ifthenelse{\isundefined{\@skype}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \faAlt{Skype: \@skype}{\faSkype}{\@skype}%
        }%
      \ifthenelse{\isundefined{\@reddit}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.reddit.com/user/\@reddit}{\faAlt{Reddit: /u/\@reddit}{\faReddit}{\@reddit}}%
        }%
      \ifthenelse{\isundefined{\@researchgate}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.researchgate.net/profile/\@researchgate}{\faAlt{ResearchGate: \@researchgate}{\faResearchgate}{\@researchgate}}%
        }%
      \ifthenelse{\isundefined{\@xing}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.xing.com/profile/\@xing}{\faAlt{Xing: \@xing}{\faSquareXing}{\@xing}}
        }%
      \ifthenelse{\isundefined{\@medium}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://medium.com/@\@medium}{\faAlt{Medium: @\@medium}{\faMedium}{\@medium}}%
        }%
      \ifthenelse{\isundefined{\@kaggle}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://kaggle.com/\@kaggle}{\faAlt{Kaggle: \@kaggle}{\faKaggle}{\@kaggle}}%
        }%
      \ifthenelse{\isundefined{\@hackerrank}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://www.hackerrank.com/\@hackerrank}{\faAlt{HackerRank: \@hackerrank}{\faHackerrank}{\@hackerrank}}%
        }%
      \ifthenelse{\isundefined{\@telegram}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://t.me/\@telegram}{\faAlt{Telegram: \@telegram}{\faTelegram}{\@telegram}}%
        }%
      \ifthenelse{\isundefined{\@googlescholarid}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \href{https://scholar.google.com/citations?user=\@googlescholarid}{\faAlt{Google Scholar: \@googlescholarid}{\faGraduationCap}{\@googlescholarname}}%
        }%
      \ifthenelse{\isundefined{\@extrainfo}}%
        {}%
        {%
          \ifbool{isstart}{\setbool{isstart}{false}}{\acvHeaderSocialSep}%
          \@extrainfo%
        }%
    } \\[\acvHeaderAfterSocialSkip]%
    \ifthenelse{\isundefined{\@quote}}%
      {}%
      {\headerquotestyle{\@quote\\}\vspace{\acvHeaderAfterQuoteSkip}}%
  \end{minipage}%
  \begin{minipage}[c]{\headerphotowidth}%
    \ifthenelse{\equal{\@photoalign}{right}}{\raggedleft\drawphoto}{}
  \end{minipage}
}

% Put caller-supplied text into left, center, and right footer slots.
% Call \makecvfooter{<left>}{<center>}{<right>}.
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  \fancyfoot[L]{\footerstyle{#1}}
  \fancyfoot[C]{\footerstyle{#2}}
  \fancyfoot[R]{\footerstyle{#3}}
}

% Print a heading and its divider rule.
% Call \cvsection{<section-title>}.
\newcommand{\cvsection}[1]{%
  \vspace{\acvSectionTopSkip}
  \sectionstyle{#1}
  \phantomsection
  \color{sectiondivider}\vhrulefill{0.9pt}
}

% Print a smaller heading beneath a CV section.
% Call \cvsubsection{<subsection-title>}.
\newcommand{\cvsubsection}[1]{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-3mm}
  \subsectionstyle{#1}
  \phantomsection
}

% Add the compact spacing and text style used by summaries.
\newenvironment{cvparagraph}{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-3mm}
  \paragraphstyle
}{%
  \par
  \vspace{2mm}
}

% Group regular entries with section spacing.
\newenvironment{cventries}{%
  \vspace{\acvSectionContentTopSkip}
  \begin{center}
}{%
  \end{center}
}
% Lay out role, organization, place, date, and optional description.
% Call \cventry{<position>}{<title>}{<location>}{<date>}{<description>}.
\newcommand*{\cventry}[5]{%
  % The wide left column holds the role and organization; the narrow right
  % column holds location and date. The description spans both columns.
  \vspace{-2.0mm}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \ifempty{#2#3}
      {\entrypositionstyle{#1} & \entrydatestyle{#4} \\}
      {\entrytitlestyle{#2} & \entrylocationstyle{#3} \\
      \entrypositionstyle{#1} & \entrydatestyle{#4} \\}
    \ifstrempty{#5}
      {}
      {\multicolumn{2}{L{\textwidth}}{\descriptionstyle{#5}} \\}
  \end{tabular*}%
}

% Center a group of nested entries.
\newenvironment{cvsubentries}{%
  \begin{center}
}{%
  \end{center}
}
% Lay out a compact role, title, date, and description.
% Call \cvsubentry{<position>}{<title>}{<date>}{<description>}.
\newcommand*{\cvsubentry}[4]{%
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \setlength\leftskip{0.2cm}
    \subentrytitlestyle{#2} & \ifthenelse{\equal{#1}{}}
      {\subentrydatestyle{#3}}{}
    \ifthenelse{\equal{#1}{}}
      {}
      {\subentrypositionstyle{#1} & \subentrydatestyle{#3} \\}
    \ifthenelse{\equal{#4}{}}
      {}
      {\multicolumn{2}{L{17.0cm}}{\subdescriptionstyle{#4}} \\}
  \end{tabular*}
}

% Open the three-column table used for awards.
\newenvironment{cvhonors}{%
  \vspace{\acvSectionContentTopSkip}
  \vspace{-2mm}
  \begin{center}
    \setlength\tabcolsep{0pt}
    \setlength{\extrarowheight}{0pt}
    \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} C{1.5cm} L{\textwidth - 4.0cm} R{2.5cm}}
}{%
    \end{tabular*}
  \end{center}
}
% Put an award date, name, title, and place in the open table.
% Call \cvhonor{<position>}{<title>}{<location>}{<date>}.
\newcommand*{\cvhonor}[4]{%
  \honordatestyle{#4} & \honorpositionstyle{#1}\ifempty{#2}{}{,} \honortitlestyle{#2} & \honorlocationstyle{#3} \\
}

% Open the two-column skill table.
\newenvironment{cvskills}{%
  % The fixed-width category column leaves remaining space for long skill text.
  \vspace{\acvSectionContentTopSkip}
  \vspace{-2.0mm}
    \setlength\tabcolsep{1ex}
    \setlength{\extrarowheight}{0pt}
    \tabularx{\textwidth}{r>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}X}
}{%
\endtabularx\par
}

% Put a skill category beside its description.
% Call \cvskill{<type>}{<skillset>}.
\newcommand*{\cvskill}[2]{%
  \skilltypestyle{#1} & \leavevmode\skillsetstyle{#2} \\
}

% Use tight bullet spacing inside an entry description.
\newenvironment{cvitems}{%
  \vspace{-4.0mm}
  \begin{justify}
  \begin{itemize}[leftmargin=2ex, nosep, noitemsep]
    \setlength{\parskip}{0pt}
    \renewcommand{\labelitemi}{\bullet}
}{%
  \end{itemize}
  \end{justify}
  \vspace{1.0mm}
}



% Render the cover letter body and closing
% Apply the letter body font to enclosed paragraphs.
\newenvironment{cvletter}{%
  \lettertextstyle
}{%
}

% Print a letter heading, divider, and following body style.
% Call \lettersection{<section-title>}.
\newcommand{\lettersection}[1]{%
  \par\addvspace{2.5ex}
  \phantomsection{}
  \lettersectionstyle{#1}
  \color{sectiondivider}\vhrulefill{0.9pt}
  \par\nobreak\addvspace{0.4ex}
  \lettertextstyle
}

% Print the recipient, date, address, optional subject, and salutation.
% Call \makelettertitle.
\newcommand*{\makelettertitle}{%
  \vspace{8.4mm}
  \setlength\tabcolsep{0pt}
  \setlength{\extrarowheight}{0pt}
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}} L{\textwidth - 4.5cm} R{4.5cm}}
    \recipienttitlestyle{\@recipientname} & \letterdatestyle{\@letterdate}
  \end{tabular*}
  \begin{singlespace}
    \recipientaddressstyle{\@recipientaddress} \\\\
  \end{singlespace}
  \ifthenelse{\isundefined{\@lettertitle}}
    {}
    {\lettertitlestyle{\@lettertitle} \\}
  \lettertextstyle{\@letteropening}
}

% Print the sign-off, name, and any enclosure.
% Call \makeletterclosing.
\newcommand*{\makeletterclosing}{%
  \vspace{3.4mm}
  \lettertextstyle{\@letterclosing} \\\\
  \letternamestyle{\@firstname\ \@lastname}
  \ifthenelse{\isundefined{\@letterenclosure}}
    {\\}
    {%
      \\\\\\
      \letterenclosurestyle{\@letterenclname: \@letterenclosure} \\
    }
}
