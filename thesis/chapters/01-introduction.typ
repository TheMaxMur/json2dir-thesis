= Introduction: The Folder Deserves a Doctorate <introduction>

== A modest task with an immodest research programme

The original json2dir turns a JSON object into a directory tree. A name becomes
a filesystem entry; its value decides what that entry contains. The interface is
small enough to explain before coffee and useful enough to survive the coffee:
feed JSON to standard input, obtain files in the current directory @json2dir.
This dissertation asks what happens when that interface is entrusted to Typst.

The obvious objection is practical. Typst is a typesetting system. Its users
normally ask it to lay out paragraphs, number equations, and persuade a table to
remain within its margins. None of these activities implies a professional
relationship with symbolic links. Yet Typst also has dictionaries, arrays,
functions, loops, JSON loading, byte conversion, and an experimental facility
for emitting arbitrary assets. The relevant question is therefore technical:
which parts of filesystem synthesis can be expressed within that language,
and which effects must cross a host boundary?

The project answers by treating json2dir as a compiler. Its source language is a
restricted family of JSON values. Its intermediate representation is a sequence
of validated operations. Its target language is an application program whose
data operands are encoded by the compiler. This architecture makes the unusual
language choice explicit instead of concealing an ordinary implementation behind
a decorative PDF. The dissertation is absurd because it is a dissertation about
this choice. The implementation must still work.

== Research questions

The first question concerns expressiveness: can the complete conversion scheme
be implemented in Typst without Rust, JavaScript, Python, a WebAssembly plugin,
or a foreign implementation of the traversal? The answer depends on a precise
boundary. Typst can parse and validate the input, choose operations, and generate
the bytes of an application program. A host shell can execute that program.
The shell adapter is part of deployment, and is disclosed as such.

The second question concerns fidelity: can generated programs preserve ordinary
text, UTF-8, empty files, embedded NUL bytes, and all trailing newlines without
turning user data into executable shell syntax? This is a stronger requirement
than making the friendly example work. A directory archiver that quietly edits
its payload is an editor with unusually aggressive output settings.

The third question concerns evidence: what does a passing local test suite
actually demonstrate? It provides concrete observations for specified inputs and
filesystem states. It does not prove resistance to concurrent attacks, establish
asymptotic bounds for the Typst runtime, or give this fictional institute the
power to award an accredited degree.

== Contributions

The first contribution is a Typst implementation of the original four node kinds:
directory, file, link, and script. The second is a staged design that completes
validation before applying filesystem changes. The third is a byte-preserving
shell encoder that keeps payload text out of the shell grammar. The fourth is an
executable test suite with Typst unit assertions and host integration checks.
The fifth is an offline dissertation build using a pinned, locally adapted thesis
template. The sixth, much less defensible contribution is the present manuscript.

These contributions differ in their status. The source files are executable
artifacts. The test results are observations. The correctness arguments are
informal reasoning under stated assumptions. The fictional academic apparatus
is satire. Maintaining those distinctions is essential: the dissertation has
already misused one category system by enrolling a directory in graduate school.

== Scope and terminology

A _tree_ means the abstract structure described by the accepted JSON values. A
_plan_ means the compiler's ordered sequence of operations. An _application_
means executing those operations against a destination directory. A _script
node_ means a file that receives executable permission; its contents are never
automatically executed as part of application.

The implementation targets local Unix-like environments, tested here on macOS.
It is an experimental port, particularly because bundle export is explicitly
experimental in Typst's documentation @typst-bundle. Windows behavior and hostile
concurrent mutation are outside its tested contract. The goal is a small,
reviewable implementation with an honest account of its boundary conditions.
Readers seeking a universal deployment system are advised to follow a different
symlink.
