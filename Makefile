PROJECT_NAME=ppp
CABAL=cabal

all: clean build

build:
	$(CABAL) build

run:
	$(CABAL) run $(PROJECT_NAME)

clean:
	$(CABAL) clean

test:
	$(CABAL) test

repl:
	$(CABAL) repl

.PHONY: all build run clean test repl
