#import "../context.typ": results

= Evaluation: Seventy-Three Ways to Distrust a Folder <evaluation>

== Method and recorded environment

Evaluation uses executable checks instead of invented speedups. The repository's
test runner compiles Typst assertions, generates fixtures in Typst, applies them
in isolated temporary directories, and verifies host-visible outcomes. After a
successful run, a Typst report emitter records the passing counts, compiler
version, platform, and UTC timestamp. This chapter reads that record directly,
so its headline numbers are connected to an artifact rather than manually
transcribed into prose.

The recorded compiler is #raw(results.compiler). The recorded platform is
#raw(results.platform). The verification record was produced at
#raw(results.recorded-at). The result contains #results.unit.passed passing unit
assertions and #results.integration.passed passing integration scenarios, with
zero recorded failures. A scenario can contain multiple assertions; adding the
counts describes suite entries, not a rigorous count of independent experimental
observations.

#figure(
  table(columns: (1.5fr, auto, 2fr),
    table.header([*Evidence layer*], [*Passed*], [*What it exercises*]),
    [Typst unit suite], [#results.unit.passed], [Validation, traversal, quoting, byte encoding, statistics],
    [Host integration suite], [#results.integration.passed], [Files, directories, links, modes, errors, CLI inspection],
    [Performance benchmark], [Not run], [No comparative performance claim],
    [Formal verification], [Not performed], [Informal arguments only],
  ), caption: [Recorded evidence and deliberately absent evidence. Blank ambition is not a measurement.],
)

== Ordinary conversions and replacement scenarios

The upstream example exercises all four node kinds. Its greeting is checked,
nested file contents are compared byte-for-byte, its empty subdirectory is
observed, its symbolic-link target is read, and its script has executable
permission and produces the expected output when the test explicitly runs it.
The converter itself never runs that payload script.

Replacement scenarios begin with existing files, links, and directories. They
verify file replacement, file-to-directory conversion, directory reuse, and
preservation of unlisted children. Existing file and directory symlinks are
replaced without modifying their targets. Attempts to turn a real directory into
a file, script, or link fail while preserving its existing child. These checks
distinguish intentional merging from accidental recursive deletion.

An empty-root scenario confirms that unrelated destination entries remain
unchanged. Inspection scenarios confirm that plan and emit modes do not apply
the tree. The emitted program is subsequently executed in an isolated destination
to verify that it carries the necessary behavior. The plan output is compared
with direct Typst compilation of the same example, checking the adapter's input
transport and output selection.

== Adversarial payloads and invalid input

The hostile fixture uses a filename containing a single quote, a newline, dollar
signs, backticks, and text resembling command substitution. Its payload contains
literal shell-looking text, backslashes, multiple trailing newlines, and an
embedded zero byte. The test compares the resulting file with bytes independently
emitted by Typst's asset facility. It also confirms that marker files named by
the apparent command substitutions were not created.

Additional entries exercise an option-like filename, a non-ASCII filename and
payload, a literal backslash in a name, and a link target beginning with a hyphen
and containing a newline. A separate script fixture checks both embedded NUL
content and executable permission. The tests use byte comparisons where shell
string comparison would lose information, particularly for trailing newlines
and NUL bytes.

Invalid fixtures cover malformed JSON, non-object roots, unsupported leaf values,
array lengths, array element types, unrecognized tags, invalid names, and a NUL
inside a link target. Every invalid scenario starts with a sentinel file and
checks that it survives as the only destination entry. A late invalid sibling
specifically exercises validation-before-application behavior.

== What the evaluation does not establish

The suite does not reproduce the original Rust project's full region coverage,
fault-injected permission failures, or every platform-specific error. It does
not test concurrent attackers, Windows, network filesystems, pathological input
sizes, or every allowed filename. Its claims apply to the tested scenarios and
recorded host. A passing count should motivate confidence in those behaviors,
not erase the boundary of the experiment.

No runtime benchmark against Rust is reported. The compiler performs parsing,
sorting, value traversal, byte encoding, staging, and program generation before
starting filesystem effects. Those stages have costs, and byte encoding expands
payload size. Their existence supports a qualitative cost discussion, but cannot
support a numerical speed comparison. The fictional committee requested a graph
with an upward arrow; the evaluation declined on methodological grounds.
