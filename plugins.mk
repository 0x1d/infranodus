NEO4J_APOC_VERSION=3.5.0.4

out=deps

plugins: .env ${out}/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar

${out}:
	@mkdir ${out}

${out}/plugins/apoc-${NEO4J_APOC_VERSION}-all.jar: ${out}
	wget --quiet --directory-prefix=${out}/plugins/ \
		https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${NEO4J_APOC_VERSION}/apoc-${NEO4J_APOC_VERSION}-all.jar
