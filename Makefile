SHELL=/bin/bash
NEO4J_VERSION?=3.5.8
NEO4J_APOC_VERSION?=3.5.0.4
NEO4J_DEFAULT_USER?=neo4j
NEO4J_DEFAULT_PASSWORD?=neo4j
NEO4J_NEW_PASSWORD?=Really_Secure_Local_Db_Password

SOURCE_APP = source stack.sh ;

init:
	@$(SOURCE_APP) app:init

up: init deps plugins
	docker-compose up --remove-orphans

bootstrap:
	$(SOURCE_APP) db:bootstrap ${NEO4J_DEFAULT_USER} ${NEO4J_DEFAULT_PASSWORD} ${NEO4J_NEW_PASSWORD}

deps:
	@mkdir deps

plugins: deps/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar

deps/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar: deps
	wget --quiet --directory-prefix=deps/plugins/ \
		https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${NEO4J_APOC_VERSION}/apoc-${NEO4J_APOC_VERSION}-all.jar
