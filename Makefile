# Makefile for packaging skills

# Automatically discover all skills (directories containing SKILL.md)
SKILLS = $(patsubst %/,%,$(dir $(wildcard */SKILL.md)))

# Default target - package all skills
.PHONY: all
all: $(addsuffix .zip,$(SKILLS))

# Alias for all
.PHONY: package
package: all

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make all             - Package all skills as zip files (default)"
	@echo "  make package         - Same as 'make all'"
	@echo "  make <skill>.zip     - Package a specific skill (e.g., make fermi-estimation.zip)"
	@echo "  make clean           - Remove all generated zip files"
	@echo "  make list            - List all available skills"

# Pattern rule for packaging individual skills
%.zip: %/SKILL.md
	@echo "Packaging $*..."
	@cd $* && zip -r ../$*.zip . -x '*.pyc' -x '__pycache__/*' -x '.DS_Store' -q
	@echo "Created $*.zip"

# Clean up generated zip files
.PHONY: clean
clean:
	@echo "Removing all skill zip files..."
	@rm -f $(addsuffix .zip,$(SKILLS))
	@echo "Done"

# List all skills
.PHONY: list
list:
	@echo "Available skills:"
	@for skill in $(SKILLS); do echo "  - $$skill"; done
