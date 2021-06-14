NEO4J_VERSION?=3.5.8
NEO4J_APOC_VERSION?=3.5.0.4
NEO4J_DEFAULT_USER?=neo4j
NEO4J_DEFAULT_PASSWORD?=neo4j
NEO4J_NEW_PASSWORD?=Really_Secure_Local_Db_Password

it: init deps plugins
so: up

init:
	cp config.json.sample config.json
	touch views/statsabove.ejs
	touch views/statsbelow.ejs
	touch views/statsheader.ejs

up:
	docker-compose up --remove-orphans

bootstrap:
	./stack.sh db:bootstrap ${NEO4J_DEFAULT_USER} ${NEO4J_DEFAULT_PASSWORD} ${NEO4J_NEW_PASSWORD}

deps:
	@mkdir deps

plugins: deps/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar

deps/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar: deps
	wget --quiet --directory-prefix=deps/plugins/ \
		https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${NEO4J_APOC_VERSION}/apoc-${NEO4J_APOC_VERSION}-all.jar
