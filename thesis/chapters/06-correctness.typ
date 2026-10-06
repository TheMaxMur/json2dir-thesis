= Correctness: A Theorem Is Not a Backup <correctness>

== Assumptions and the strength of the claims

The following arguments concern the project algorithm and generated program.
They assume successful JSON parsing, a finite input tree, the specified behavior
of Typst's value operations, working host utilities, sufficient resources, and
no concurrent modification of relevant destination paths. They are informal
arguments, not machine-checked proofs. The numbered presentation is academic
decoration with organizational value, not an escalation of evidential authority.

The target postcondition is also bounded. Requested directory entries have the
requested kind and payload after successful application. Unlisted entries in
reused directories remain. File permissions follow the host's creation behavior,
with execute bits additionally enabled for script nodes. Ownership, timestamps,
extended attributes, and directory metadata are not specified by the source
language. A correct conversion should not acquire obligations the input cannot
express.

== Proposition 1: Every successful plan contains accepted nodes

Consider one iteration of the traversal. Its item is either a dictionary, string,
tagged array, or another parsed value. A dictionary contributes only a directory
operation and pending children whose names pass validation. A string contributes
only a file operation. An array contributes only a link or script operation after
its arity, element types, and tag have passed their checks. Every remaining case
returns a failure instead of a successful plan.

Inductively, the accumulated nodes contain only accepted operations. Successful
termination means every pending item has been classified without failure. The
returned sequence therefore covers the accepted tree and contains no operation
for an unsupported boolean, number, null value, or malformed array. This argument
concerns the planner; the JSON loader's correctness remains a dependency.

== Proposition 2: Parent directories precede their descendants

When a non-root directory item is removed from the stack, its operation is added
before child items are introduced. No descendant can be removed from the stack
before it has been introduced by an ancestor. Every ancestor directory operation
therefore precedes the descendant's operation. The root needs no operation because
application starts inside an existing destination directory.

Sorting and reversing the child insertion order additionally ensure that the
next child removed from the stack has the first sorted name. Its descendants
are introduced above remaining siblings, yielding depth-first preorder. This
establishes determinism at the project level under a fixed parser result and
runtime ordering, while avoiding a claim about arbitrary Unicode collation
standards that the project neither implements nor requires.

== Proposition 3: Encoded file payloads round-trip byte-for-byte

For any byte $b$, the digit calculation decomposes it into three base-eight
digits. The digits satisfy $b = 64 d_2 + 8 d_1 + d_0$. Prefixing their fixed-width
representation with the printf octal escape marker produces a code that decodes
to $b$. Concatenation of those codes decodes to the original byte sequence,
because each code has a fixed boundary and printf writes the decoded bytes in
order.

The shell operand contains only ASCII backslash-zero-digit sequences and is
single-quoted. The payload cannot introduce a printf cancellation escape or
shell syntax because every original byte, including a backslash, is encoded.
The empty sequence receives an empty operand and produces an empty file. No
trailing newline is synthesized or removed. The test suite confirms selected
instances with byte comparisons, including UTF-8 and embedded NUL payloads.

== Proposition 4: Invalid trees do not mutate the destination

Transport and compilation operate in temporary staging. Application is invoked
only after compilation exits successfully. Structural validation fails by
returning an error that the entry point promotes to a compiler failure. The
adapter consequently exits without invoking the generated program. Invalid
trees therefore cannot cause destination writes through this adapter, although
temporary staging files were created and later removed.

This guarantee is about invalid input, not application failure. An accepted
tree can still encounter permission errors, missing resources, or incompatible
existing entries. Those failures terminate the program after any earlier effects.
A destination snapshot or transaction protocol would be required for rollback.
The distinction prevents the very common scientific error of proving a property
of phase one and advertising it as a property of the entire universe.

== Corollary: A quiet empty object is a successful result

An empty root introduces no child items and produces no operations. Its generated
program contains initialization but no filesystem update commands. Application
therefore succeeds without changing destination entries under the stated
assumptions. This corollary is offered to the committee as the theoretical
justification for taking an afternoon off.
