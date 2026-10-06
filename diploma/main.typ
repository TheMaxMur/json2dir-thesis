#import "../templates/thesis.typ": accent-color, muted
#set document(title: "Fictional Diploma: Doctor of Philosophical Directories",
  author: "Institute of Recursive Administration", date: datetime(year: 2026, month: 10, day: 6))
#set page(paper: "a4", flipped: true, margin: 19mm,
  background: {
    place(center + horizon, rect(width: 268mm, height: 181mm, stroke: 1pt + accent-color))
    place(center + horizon, rect(width: 262mm, height: 175mm, stroke: 0.35pt + accent-color))
  })
#set text(font: "Libertinus Serif", size: 12pt, lang: "en")
#set par(leading: 0.4em, spacing: 0.3em)
#set align(center)
#v(3mm)
#text(size: 13pt, tracking: 2pt)[INSTITUTE OF RECURSIVE ADMINISTRATION]
#v(3mm)
#text(size: 10pt, fill: muted)[Faculty of Unnecessary Computer Science]
#v(6mm)
#text(size: 38pt, fill: accent-color)[DIPLOMA]
#v(5mm)
By the entirely imaginary authority vested in this institution,
#v(3mm)
#text(size: 22pt, weight: "bold")[The json2dir Research Collective]
#v(3mm)
is hereby awarded the fictional degree of
#v(4mm)
#text(size: 25pt, fill: accent-color)[Doctor of Philosophical Directories]
#v(4mm)
for the dissertation
#v(2mm)
#text(size: 16pt, style: "italic")[The Typographical Filesystem]
#v(3mm)
and for demonstrating that a typesetter can create folders #linebreak()
after first producing an alarming quantity of academic paperwork.
#v(4mm)
#grid(columns: (1fr, auto, 1fr), align: center + horizon,
  [#line(length: 55mm) #linebreak() Professor Ada Mkdir
    #linebreak() Supervisor of Parent Directories],
  circle(radius: 12mm, stroke: 0.8pt + accent-color)[
    #align(center + horizon, text(size: 20pt, fill: accent-color)[#raw("{}")])
  ],
  [#line(length: 55mm) #linebreak() Dr. Sybil Link
    #linebreak() External Examiner, Literally],
)
#v(5mm)
#text(size: 10pt)[6 October 2026 · Certificate No. JSON-0001 · Awarded with Recursive Distinction]
#v(3mm)
#text(size: 9pt, fill: muted)[SATIRICAL DOCUMENT - FICTIONAL INSTITUTION - NO ACADEMIC CREDENTIAL]
