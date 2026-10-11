ifeq (,$(wildcard sane.mk/dist/sane.std.mk))
SANE_MK_INSTALL := $(shell git submodule update --init --recursive sane.mk)
ifneq (,$(filter undefine,$(.FEATURES)))
undefine SANE_MK_INSTALL
endif
endif

include sane.mk/dist/sane.mk
include sane.mk/dist/sane.std.mk

# ------------------------------------------------------------------------------

# node_modules/.bin/coffee@1.8.0 compiles httpdd.fsm.html.coffee
COFFEE = ./node_modules/.bin/coffee

# deps -----------------------------------------------------------------------

SANE_DEPS += \
	deps/npm \

.PHONY: deps/npm
deps/npm: ## Install npm dependencies (node_modules).
	$(NPM) install

# check ----------------------------------------------------------------------

SANE_CHECK += \
	check/fsm-json \

.PHONY: check/fsm-json
check/fsm-json: ## Validate that package.json and *.fsm.json parse as JSON.
	@for f in package.json *.fsm.json; do \
		echo "check $$f"; \
		$(NODE) -e "JSON.parse(require('fs').readFileSync('$$f','utf8'))"; \
	done

# build ----------------------------------------------------------------------

SANE_BUILD += \
	httpdd.fsm.html.js \

.PHONY: httpdd.fsm.html.js
httpdd.fsm.html.js: httpdd.fsm.html.coffee node_modules
	$(COFFEE) -c -o . $<

# dist -----------------------------------------------------------------------

SANE_DIST += \
	dist/npm \

.PHONY: dist/npm
dist/npm: ## Publish the httpdd package to npm (requires npm login).
	$(NPM) publish

# clean ----------------------------------------------------------------------

SANE_CLEAN += \
	clean/node_modules \

.PHONY: clean/node_modules
clean/node_modules: ## Remove installed npm dependencies.
	$(RM) node_modules
