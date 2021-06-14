#!/bin/bash

function app:init {
  ui:init
}

function app:install {
  ui:install
  db:install
}

function app:start {
  db:start
  ui:start
}

function ui:init {
  cp config.json.sample config.json
  touch views/statsabove.ejs
  touch views/statsbelow.ejs
  touch views/statsheader.ejs
}

function ui:install {
  npm install
}

function ui:start {
  npm start
}

## db:install       Install db stuff
function db:install {
  echo "Install"
}

function db:start {
  docker run --publish=7474:7474 --publish=7687:7687 --name neo4j \
  --volume=$PWD:/workspace --volume=$HOME/neo4j/data:/data --volume $HOME/neo4j/import:/var/lib/neo4j/import --volume $PWD/neo4j/plugins:/var/lib/neo4j/plugins --volume $PWD/neo4j/conf:/var/lib/neo4j/conf \
  -e NEO4JLABS_PLUGINS=\[\"apoc\"\] -e NEO4J_dbms_security_procedures_unrestricted=apoc.\\\* -e NEO4J_apoc_trigger_enabled=true neo4j:3.5.8
}

function db:bootstrap {
  docker-compose exec bash -c "/vagrant/setup-neo4j.sh $1 $2 $3"
}

function vagrant:run {
    vagrant up ; vagrant ssh -- -t 'cd /vagrant; node app.js'
}

#${@:-info}