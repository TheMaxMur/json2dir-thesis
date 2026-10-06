#let hostile-name = "quote'$(touch INJECTION)`touch BACKTICK`\n-end"
#let hostile-content = "literal $HOME $(touch INJECTION) `touch BACKTICK` ' \\\nline two\n\n\u{0}end\n"
#let hostile-tree = (:)
#hostile-tree.insert(hostile-name, hostile-content)
#hostile-tree.insert("-option", "safe")
#hostile-tree.insert("café", "UTF-8 survives.\n")
#hostile-tree.insert("back\\slash", "literal\\backslash")
#hostile-tree.insert("script", ("script", "#!/bin/sh\nprintf '%s\\n' 'Executed safely.'\n"))
#hostile-tree.insert("link", ("link", "-target ' $HOME\nline"))
#asset("hostile.json", json.encode(hostile-tree))
#asset("hostile-name.txt", hostile-name)
#asset("hostile-content.bin", hostile-content)
#asset("empty.json", "{}")
#asset("file.json", json.encode((entry: "new\n")))
#asset("directory.json", json.encode((entry: (child: "new\n", empty: (:)))))
#asset("link.json", json.encode((entry: ("link", "destination"))))
#asset("script.json", json.encode((entry: ("script", "#!/bin/sh\nexit 0\n"))))
#asset("nul-script.json", json.encode((entry: ("script", "x\u{0}y\n"))))
#asset("nul-script.bin", "x\u{0}y\n")
#let invalid = (
  "root-number": 3, "root-array": (), "root-null": none,
  "node-number": (entry: 3), "node-boolean": (entry: true), "node-null": (entry: none),
  "array-empty": (entry: ()), "array-short": (entry: ("link",)),
  "array-long": (entry: ("link", "a", "b")), "array-kind-type": (entry: (2, "x")),
  "array-payload-type": (entry: ("script", false)), "array-unknown": (entry: ("unknown", "x")),
  "target-nul": (entry: ("link", "x\u{0}y")),
  "nested-invalid": (a: (b: 3)), "validate-first": (a: "must not appear", z: false),
)
#for (name, value) in invalid { asset("invalid/" + name + ".json", json.encode(value)) }
#for (name, key) in ("name-empty": "", "name-dot": ".", "name-parent": "..",
  "name-root": "/", "name-slash": "a/b", "name-trailing-slash": "a/", "name-nul": "x\u{0}y") {
  let tree = (:)
  tree.insert(key, "bad")
  asset("invalid/" + name + ".json", json.encode(tree))
}
#asset("invalid/malformed.json", "{broken JSON")
