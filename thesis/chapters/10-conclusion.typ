#import "../context.typ": results

= Conclusion: QED, Then mkdir <conclusion>

== Answers to the research questions

The complete json2dir conversion logic can be implemented in Typst. The compiler
loads JSON through the standard library, validates its accepted constructors,
builds a sorted preorder plan with an explicit work stack, quotes path operands,
encodes payload bytes, and emits an application program and inspection plan.
No Rust, Python, JavaScript, or plugin supplies the conversion algorithm.

Actual directory creation, symbolic-link creation, and permission changes cross
an explicit host boundary. A small shell adapter stages the input, invokes the
compiler, selects output, and executes the generated program when requested.
This answers the expressiveness question without attributing unsupported host
APIs to Typst. The implementation is unusual enough without requiring an
inaccurate description of what it does.

Byte-preserving conversion is achieved by encoding each UTF-8 byte into a
fixed-width octal printf escape. This removes payload text from shell syntax,
preserves embedded zero bytes in file contents, and retains trailing newlines.
The tested fixtures include hostile-looking names and payloads, UTF-8, empty
values, symbolic links, and executable files. Their passing results provide
concrete support for the implemented encoding path.

Evaluation establishes #results.unit.passed passing unit assertions and
#results.integration.passed passing integration scenarios on the recorded
host. It also identifies what has not been established: comparative performance,
formal verification, hostile concurrency safety, broad platform portability,
or unlimited input size. Those omissions are part of the result's meaning,
not material to be hidden until the examiner has signed.

== Deliverables and their relationship

The repository contains the Typst compiler sources, a compatible stdin-based
command interface, inspection modes, fixtures, unit tests, integration tests,
a machine-readable verification record, and English documentation. It also
contains this dissertation's Typst source, its local template with provenance
and license, its rendered PDF, and a companion fictional diploma.

The source is the primary evidence for implementation claims. The suite is the
primary evidence for tested behavior. The verification record connects the
document's counts to the latest successful local run. The PDF makes the material
readable and searchable. The diploma has exactly the authority stated on its
face: none outside the fictional institute. These artifacts serve different
purposes, and no amount of typography makes them interchangeable.

== Closing argument

The result is a working compiler with a visible effect boundary, accompanied
by a dissertation built with the same language. Typst has successfully produced
both the program and the paperwork needed to explain its questionable career move.

The Rust implementation remains next door. This port fulfills its own brief:
recreate the conversion in Typst, make the result executable, and document it
with more academic ceremony than a folder could reasonably demand.

The candidate therefore submits the sources, the tests, and the manuscript.
The committee may now deliberate. Its deliberation directory already exists,
its unlisted minutes have been preserved, and its honorary symlink points to
the nearest coffee machine. The base case has been reached.
