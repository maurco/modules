.PHONY: format

all: format

format:
	@terraform fmt -recursive
