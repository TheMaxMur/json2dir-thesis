= Architecture: A Compiler Wearing a Graduation Gown <architecture>

== Stages and artifacts

The system has three stages. Transport copies the Typst sources into a private
temporary workspace and saves standard input as input.json. Compilation loads
that file, validates its tree, constructs a plan, and emits two assets.
Application executes the generated asset within the caller's current directory.
The temporary workspace is removed when the adapter exits.

#figure(
  stack(dir: ttb, spacing: 8pt,
    block(width: 100%, inset: 10pt, fill: rgb("f5f2ee"))[
      *1. Transport* #linebreak()
      stdin JSON -> isolated input.json and copied Typst sources
    ],
    align(center)[#text(size: 15pt)[↓]],
    block(width: 100%, inset: 10pt, fill: rgb("f5f2ee"))[
      *2. Typst compiler* #linebreak()
      JSON loading -> validation -> sorted plan -> byte-safe program
    ],
    align(center)[#text(size: 15pt)[↓]],
    block(width: 100%, inset: 10pt, fill: rgb("f5f2ee"))[
      *3. Selected output* #linebreak()
      plan.json | apply.sh | execute apply.sh in destination
    ],
  ), caption: [The system boundary. The arrows are architectural, not proof of inevitability.],
)

The plan is a JSON document with a versioned schema identifier, an ordered nodes
array, and summary statistics. Each node records kind, path, and payload. A
directory's payload is null. The statistics count node kinds and encoded payload
bytes, including link targets. They describe the input plan, not allocated disk
space, filesystem metadata, or the amount of attention consumed by this thesis.

== Separation of policy and effects

All conversion policy lives in src/lib.typ. The file specifies acceptable names,
acceptable array tags, traversal ordering, node representation, quoting, octal
encoding, operation emission, and statistics. src/main.typ connects JSON loading
to that library and emits the assets. Neither source file imports a plugin or
delegates conversion to another implementation.

The adapter in bin/json2dir handles arguments, temporary files, source transport,
invocation, output selection, and cleanup. It does not examine JSON fields or
decide which filesystem entries to create. In particular, there is no hidden
jq, Python, JavaScript, or Rust interpreter deciding the tree's meaning.
Generated shell commands carry the decisions already made by Typst.

This separation answers the phrase _pure Typst_ at the level where it can be
defended. The compiler implementation is pure Typst source, while actual host
effects require a shell. A promise that Typst itself creates symbolic links or
sets execute bits would be inaccurate. The project makes the boundary visible
in its README, interface, tests, and dissertation rather than treating it as an
embarrassing methodological appendix.

== Three interfaces to one compilation

The default interface matches the original use: json2dir reads standard input
and creates entries in the current directory. The plan option prints the
validated plan without applying it. The emit option prints the generated shell
program without applying it. Both inspection options leave the destination
unchanged, although compilation still uses temporary staging files.

These interfaces enable review at different levels. The plan provides a semantic
view of names, kinds, and payloads. The program provides the exact commands
that would be executed. A user can retain the generated program and run it later
in a chosen directory. Retention also transfers responsibility for selecting
that later destination: the generated program deliberately contains relative
paths rather than an embedded path to the original caller's directory.

== Failure boundaries

Malformed JSON is rejected by Typst's JSON loader. Structurally invalid trees
produce a structured validation error before source emission succeeds. The
entry point promotes that error to a compiler diagnostic with a code and a
path. The adapter's fail-fast execution means an unsuccessful compilation is
never followed by application, even if some temporary output were present.

Filesystem failures occur during the final stage. The generated program uses
fail-fast shell behavior so that a failed write, directory creation, link
creation, or permission change terminates application. Its explicit unlink
attempt is allowed to fail because an existing directory is a valid condition
for directory reuse. This exception is purposeful; indiscriminately ignoring
every error would make the system easier to publish and harder to use.

The isolation between staging and destination is also practical. Input can
request entries named src, apply.sh, or plan.json without altering the compiler's
own running copies, because those copies and artifacts live elsewhere. The
resulting tree remains capable of replacing entries in the chosen destination,
which is precisely the behavior the caller requested.
