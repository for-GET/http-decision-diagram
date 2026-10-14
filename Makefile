# Makefile.light — vendored sane.mk core (make/sane.mk) + plain targets.
# Core from https://github.com/andreineculau/sane.mk (dist/sane.mk)
# gives: shell hardening, verbose plumbing, $(MAKE_DASH_F), lazy vars.
# Upgrade to the full framework (deps/check/build/clean hooks) when this
# outgrows ~5 leaf targets.

include make/sane.mk

# ------------------------------------------------------------------------------

# node_modules/.bin/coffee@1.8.0 compiles httpdd.fsm.html.coffee
COFFEE = ./node_modules/.bin/coffee
NPM = npm

.PHONY: all
all: check build ## Check the JSON artifacts and precompile the page JS.

.PHONY: ci
ci: all ## CI entrypoint.

.PHONY: deps
deps: node_modules ## Install npm dependencies.
node_modules:
	$(NPM) install

.PHONY: check
check: check/fsm-json ## Check JSON artifacts.
.PHONY: check/fsm-json
check/fsm-json:
	@for f in package.json *.fsm.json; do \
		echo "check $$f"; \
		node -e "JSON.parse(require('fs').readFileSync('$$f','utf8'))"; \
	done

.PHONY: build
build: httpdd.fsm.html.js ## Precompile httpdd.fsm.html.coffee.
.PHONY: httpdd.fsm.html.js
httpdd.fsm.html.js: httpdd.fsm.html.coffee node_modules
	$(COFFEE) -c -o . $<

.PHONY: dist
dist: ## Publish the httpdd package to npm (requires npm login).
	$(NPM) publish

.PHONY: clean
clean: ## Remove installed npm dependencies.
	rm -rf node_modules

.PHONY: help
help: ## Show this help.
	@grep -E '^[a-zA-Z].*##' $(MAKE_FILENAME)
