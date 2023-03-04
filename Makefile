# Build configuration
# -------------------

APP_NAME := $(shell pwd | xargs basename)
APP_VERSION := $(shell grep -Eo 'version: "[0-9\.]*"' mix.exs | cut -d '"' -f 2)
GIT_REVISION := $(shell git rev-parse HEAD)
DOCKER_IMAGE_TAG ?= $(APP_VERSION)
DOCKER_REGISTRY ?=
DOCKER_LOCAL_IMAGE:= $(APP_NAME):$(DOCKER_IMAGE_TAG)
DOCKER_REMOTE_IMAGE:= $(DOCKER_REGISTRY)/$(DOCKER_LOCAL_IMAGE)


# Linter and formatter configuration
# ----------------------------------

PRETTIER_FILES_PATTERN = \
'{js,css,scripts}/**/*.{js,graphql,scss,css}' \
'../*.md' '../*.config.{js,json}' \
'../.github/**/*.{yml,yaml}' \
'../assets/{js,css,scripts}/**/*.{js,graphql,scss,css}' \
'../apps/*/*.md' \
'../apps/*/assets/{js,css,scripts}/**/*.{js,graphql,scss,css}'
STYLES_PATTERN = 'css'

# Introspection targets
# ---------------------

.PHONY: help
help: header targets

.PHONY: header
header:
	@printf "\n\033[34mEnvironment\033[0m"
	@printf "\n\033[34m---------------------------------------------------------------\033[0m"
	@printf "\n\033[33m%-23s\033[0m" "APP_NAME"
	@printf "\033[35m%s\033[0m" $(APP_NAME)
	@printf "\n\033[33m%-23s\033[0m" "APP_VERSION"
	@printf "\033[35m%s\033[0m" $(APP_VERSION)
	@printf "\n\033[33m%-23s\033[0m" "GIT_REVISION"
	@printf "\033[35m%s\033[0m" $(GIT_REVISION)
	@printf "\n\033[33m%-23s\033[0m" "DOCKER_IMAGE_TAG"
	@printf "\033[35m%s\033[0m" $(DOCKER_IMAGE_TAG)
	@printf "\n\033[33m%-23s\033[0m" "DOCKER_REGISTRY"
	@printf "\033[35m%s\033[0m" $(DOCKER_REGISTRY)
	@printf "\n\033[33m%-23s\033[0m" "DOCKER_LOCAL_IMAGE"
	@printf "\033[35m%s\033[0m" $(DOCKER_LOCAL_IMAGE)
	@printf "\n\033[33m%-23s\033[0m" "DOCKER_REMOTE_IMAGE"
	@printf "\033[35m%s\033[0m" $(DOCKER_REMOTE_IMAGE)
	@printf "\n"

.PHONY: targets
targets:
	@printf "\n\033[34mTargets\033[0m"
	@printf "\n\033[34m---------------------------------------------------------------\033[0m\n"
	@perl -nle'print $& if m{^[a-zA-Z_-\d]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-22s\033[0m %s\n", $$1, $$2}'

# Build targets
# -------------

.PHONY: prepare
prepare:
	mix deps.get
	npm ci --prefix assets

.PHONY: build
build: ## Build a Docker image for the OTP release
	docker build --rm --tag $(DOCKER_LOCAL_IMAGE) .

.PHONY: push
push: ## Push the Docker image to the registry
	docker tag $(DOCKER_LOCAL_IMAGE) $(DOCKER_REMOTE_IMAGE)
	docker push $(DOCKER_REMOTE_IMAGE)

# Development targets
# -------------------

.PHONY: run
run: ## Run the server in an IEx shell
	iex -S mix phx.server

.PHONY: dependencies
dependencies: ## Install hex and npm dependencies
	mix deps.get
	npm install --prefix assets

.PHONY: test
test: ## Run the test suite
	mix test

# Check, lint and format targets
# ------------------------------

.PHONY: check
check: check-format check-unused-dependencies check-dependencies-security check-code-security check-static-typing check-code-coverage ## Run various checks on source files

.PHONY: check-code-coverage
check-code-coverage:
	# mix coveralls

.PHONY: check-dependencies-security
check-dependencies-security:
	mix deps.audit

.PHONY: check-code-security
check-code-security:
	mix sobelow

.PHONY: check-format
check-format:
	mix format --check-formatted
	cd assets && npx prettier --check $(PRETTIER_FILES_PATTERN)

.PHONY: check-unused-dependencies
check-unused-dependencies:
	mix deps.unlock --check-unused

.PHONY: check-static-typing
check-static-typing:
	mix dialyzer

.PHONY: format
format: ## Format source files
	mix format
	cd assets && npx prettier --write $(PRETTIER_FILES_PATTERN)
	cd assets && npx stylelint $(STYLES_PATTERN) --fix --quiet

.PHONY: lint
lint: lint-elixir lint-scripts lint-styles ## Lint source files

.PHONY: lint-elixir
lint-elixir:
	mix compile --warnings-as-errors --force
	mix credo --strict

.PHONY: lint-scripts
lint-scripts:
	cd assets && npx eslint --config .eslintrc.json ../

.PHONY: lint-styles
lint-styles:
	cd assets && npx stylelint $(STYLES_PATTERN)