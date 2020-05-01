# Makefile to build docker image & push to hub.docker.com
# heroku deployment using container on  heroku 
# will incorporate using travis
# pmcampbell
# 2020-05-01

#include config.make
#instead of include, here for simplicty of testing
VERSION=0.1.0
HUBUSER=tricia
RUN_NAME=flastpytravis
HOST_PORT=5555
CONTAINER_PORT=5000   # default for flask
HEROKU1=wordcount-pmc-stage
#export $(shell sed 's/=.*//' $(cnf))
 
# .PHONY used if no options given
.PHONY: help

# HELP
# The awk will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

help: ## This help.
	@echo vars from config.make:
	@echo Makefile for container $(RUN_NAME) 
	@echo clone: $(GIT_REPO)
	@echo build: $(RUN_NAME)
	@echo run: $(RUN_NAME)
	@echo  port forward on run container:$(CONTAINER_PORT) to host:$(HOST_PORT)
	@echo 
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


# clone (need keys, or interactive w uid/pass)
clone: ## clone & zip the repo into app.tgz
	if [ -d app ] ; then  rm -rf app; fi
	mkdir app;  git clone $(GIT_REPO) app
	tar -czf app.tgz app
 
build: ## build container image from Dockerfile
	docker build -t $(RUN_NAME) . 

run-fg:  ## run the container logs to stdout
	docker run -p $(HOST_PORT):$(CONTAINER_PORT) --name $(RUN_NAME)  $(RUN_NAME)

run:  ## run the container detached (~in the background )
	docker run -d -p $(HOST_PORT):$(CONTAINER_PORT) --name $(RUN_NAME)  $(RUN_NAME)
	docker ps 

sh:	shell
shell:  ## shell into the container
	docker exec -ti $(RUN_NAME) sh

all: clone build run
up:  build run

stoprun: stop run
clean:  stop prune

stop: ## stop and remove the container
	docker stop $(RUN_NAME) ; docker rm $(RUN_NAME) ; docker ps

prune:  # clean up unused containers
	docker system prune -f
	docker images

check:  ## check docker run time
	systemctl status  docker
	docker info
	docker version
	docker images
	docker ps

publish:  ## publish to  docker hub, interactive 
        ifdef DOCKER_USER
		docker login   -u $(DOCKER_USER)
        else
		docker login 
        endif
        docker tag ${RUN_NAME} ${HUBUSER}/${RUN_NAME}:${VERSION}
        docker image push ${HUBUSER}/${RUN_NAME}:${VERSION}

heroku-all: build heroku-create heroku-publish
heroku-update: build heroku-publish
heroku-publish: heroku-push-release ## push and release to heroku
heroku-push-release: ## push and release to heroku
	@echo push to the heroku repo
	heroku container:push web --app $(HEROKU1)
	@echo release app
	heroku container:release web --app $()
	@echo if the last step worked load https://$(HEROKU1).herokuapp.com in a browser

heroku-create: ## using heroku commands
	@echo interactive login to heroku
	heroku login -i 
	@echo create app on heroku 
	heroku create $(HEROKU1) 

define tokenfile =
fn=heroku-auth-token.txt
heroku auth:token >> $fn
TOKEN=$(cat $fn)
endef 
# needed for bash script
# https://www.gnu.org/software/make/manual/html_node/One-Shell.html
.ONESHELL:

heroku-via-docker:  	## use heroku cli to generate token  not working, abandoned
	$(tokenfile)
	docker login --username=_ -- password=$(TOKEN) registry.heroku.com
	docker build -t registry.heroku.com/$(RUN_NAME)/web .
	docker push registry.heroku.com/$(RUN_NAME)/web

