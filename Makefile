SHELL=/bin/bash

targets = ( info init run stop remove dev )


default: info
it: init app plugins
so: run

${targets}: .env
	bash -c "source $< ; ./ctl.sh $@ "

include plugins.mk