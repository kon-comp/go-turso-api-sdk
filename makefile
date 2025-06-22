# Makefile for OpenAPI Generator usage in a Go project

OPENAPI_GENERATOR_CLI = openapitools/openapi-generator-cli
OPENAPI_SPEC_URL = https://raw.githubusercontent.com/kon-comp/go-turso-api-sdk/refs/heads/main/api-reference/openapi.json
GENERATOR_IMAGE = $(OPENAPI_GENERATOR_CLI)
GENERATOR_CMD = docker run --rm -v "$(PWD):/local" $(GENERATOR_IMAGE)
GENERATOR_ARGS = generate -i $(OPENAPI_SPEC_URL) \
	--git-repo-id go-turso-api-sdk \
	--git-user-id kon-comp \
	--git-host github.com \
	--api-package turso \
	-g go \
	-o /local/ \
	--skip-validate-spec

.PHONY: all generate clean install fmt help

all: generate

generate:
	$(GENERATOR_CMD) $(GENERATOR_ARGS)

clean:
	rm -rf docs/ *.md .openapi-generator .openapi-generator-ignore

install:
	docker pull $(GENERATOR_IMAGE)

fmt:
	go fmt ./...

help:
	@echo "Usage:"
	@echo "  make generate   # Generate Go SDK from OpenAPI spec"
	@echo "  make clean      # Remove generated files"
	@echo "  make install    # Pull OpenAPI Generator Docker image"
	@echo "  make fmt        # Format Go code"