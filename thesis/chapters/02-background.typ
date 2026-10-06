= Background: Braces, Bytes, and Academic Authority <background>

== The original conversion scheme

json2dir's useful idea is to let JSON's familiar structure carry a filesystem
description. An object represents a directory; its keys provide entry names.
A string represents a regular file's contents. A two-string array supplies a
tag and a payload: the tag link selects a symbolic link, and script selects an
executable file. The outermost value must be an object @json2dir.

This scheme is deliberately narrower than JSON itself. JSON admits numbers,
booleans, null values, strings, arrays, and objects @rfc8259. json2dir accepts
only the constructors that have an explicit filesystem interpretation. A number
does not become its decimal textual representation, and a boolean does not
become a directory named truth. Such conversions would be convenient inventions
but would change the source language.

The locally inspected Rust implementation also defines important replacement
behavior. It tries to remove each existing file or link entry before creating
the requested one. Existing directories can be reused for directory nodes,
allowing new children to be merged with unlisted entries. A directory is not
recursively destroyed to make room for a file. The README's broad statement about
deletion is therefore interpreted through the implementation's actual operations.

== Typst as an implementation language

Typst's JSON loader converts JSON objects to dictionaries, arrays to arrays,
strings to strings, booleans to booleans, and null to none. These mappings give
the port a direct representation of its source data @typst-json. The implementation
does not write a second JSON parser. Parsing is a standard-library boundary;
validation and conversion are project code.

An explicit stack stores pending values and their paths. Each loop iteration
removes one pending item. Directory values add their children; leaf values add
one plan operation. This is ordinary algorithmic work expressed in a language
normally encountered between a paragraph and its footnote. It requires neither
a plugin nor the compiler author's willingness to call it a good idea.

The crucial output mechanism is Typst 0.15.1's bundle target. Within a bundle,
asset elements emit a chosen string or byte sequence to a specified output path.
The compiler writes apply.sh and plan.json into an isolated staging directory.
That facility supports the conversion artifact but does not itself provide an
API for chmod, symbolic-link creation, or empty-directory creation @typst-asset.
The application stage addresses these remaining effects.

== Why generated shell is an appropriate intermediate target

A generated shell program has three useful properties for this port. First,
ordinary Unix hosts already provide a shell and the needed filesystem utilities.
Second, the complete program can be inspected before execution. Third, Typst
can generate it as text without accessing a foreign language evaluator.

The target also imposes obligations. Shell syntax is a programming language,
not a neutral container. Filenames and payloads cannot be pasted into commands
without encoding. A filename may contain a quote, a newline, a dollar sign, or
text resembling command substitution. A file payload may contain those features
plus NUL bytes. The compiler must keep these values as operands, and the tests
must exercise that claim with inputs designed to be inconvenient.

== Related work and template selection

The original project is the direct behavioral reference. Typst's standard
documentation supplies the language and export contracts. RFC 8259 supplies the
JSON context. The printf specification describes the escape decoding relied
upon by the generated program @posix-printf. These are real sources; none is
presented as endorsing this experiment.

The manuscript uses an adaptation of benplate 0.1.0 @benplate. Its structure
separates frontmatter, numbered chapters, appendices, and references. The local
adaptation replaces external typography and helper-package dependencies with
embedded fonts and native Typst rules. This makes the repository build offline
once Typst is installed. The MIT license and provenance are included beside the
template, because citations are not a substitute for license notices.

The fictional Institute of Recursive Administration contributes no technical
authority. Its role is to provide a plausible place for a dissertation committee
to ask whether an empty directory has sufficient novelty. The test suite is a
more reliable examiner: it can fail the candidate without first scheduling lunch.
