SHELL=/bin/bash

ctrl = source ctrl.sh ;

default: app

it: app
so: run
not: stop
clean: remove

app: init info plugins

info: .env
	@$(ctrl) $@

init:
	@$(ctrl) env:$@
	@$(ctrl) app:$@

run: .env
	@$(ctrl) app:$@

stop: .env
	@$(ctrl) app:$@

remove: .env
	@$(ctrl) app:$@

dev:
	@$(ctrl) dev:run

#TODO run when neo4j service is up
bootstrap:
	@$(ctrl) db:bootstrap

include plugins.mk