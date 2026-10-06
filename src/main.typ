// SPDX-License-Identifier: ISC
#import "lib.typ": require-plan, emit-shell, statistics
#let tree = json(sys.inputs.at("tree", default: "/examples/tree.json"))
#let nodes = require-plan(tree)
#asset("apply.sh", emit-shell(nodes))
#asset("plan.json", json.encode((schema: "json2dir-plan/v1",
  nodes: nodes, statistics: statistics(nodes))))
