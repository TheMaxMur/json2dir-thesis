// Adapted from benplate 0.1.0 by Ben Dierks, MIT licensed.
// See benplate-LICENSE and PROVENANCE.md for source and adaptation details.
#let accent-color = rgb("a51c30")
#let ink = rgb("24272b")
#let muted = rgb("62666c")
#let shade = rgb("f5f2ee")

#let aside(title, body) = block(
  width: 100%, fill: shade, inset: 12pt, radius: 2pt,
  stroke: (left: 2pt + accent-color),
)[
  #text(fill: accent-color, weight: "bold")[#title]
  #parbreak()
  #body
]

#let thesis(title: "", author: "", frontmatter: [], appendix: [], backmatter: [], body) = {
  set document(title: title, author: author, date: datetime(year: 2026, month: 10, day: 6))
  set text(font: "Libertinus Serif", size: 11pt, fill: ink, lang: "en", hyphenate: true)
  set par(justify: true, leading: 0.6em, spacing: 0.7em)
  set page(paper: "a4", margin: (top: 28mm, bottom: 25mm, left: 29mm, right: 26mm),
    header: text(size: 8pt, fill: muted)[INSTITUTE OF RECURSIVE ADMINISTRATION #h(1fr) JSON2DIR],
    footer: context align(center, text(size: 9pt, counter(page).display())),
  )
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    set text(hyphenate: false)
    pagebreak(weak: true)
    block(above: 12pt, below: 28pt)[
      #context if it.numbering != none {
        text(size: 11pt, fill: accent-color, tracking: 1pt)[CHAPTER #counter(heading).display()]
        v(8pt)
      }
      #text(size: 25pt, weight: "medium", it.body)
      #v(9pt)
      #line(length: 35mm, stroke: 1pt + accent-color)
    ]
  }
  show heading.where(level: 2): it => block(above: 16pt, below: 8pt, text(size: 14pt, weight: "bold", it))
  show heading.where(level: 3): it => block(above: 10pt, below: 6pt, text(size: 11pt, weight: "bold", it))
  show link: set text(fill: accent-color)
  show raw: set text(font: "DejaVu Sans Mono", size: 8.3pt, hyphenate: false)
  show raw.where(block: true): it => block(width: 100%, fill: shade, inset: 10pt, radius: 2pt, it)
  set figure(numbering: "1", gap: 8pt)
  show figure.caption: set text(size: 9pt)
  set table(stroke: 0.4pt + rgb("ddd6ce"), inset: 7pt)
  show table: set text(size: 9.5pt)
  set math.equation(numbering: "(1)")
  set outline(indent: 1em)
  set page(numbering: "i")
  set heading(numbering: none)
  frontmatter
  pagebreak()
  counter(page).update(1)
  counter(heading).update(0)
  set page(numbering: "1")
  set heading(numbering: "1.1")
  body
  counter(heading).update(0)
  set heading(numbering: "A.1")
  appendix
  set heading(numbering: none)
  backmatter
}

#let cover(title, author) = {
  set page(header: none, footer: none)
  set align(center)
  v(9mm)
  text(size: 11pt, tracking: 1.5pt)[INSTITUTE OF RECURSIVE ADMINISTRATION]
  v(5pt)
  text(size: 10pt, fill: muted)[Faculty of Unnecessary Computer Science]
  v(18mm)
  circle(radius: 19mm, stroke: 1pt + accent-color)[
    #align(center + horizon,
      text(size: 32pt, fill: accent-color, font: "DejaVu Sans Mono", "{}"))
  ]
  v(19mm)
  text(size: 31pt, weight: "bold", title)
  v(7mm)
  text(size: 14pt, fill: muted)[A Typst Implementation and a Doctoral Study of Creating Folders the Hard Way]
  v(15mm)
  text(size: 13pt, author)
  v(5mm)
  text(size: 11pt)[A satirical dissertation submitted for the fictional degree of]
  v(3pt)
  text(size: 14pt, fill: accent-color)[Doctor of Philosophical Directories]
  v(1fr)
  text(size: 10pt)[Supervisor: Professor Ada Mkdir #linebreak()
    Examiners: Dr. Sybil Link and Professor Rex Cursion #linebreak()
    Department of Braces, Permissions, and Related Drama]
  v(10mm)
  text(size: 11pt)[6 October 2026]
  v(3pt)
  text(size: 9pt, fill: muted)[FICTIONAL INSTITUTION - REAL SOURCE CODE]
}
