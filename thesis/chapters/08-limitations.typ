= Limitations: Reality Has Write Access <limitations>

== Experimental export and version boundaries

Bundle export is explicitly experimental and enabled through a feature flag
@typst-bundle. This repository was tested with Typst 0.15.1. An installation that
lacks the bundle target or asset support cannot run this compiler without
changing its output mechanism. Future compiler releases may change experimental
behavior. The build therefore states its tested version rather than treating the
latest release as a timeless mathematical constant.

The dissertation's normal PDF build does not depend on bundle export, but the
implementation and verification reports do. The local template does not need
network access or downloaded helper packages. That distinction keeps document
build reproducibility separate from runtime portability. A beautiful PDF is not
evidence that the command-line converter executed successfully.

== Concurrency and filesystem authority

The generated program uses path-based utilities. Between an unlink, directory
check, creation, and write, another process may change a path. The project does
not use descriptor-relative operations or provide protection against time-of-check
to time-of-use races. Its deliberate removal of pre-existing symlinks helps
ordinary replacement behavior but cannot establish confinement in a directory
that an adversary can mutate concurrently.

The input also controls symbolic-link targets. A target can point outside the
destination, and another application may later follow that link. This is a
feature of the format, not an implicit promise that every resulting link stays
inside the tree. Users choose the destination and authority under which the
generated program runs. The repository demonstrates a local conversion tool,
not a privilege boundary or a service for applying untrusted trees as root.

== Partial application and replacement policy

Validation rejects unsupported input before destination mutation. Accepted input
can nevertheless fail halfway through application. A directory may be unwritable,
a path may be too long, a filesystem may be full, or a requested link may be
unrepresentable on the host. Earlier successful operations remain. The program
has no rollback journal and does not promise all-or-nothing application.

Directory merging is similarly specific. Unlisted children remain in an existing
directory. If a consumer expects an exact mirror in which absent names are
deleted, this converter will not supply one. Conversely, replacing a real
directory with a file or link is rejected rather than recursively deleting its
contents. These choices follow the inspected implementation's broad behavior
and keep deletion authority limited to existing file and link entries.

== Input and metadata limits

The format describes UTF-8 text, including characters that encode to zero bytes.
It does not provide an arbitrary binary-file encoding. It does not specify owner,
group, ACLs, extended attributes, special devices, hard links, timestamps, or
chosen permission masks. Script nodes add execute permission to the normal file
creation mode; they do not request a particular complete mode such as 0755.
The host umask remains relevant.

Strict key validation rejects slash-bearing names even when the Rust path
iterator might normalize them to one component. Backslashes remain ordinary
Unix name characters. Duplicate keys are outside the documented producer
contract. Filename length limits and case sensitivity remain filesystem
properties. The operating system can refuse a name that is structurally valid
under the source language; compile-time validation cannot predict all host state.

== Resource costs and integration boundaries

The adapter reads the entire input into a staging file, and Typst loads the
parsed tree. The planner stores its pending work and final operation sequence.
The byte encoder constructs an escaped representation, and the emitter retains
the generated program text. Large payloads therefore incur storage and memory
costs beyond their final on-disk size. The implementation does not stream input
or apply operations incrementally during parsing.

The explicit work stack avoids the project traversal's function-call recursion,
but it cannot remove parser limits or runtime resource limits. No maximum-size
or maximum-depth performance claim is made. Native Windows application is not
implemented. Linux may work with the selected utilities, but the recorded
verification is macOS-only. The defense committee's honorary penguin does not
count as a Linux test machine.
