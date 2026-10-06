= Discussion: The Political Economy of mkdir <discussion>

== What the unusual language choice reveals

Implementing json2dir in Typst makes a familiar distinction unusually visible:
describing effects is different from performing them. A planner can be expressed
in a language with no conventional filesystem mutation API. The planner's output
is a program, which a host executes later. This observation is ordinary compiler
design viewed through an unreasonable lens, and that is the experiment's main
educational value.

The staged architecture improves review. A caller can inspect the complete plan
or application program before running it. The same architecture improves input
failure behavior by finishing validation before application. Neither benefit
depends on the degree certificate. Both depend on how the implementation connects
its stages and prevents failed compilation from reaching execution.

The language choice also concentrates pressure on representation boundaries.
The author cannot casually use a native write-file function and assume its
string handling is correct. Instead, the payload must cross JSON decoding,
Typst UTF-8 encoding, generated shell syntax, printf decoding, and filesystem
writing. Each boundary provides a place for corruption or injection. The octal
encoder and byte comparison tests are responses to that concrete chain, not
ceremonial security vocabulary added after the cover page.

== Why the adapter does not invalidate the implementation

Every deployed implementation relies on a runtime and an operating system. The
relevant question is which project logic is delegated and whether the delegation
is disclosed. Here the adapter is a transport and invocation layer. The compiler
determines the complete operation sequence, path operands, content operands, and
permission operations in Typst. A host shell executes that generated sequence.

Calling the compiler a pure Typst implementation is accurate under that stated
boundary. Calling the entire operating-system interaction Typst-native would
be inaccurate. The repository's source layout provides evidence for the
distinction: two Typst compiler files, Typst fixture and unit files, a shell
adapter, and a shell integration runner. No source from the original Rust
implementation is needed at runtime. The manuscript includes the Typst compiler
in full so that the claim can be reviewed without accepting its abstract.

== The value of boring tests in an unreasonable project

The strongest moments in development were mundane failures. The first empty
payload test exposed an empty-array join returning none rather than an empty
string. A script permission check exposed a utility-option portability problem.
A directory-to-link check exposed ln's directory destination behavior. Each
failure concerned an ordinary edge case with a concrete operational consequence.

This pattern argues for tests aligned with the contract. Byte comparison checks
content fidelity. Link-target checks inspect links themselves. Directory merge
checks observe unlisted entries. Invalid-input checks observe absence of
destination effects. A test that merely reproduced the emitter's source string
would be weaker evidence for filesystem behavior, although small unit assertions
remain useful for localized encoding and validation rules.

== Satire as a documentation technique

The fictional degree gives the manuscript room to exaggerate the importance of
a small tool while keeping its technical claims proportionate. An empty object
can be called a distinguished scholar, provided the next paragraph correctly
states that it emits no operations. An examiner can be named Sybil Link,
provided an actual symlink target is checked with an actual host utility.
The joke depends on the reader recognizing where exaggeration ends.

That separation also limits fabricated authority. The manuscript cites real
documentation, credits the original author and template, and reports observed
test counts. It does not invent measured benchmark results, endorsement by
a real university, or a formal proof certificate. The companion diploma labels
its institution and degree fictional. The research collective receives a title;
the reader receives source code and a reproducible build.

== Practical alternatives and future directions

A direct asset backend could emit file payloads separately and generate a smaller
application program that copies them into place. A transaction-aware backend
could stage a complete replacement tree for selected use cases, although merge
semantics and host atomicity would need an explicit design. A hardened native
executor could consume the plan using descriptor-relative filesystem operations.
That executor would change the pure-Typst boundary and should be named honestly.

These ideas are future work, not features already present. Their existence does
not justify postponing the simpler implementation's tests. The current system
has a clear interface, real artifacts, recorded behavior, and limitations visible
before deployment. In the Institute of Recursive Administration, this is known
as the minimum publishable directory.
