#import "../templates/thesis.typ": thesis, cover, aside, accent-color, muted
#let title = [The Typographical Filesystem]
#let author = "The json2dir Research Collective"
#import "context.typ": results
#show: thesis.with(
  title: "The Typographical Filesystem: json2dir in Typst",
  author: author,
  frontmatter: [
    #cover(title, author)
    #heading(numbering: none)[Declaration of Excessive Originality]
    This dissertation is a work of technical satire. Its institution, degree,
    supervisor, examiners, and ceremonial claims are fictional. Its implementation,
    interface contract, cited documentation, and reported test results are real.

    The author declares that an ordinary task has been subjected to an extraordinary
    amount of typography. No committee was consulted before a typesetting language
    was asked to produce a shell program. Any resemblance to sensible engineering
    was discovered during testing and corrected only when it caused a bug.

    The original json2dir implementation is credited to Alan Urmancheev. The
    implementation studied here is a new Typst port based on its documented
    conversion scheme and the locally inspected Rust source at revision
    #raw("b2072fb5515a603024c123297b27dcaabfdf098a"). The original license is retained
    in the repository. The dissertation template is adapted from Ben Dierks's
    benplate 0.1.0 @benplate.

    Generated file contents may include executable text, but the compiler creates
    that text as data; it does not run the scripts described by the input. The
    filesystem application program performs only the operations necessary to
    materialize the declared tree.

    #v(12mm)
    #line(length: 65mm)
    The json2dir Research Collective #linebreak()
    Department of Having Already Gone Too Far #linebreak()
    6 October 2026

    #heading(numbering: none)[Abstract]
    Directory creation has traditionally been entrusted to programming languages
    that admit an interest in operating systems. This dissertation challenges
    that disciplinary prejudice by implementing json2dir in Typst, a language
    whose principal professional qualification is arranging words on pages.

    The proposed compiler accepts a JSON object, validates a four-constructor
    filesystem algebra, traverses its nodes with an explicit work stack, and
    emits a deterministic operation plan and a shell application program through
    Typst's experimental bundle export. Object values become directories, strings
    become UTF-8 files, and two-string arrays describe symbolic links and
    executable files. A thin host adapter transports standard input and executes
    the generated program; all conversion logic is expressed in Typst.

    The implementation preserves byte-exact payloads by encoding UTF-8 bytes as
    fixed-width octal escapes. It validates the complete input before destination
    mutation, replaces existing file and link entries, merges directories, and
    refuses to replace a directory with a non-directory node. Validation yields
    #results.unit.passed passing Typst unit assertions and
    #results.integration.passed passing integration scenarios on the recorded
    host. These results establish tested behavior, not universal correctness,
    security against concurrent attackers, or performance superiority.

    The principal conclusion is that a typesetting system can be made into a
    useful filesystem compiler, provided its author distinguishes compilation
    from execution and does not mistake a numbered theorem for a security proof.
    The secondary conclusion is that two braces can support a surprising amount
    of doctoral paperwork.

    *Keywords:* Typst; JSON; filesystem synthesis; staged compilation; byte
    preservation; academic overcommitment.

    #heading(numbering: none)[Acknowledgments]
    I thank Professor Ada Mkdir for insisting that every contribution have a
    parent directory, Dr. Sybil Link for pointing somewhere else whenever a
    question became difficult, and Professor Rex Cursion for returning only
    after the base case had been funded.

    I thank Alan Urmancheev for the original json2dir, the Typst maintainers for
    a language capable of participating in this incident, and Ben Dierks for a
    thesis template that gives even an unreasonable idea a respectable margin.

    I am grateful to the test suite for rejecting the first version of this
    implementation. In particular, macOS's chmod utility declined to recognize
    a double dash, and ln attempted to place a symlink inside an existing
    directory. These interventions contributed more to the dissertation than
    any of its fictional reviewers.

    This work received no grant funding. Its computational budget consisted of
    a local machine, an installed Typst compiler, and a refusal to choose a more
    appropriate language. The empty directory is thanked for its continued
    cooperation and its admirable publication record.

    #heading(numbering: none)[Contents]
    #outline(title: none, depth: 2)
  ],
  appendix: [
    #include "appendices.typ"
  ],
  backmatter: [
    #bibliography("references.bib", title: [References], style: "ieee")
  ],
)

#include "chapters/01-introduction.typ"
#include "chapters/02-background.typ"
#include "chapters/03-semantics.typ"
#include "chapters/04-architecture.typ"
#include "chapters/05-implementation.typ"
#include "chapters/06-correctness.typ"
#include "chapters/07-evaluation.typ"
#include "chapters/08-limitations.typ"
#include "chapters/09-discussion.typ"
#include "chapters/10-conclusion.typ"
