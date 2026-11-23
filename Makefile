SHELL := /bin/sh
TOFU_ROOTS := infrastructure/bootstrap/state-backend infrastructure/environments/aws-development infrastructure/environments/aws-staging infrastructure/environments/aws-production infrastructure/environments/aws-shared-services

.PHONY: help fmt validate plan-production lint test

help:
	@echo "Targets disponibles: fmt, validate, plan-production, lint, test"

fmt:
	tofu fmt -recursive infrastructure

validate:
	@set -eu; for root in $(TOFU_ROOTS); do \
		tofu -chdir=$$root init -backend=false -input=false; \
		tofu -chdir=$$root validate; \
	done

plan-production:
	@echo "Revisión obligatoria; no ejecuta aprovisionamiento."
	tofu -chdir=infrastructure/environments/aws-production plan

lint:
	@find kubernetes platform gitops applications -name '*.yaml' -o -name '*.yml' | sort

test:
	@echo "Ejecutar las validaciones de scripts/validation en CI."
