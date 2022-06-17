SHELL=/bin/bash

targets = ( info init build run bootstrap )

ENV_FILE ?= default.env
DATA_PATH ?= ./data

default: info
it: init build 
so: run

${targets}: ${ENV_FILE}
	@bash -c "source $< ; ./ctl.sh $@ "

include plugins.mk