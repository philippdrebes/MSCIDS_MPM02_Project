.EXPORT_ALL_VARIABLES:

OS_NAME := $(shell uname -m)

ifeq ($(OS_NAME) , arm64)
ENV_FILE := .env.aarch
else
ENV_FILE := .env.latest
endif

# see https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile
THIS_FILE := $(lastword $(MAKEFILE_LIST))

# Docker CMD:
RSTUDIO_DOCKER_START = docker compose up -d rstudio && docker compose logs -f rstudio

# Include other definitions
include *.mk
###########################
# PROJECT UTILS
###########################
build: ##@Utils Builds the docker images
	$(DOCKER_BUILD)

###########################
# RSTUDIO
###########################
rstudio-start: ##@RStudio Starts R-Studio
	@echo "Starting R-Studio"
	$(RSTUDIO_DOCKER_START)

stop: ##@Jupyterlab Stops all services including the database
	@echo "Stop everything"
	docker compose down -v
