SHELL = /usr/bin/env bash -xeuo pipefail

stack_name:=api-gw-lambda-load-test-001


deploy:
	poetry run aws cloudformation deploy \
		--stack-name $(stack_name) \
		--template-file template.yml \
		--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
		--no-fail-on-empty-changeset
	poetry run aws cloudformation describe-stacks \
		--stack-name $(stack_name) \
		--query Stacks[0].Outputs

create-sam-deploy-user-access-key:
	poetry run python scripts/create_access_key.py SAM

.PHONY: \
	deploy \
	create-sam-deploy-user-access-key