= A Semantics of Things in Other Things <semantics>

== The node algebra

Let a node be a directory, a textual file, a symbolic link, or an executable
textual file. A directory maps acceptable entry names to further nodes. Files
and scripts carry strings whose UTF-8 encoding becomes file content. Links carry
strings that become link targets. In compact notation:

$ N ::= D(M) | F(s) | L(t) | X(s) $

Here $M$ is a finite mapping from names to nodes, $s$ is a payload string, and
$t$ is a link-target string. The JSON encoding provides a concrete surface
syntax for this algebra. The file and script constructors share a content
representation but differ in the permission operation requested during application.

#figure(
  table(columns: (1fr, 1.1fr, 1.6fr),
    table.header([*JSON form*], [*Constructor*], [*Application effect*]),
    [Object], [Directory], [Create or reuse a directory],
    [String], [File], [Write exactly the UTF-8 bytes],
    [Two strings; tag link], [Symbolic link], [Create a link to the payload target],
    [Two strings; tag script], [Executable file], [Write bytes, then add execute bits],
  ), caption: [The complete accepted node vocabulary. A number is not a fifth constructor.],
)

== The root and the name rule

The root is an object describing entries inside an existing destination. The
compiler never creates a named root entry. Therefore an empty object produces
an empty operation sequence and leaves the destination untouched. This is a
useful base case and an unusually accomplished doctoral candidate: it satisfies
the specification by doing nothing.

An entry name must be non-empty, different from dot and dot-dot, contain no
forward slash, and contain no NUL character. These constraints exclude explicit
parent traversal and absolute paths. On the tested Unix host, a backslash is an
ordinary filename character, so the validator allows it. A leading hyphen is
also ordinary data; generated paths begin with dot-slash so that their names
cannot be mistaken for utility options.

The rule is intentionally literal. The Rust path-component iterator can
normalize some unusual names, such as a name ending in a slash. This port rejects
every slash-bearing key, following the README's stated one-component scheme
without reproducing that normalization accident. Nested objects provide the
supported way to describe nested paths. This difference is documented rather
than smuggled into a compatibility claim.

== Payload distinctions

A file string may contain a NUL character; its UTF-8 representation contains a
zero byte, which is valid file content. A filename or symbolic-link target may
not contain that character because the operating-system pathname interface
cannot represent it. The validator checks names and link targets separately
from file and script payloads. Conflating those domains would either reject
valid file contents or emit impossible path operations.

A link target may be absolute, relative, dangling, or include parent traversal.
It is the content of a link, not a child name. The converter does not recursively
interpret it as another tree and does not require the target to exist. Whether
a later consumer follows the link is a separate operation, carrying separate
consequences. An empty target is left to host behavior, which is not claimed to
be uniform across platforms.

== Operational ordering and replacement

Within each directory, keys are sorted by the Typst runtime's string ordering.
Children are pushed onto the pending stack in reverse order, so popping the
stack produces sorted preorder traversal. Every directory operation precedes
its descendants. This yields a deterministic plan for a parsed input tree,
independent of its object insertion order. Duplicate JSON keys are outside the
input contract: producers should use unique names, and the port relies on the
standard parser's handling of duplicate names.

Application processes operations in plan order. Each operation first attempts
to unlink an existing file or link at its path. Directory nodes then create a
directory if necessary, leaving existing real directories available for merging.
File and script nodes write their payload. Link nodes create the requested
symbolic link and explicitly reject an existing directory. Script nodes add
execute permission for user, group, and others after writing.

This is a sequential update semantics. It is not a transaction. Input validation
completes before the first update, but an I/O error during application can leave
earlier operations completed. A paper that described this as atomic would need
more than a footnote; it would need a different implementation.
