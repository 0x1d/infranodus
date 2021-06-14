SHELL=/bin/bash

ctrl = source app.sh ;

default: info

it: app
so: run
not: stop

info: .env
	@$(ctrl) info

.env:
	@$(ctrl) env:init

app: info plugins
	@$(ctrl) app:init

run:
	@$(ctrl) app:run

stop:
	@$(ctrl) app:stop

dev:
	@$(ctrl) vagrant:run

#TODO run when neo4j service is up
bootstrap:
	@$(ctrl) db:bootstrap

deps:
	@mkdir deps

include plugins.mk