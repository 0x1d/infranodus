. /var/lib/neo4j/app.env
apt update && apt install -y wget
wget --directory-prefix=/var/lib/neo4j/plugins \
    https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${NEO4J_APOC_VERSION}/apoc-${NEO4J_APOC_VERSION}-all.jar