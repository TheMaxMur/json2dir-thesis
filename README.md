# json2dir, but the compiler is Typst and the folder has a PhD

A working Typst port of [Alan Urmancheev's json2dir](https://github.com/alurm/json2dir),
with a satirical doctoral dissertation and a fictional diploma beside the sources.
All repository content is in English. No Rust, Python, JavaScript, or WebAssembly
plugin implements the converter.

The degree is **Doctor of Philosophical Directories**. The institution is imaginary.
The files are real.

## Quick start

Requirements: **Typst 0.15.1**, a Unix-like host, `/bin/sh`, and standard filesystem
utilities. The recorded verification was run on macOS. Bundle export is an
experimental Typst feature; this project intentionally uses it. No package or font
downloads are needed after Typst is installed.

```sh
make all     # Test, refresh verification, and build both PDFs.
make demo    # Create the example tree under build/demo.
```

To create files in a chosen directory:

```sh
repo=/absolute/path/to/json2dir-thesis
mkdir -p /tmp/json2dir-output
cd /tmp/json2dir-output
"$repo/bin/json2dir" < "$repo/examples/tree.json"
```

The original stdin-only invocation is supported. Inspect the conversion from the
repository root before applying it:

```sh
bin/json2dir --plan < examples/tree.json
bin/json2dir --emit < examples/tree.json
```

`--plan` prints JSON; `--emit` prints the generated shell program. Neither mode
changes entries in the destination. The default mode applies the conversion to
the caller's current working directory.

## The conversion scheme

```json
{
  "greeting": "Hello, world!",
  "dir": { "subfile": "Content.\n", "subdir": {} },
  "symlink": ["link", "target path"],
  "script": ["script", "#!/bin/sh\nprintf '%s\\n' 'Howdy!'\n"]
}
```

| JSON value | Result |
| --- | --- |
| Object | Directory; an empty object creates an empty directory |
| String | Regular file containing exactly the string's UTF-8 bytes |
| `["link", "target"]` | Symbolic link; its target need not exist |
| `["script", "contents"]` | File containing those bytes, with all execute bits added |

The root must be an object. Numbers, booleans, null values, other array tags, and
arrays other than two strings are rejected. Scripts described by the input are
created, never automatically run by the converter.

Names must be non-empty, different from `.` and `..`, and contain no `/` or NUL.
Nested objects express nested paths. Quotes, spaces, newlines, leading hyphens,
UTF-8, and literal Unix backslashes are handled as filename data. Link targets may
be relative, absolute, or dangling; targets containing NUL are rejected. File and
script contents can contain NUL and retain every trailing newline.

## What "pure Typst" means here

`src/lib.typ` implements validation, iterative traversal, deterministic planning,
shell quoting, UTF-8 byte encoding, code generation, and statistics. `src/main.typ`
loads JSON and emits `apply.sh` and `plan.json` through Typst's native bundle target.
These sources contain the complete conversion implementation.

`bin/json2dir` is a small shell adapter: it transports stdin to a temporary
workspace, invokes Typst, prints the requested artifact or runs the generated
program, and cleans up. It never parses JSON or decides the conversion scheme.
The generated program invokes host utilities for filesystem effects. Typst's
bundle API does not itself create symlinks or set executable permissions.

File bytes are encoded as fixed-width octal `printf %b` operands. This keeps shell
syntax inside filenames and contents inert, preserves NUL bytes, and avoids
command substitution's removal of trailing newlines. The generated program is
self-contained and can be inspected or retained for later application.

Direct compilation, using the example as the default input:

```sh
typst compile --features bundle --format bundle --root . \
  src/main.typ build/bundle
```

For a different JSON file inside the project root, add `--input tree=/path.json`.
Run `build/bundle/apply.sh` with `/bin/sh` inside the intended destination.

## Replacement and compatibility

Existing regular files and symbolic links are unlinked before replacement.
Existing directories are merged, preserving unlisted entries. Replacing a real
directory with a file, script, or link fails; the converter does not recursively
delete directories. Ordinary creation permissions follow the host umask, with
execute bits added for script nodes.

The port retains the documented node scheme, stdin behavior, and these replacement
rules. It intentionally validates the entire tree before applying it, and rejects
every slash-bearing key. The original Rust path iterator can normalize some
slash-bearing keys; that behavior is not reproduced. Diagnostics are Typst
diagnostics rather than the original Rust error messages. `--plan` and `--emit`
are additions. Duplicate object keys are outside the supported producer contract.

An I/O failure may leave earlier operations applied. The converter is not a
transaction or a defense against concurrent filesystem mutation. Host limits,
case sensitivity, link behavior, and permission errors still apply. No native
Windows execution path is provided; Linux is not claimed as locally verified.

## The dissertation and the diploma

- `thesis/main.typ`: **The Typographical Filesystem**, ten chapters, references,
  reproducibility protocol, the complete compiler source, and a mock oral defense.
- `output/pdf/json2dir-phd.pdf`: the rendered dissertation.
- `diploma/main.typ`: a standalone fictional degree certificate.
- `output/pdf/json2dir-diploma.pdf`: the rendered diploma.

The template is a local, dependency-free adaptation of
[benplate 0.1.0](https://typst.app/universe/package/benplate) by Ben Dierks. The
adaptation, pinned download, and license are documented in `templates/PROVENANCE.md`.
It uses fonts embedded in Typst. The institution, degree, and reviewers are
explicitly fictional; technical claims and test results are real.

```sh
make thesis
make diploma
```

The dissertation reads its test counts from `verification/results.json` and embeds
the current compiler sources directly. Run `make test` before rebuilding it when
changing the implementation. The checked-in verification record allows a document
build from a clean checkout without running tests first. The document edition and
PDF creation timestamp are fixed; the verification record retains its actual run
timestamp.

## Verification and layout

`make test` currently passes **32 Typst unit assertions and 41 integration
scenarios**. Unit code and fixture generation are Typst; host integration checks
are shell. Tests cover the original example, all node kinds, byte preservation,
quoting, links, replacement, directory merging, invalid input without destination
effects, and inspection modes. The latest successful run is recorded in
`verification/results.json`. No performance benchmark, universal portability,
full region coverage, or machine-checked proof is claimed.

| Location | Purpose |
| --- | --- |
| `src/` | Complete Typst compiler |
| `bin/` | Stdin and execution adapter |
| `examples/` | Small input example |
| `tests/` | Typst tests, fixtures, report emitter, host checks |
| `verification/` | Successful local verification record |
| `templates/` | Local thesis template and upstream license |
| `thesis/` | English dissertation source and bibliography |
| `diploma/` | English fictional certificate source |
| `output/pdf/` | Deliverable PDFs |
| `build/` | Ignored demo and temporary build artifacts |

The inspected upstream revision is `b2072fb5515a603024c123297b27dcaabfdf098a`.
The original license is preserved in `LICENSE`; the template's MIT license is
preserved in `templates/benplate-LICENSE`.
