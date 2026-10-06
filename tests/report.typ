#let unit = json(sys.inputs.at("unit"))
#asset("results.json", json.encode((
  schema: "json2dir-verification/v1",
  recorded-at: sys.inputs.at("recorded-at"),
  compiler: sys.inputs.at("compiler"),
  platform: sys.inputs.at("platform"),
  unit: unit,
  integration: (passed: int(sys.inputs.at("integration")), failed: 0),
  scope: "Local macOS functional checks; no benchmark or formal verification claim",
)))
