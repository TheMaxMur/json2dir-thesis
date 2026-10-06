.PHONY: all test thesis diploma demo clean
TYPST ?= typst
all: test
	$(MAKE) thesis diploma

test:
	./tests/run

thesis:
	mkdir -p output/pdf
	$(TYPST) compile --root . --creation-timestamp 1791234000 thesis/main.typ output/pdf/json2dir-phd.pdf

diploma:
	mkdir -p output/pdf
	$(TYPST) compile --root . --creation-timestamp 1791234000 diploma/main.typ output/pdf/json2dir-diploma.pdf

demo:
	mkdir -p build/demo
	cd build/demo && ../../bin/json2dir < ../../examples/tree.json

clean:
	rm -rf build
