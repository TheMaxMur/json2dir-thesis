= Implementation: The Typesetter Acquires Permissions <implementation>

== Validation as a total decision over parsed values

The plan function returns either a successful operation sequence or a failure
record containing a code, path, and explanation. It checks the root before
initializing traversal. Each pending value is classified by its Typst type.
Dictionaries introduce children; strings introduce files; arrays must contain
exactly two strings and a recognized tag. Every other type fails explicitly.

The checks do not perform destination writes. This means an invalid late node
cannot create earlier valid siblings. For example, a tree with a valid a entry
and an invalid z entry is rejected before a appears on disk. That behavior is a
deliberate improvement over the original interleaving of validation and effects,
and it is exercised by an integration test.

Error paths provide context without changing the language's semantics. The
path dot-slash-a-slash-b identifies a nested bad node; a parent path identifies
a bad child name. The compiler's diagnostic also points into the source function
that raised the error. This is less polished than a dedicated CLI error renderer,
but avoids inventing a second validator merely to make failure look elegant.

== Iterative traversal

The pending stack starts with the root item. Directory items append a directory
operation unless they are the root, then add child items in reverse sorted order.
The loop finishes when the stack is empty or returns immediately upon validation
failure. The implementation therefore avoids recursion in its own traversal.

That design does not imply unlimited nesting. The JSON parser, Typst evaluation
limits, memory allocator, host pathname limits, and filesystem remain relevant.
An explicit stack removes one specific recursion mechanism; it does not repeal
the laws of finite computers. This distinction is especially useful in a thesis,
where the word unlimited is otherwise tempted to appear near a funding request.

== Quoting pathname operands

The shell encoder surrounds an operand with single quotes. An embedded quote
is represented by closing the quoted string, emitting a backslash-escaped quote,
and reopening the quoted string. This preserves the operand while preventing
dollar signs, backticks, and parentheses from becoming shell syntax. The paths
are also prefixed with dot-slash, preventing option-like names from being passed
as leading options to utilities.

The generated chmod invocation intentionally omits a double-dash separator.
The locally tested macOS utility interprets that separator as an operand in this
invocation. Its absence is safe here because the mode is fixed and the generated
path starts with dot-slash. Other utility invocations use the separators supported
by the tested host. Portability is established by observed host behavior rather
than a sweeping claim that every utility on every Unix agrees.

== Encoding file contents as octal bytes

Directly placing a payload in a shell string is insufficient because shell
operands cannot hold embedded NUL bytes. Command substitution also removes
trailing newlines. The compiler instead converts the string to UTF-8 bytes and
maps each byte to a fixed-width printf escape. For a byte $b$ with
$0 <= b <= 255$, its octal digits are:

$ d_2 = floor(b / 64), quad d_1 = floor(b / 8) mod 8, quad d_0 = b mod 8 $

The emitted representation is a backslash, zero, and these three digits. The
generated printf percent-b command decodes the representation directly into the
destination file. Payload data never passes through a shell variable or command
substitution. Literal backslashes therefore remain literal, and trailing
newlines remain part of the file. Empty payloads use an explicitly empty operand.

The representation uses five ASCII bytes per original byte before fixed command
overhead. That overhead is a transparent cost. It buys a uniform path for all
UTF-8 content, including zero bytes produced by escaped NUL characters in JSON.
A future implementation could emit content assets and generate copy commands,
but this dissertation studies the simpler self-contained application program.

== Directory and link details

Existing directories require special care because the ln utility can interpret
a directory operand as a place in which to create a link. The emitter explicitly
rejects that condition before a link operation. Without the check, a successful
command could create the wrong entry and report success. The integration suite
caught precisely that bug during implementation.

Existing symlinks are unlinked before replacement. A directory node additionally
checks that its path is not a surviving symlink. These checks reduce accidental
traversal of pre-existing links in an ordinary local application. They do not
provide descriptor-relative race protection. The security limitations follow
from the host operations chosen, regardless of how attractively their names
are typeset.
