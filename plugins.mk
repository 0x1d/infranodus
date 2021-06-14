NEO4J_APOC_VERSION=3.5.0.4

plugins: deps/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar

deps/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar: deps
	wget --quiet --directory-prefix=deps/plugins/ \
		https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${NEO4J_APOC_VERSION}/apoc-${NEO4J_APOC_VERSION}-all.jar
