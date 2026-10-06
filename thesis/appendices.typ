= Reproduction Protocol <reproduction>

== Requirements and commands

Install Typst 0.15.1 and provide a Unix-like host with sh, mktemp, cp, cat, rm,
mkdir, ln, chmod, cmp, find, wc, tr, and make. The implementation was verified
on the platform recorded in the evaluation chapter. No Typst package download
is required by the local template or compiler.

From the repository root, run:

```sh
make all
make demo
```

The first command runs the suite, updates the verification record, and compiles
both PDFs. The second creates the supplied example tree under build/demo.
For conversion in a different destination:

```sh
mkdir -p /tmp/my-json2dir-output
cd /tmp/my-json2dir-output
/path/to/json2dir-thesis/bin/json2dir < /path/to/tree.json
```

The generic paths above are examples to replace with local paths. Inspection
does not apply the tree:

```sh
bin/json2dir --plan < examples/tree.json
bin/json2dir --emit < examples/tree.json
```

The compiler can also be called directly without the adapter:

```sh
typst compile --features bundle --format bundle --root . \
  src/main.typ build/bundle
```

Its default input is the repository example. A different file inside the
selected project root can be provided with the tree input option. The bundle
contains apply.sh and plan.json. Executing apply.sh separately applies its tree
to the directory where that generated program is run.

== Source and license provenance

The original json2dir was read from the neighboring project. Its inspected
revision is #raw("b2072fb5515a603024c123297b27dcaabfdf098a"). Its license text is
retained at the repository root; its source language is not required to build
the port. The MIT license for benplate is retained under templates. The adapted
template has no remote imports, and uses fonts embedded in the Typst compiler.

== Interpreting generated records

verification/results.json records a successful test run. It is not an input
acceptance certificate or a formal proof. Re-running make test refreshes the
record, which may change the compiler version, platform, time, and test counts.
Rebuilding the dissertation reads that refreshed record. The stable document
date refers to the project edition, not a claim that all future tests ran on
the same day.

= The Entire Typst Compiler <compiler-listing>

The following listing is read directly from the implementation source at build
time. It is not a manually maintained transcription. Its presence turns the
dissertation into a rather literal example of literate overcommitment.

== Library

#raw(read("/src/lib.typ"), block: true, lang: "typst")

== Bundle entry point

#raw(read("/src/main.typ"), block: true, lang: "typst")

= A Mock Oral Defense <defense>

== Examiner: Why Typst?

Candidate: Because the brief required Typst, and its scripting and experimental
bundle facilities are sufficient to compile the conversion program. The choice
also exposes the boundary between planning and filesystem effects unusually
clearly. I have not claimed that it is the fastest or most conventional choice.

Examiner: Could you have stopped after writing mkdir?

Candidate: Certainly. But the four-constructor format also needs file contents,
links, and executable bits. More seriously, a real port needs the replacement
and error cases. Less seriously, stopping there would have left insufficient
material for the Faculty of Unnecessary Computer Science.

== Examiner: Is it really pure Typst?

Candidate: The parser binding, validator, traversal, representation, quoting,
byte encoder, statistics, and emitter are Typst. A shell adapter performs
transport and invokes the emitted program. That boundary is documented. Typst
itself does not expose native symlink or chmod operations in this implementation.

Examiner: Have you hidden Python somewhere?

Candidate: No runtime or test conversion logic uses Python. The source and fixture
generation are Typst, and host integration checks are shell. The dissertation
does not need a foreign-code plugin.

== Examiner: What is the most dangerous conclusion?

Candidate: That passing tests make a path-based program safe against concurrent
attackers. They do not. The program does not provide descriptor-relative race
protection, rollback, or untrusted-root confinement. Input validation is useful,
but it is not a substitute for a threat model and a different host backend.

Examiner: Why no graph showing Typst defeating Rust?

Candidate: Because no comparative benchmark was run. A fictional graph would be
an entertaining picture and an invalid experimental result. The present thesis
already contains enough fiction in its institutional stationery.

== Examiner: What is the original contribution?

Candidate: A working Typst compiler for the conversion, an explicit execution
boundary, byte-preserving generated payload handling, and tests for real
filesystem outcomes. The intellectual contribution is modest. The typography
has been allowed to remain ambitious.

Examiner: Your degree is approved, subject to one correction.

Candidate: Which correction?

Examiner: Please place the diploma next to the dissertation.

Candidate: Already done.
