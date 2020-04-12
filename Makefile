APP_NAME=amirassov/kaggle-imaterialist
CONTAINER_NAME=kaggle-imaterialist

# HELP
.PHONY: help

help: ## This help.
	@awk 'BEGIN (FS = ":.*?## ") /^[a-zA-Z_-]+:.*?## / (printf "\033[36m%-30s\033[0m %s\n", $$1, $$2)' $(MAKEFILE_LIST)

build:  ## Build the container
	docker build -t $(APP_NAME) .

run-dgx: ## Run container in omen
	docker run \
		--gpus all \
		-itd \
		--ipc=host \
		--name=$(CONTAINER_NAME) \
		-e DISPLAY=localhost:10.0 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /raid/data_share/amirassov/kaggle-imaterialist_data:/data \
		-v /raid/data_share/amirassov/kaggle-imaterialist_dumps:/dumps \
		-v $(shell pwd):/kaggle-imaterialist $(APP_NAME) bash

run-omen: ## Run container in omen
	docker run \
		--gpus all \
		-itd \
		--ipc=host \
		--name=$(CONTAINER_NAME) \
		-e DISPLAY=localhost:10.0 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /home/videoanalytics/data/kaggle-imaterialist_data:/data \
		-v /home/videoanalytics/data/dumps:/dumps \
		-v $(shell pwd):/kaggle-imaterialist $(APP_NAME) bash

run-localhost: ## Run container in localhost
	docker run \
		--gpus all \
		-itd \
		--ipc=host \
		--name=$(CONTAINER_NAME) \
		-e DISPLAY=localhost:10.0 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /home/sh1ng/dev/data/kaggle-imaterialist:/data \
		-v /home/sh1ng/dev/data/dumps:/dumps \
		-v $(shell pwd):/kaggle-imaterialist $(APP_NAME) bash

run-ubuntu: ## Run container in ubuntu
	docker run \
		--gpus all \
		-itd \
		--ipc=host \
		--name=$(CONTAINER_NAME) \
		-e DISPLAY=localhost:10.0 \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v /media/ssd/data/kaggle-imaterialist:/data \
		-v /media/ssd/data/dumps:/dumps \
		-v $(shell pwd):/kaggle-imaterialist $(APP_NAME) bash

exec: ## Run a bash in a running container
	docker exec -it $(CONTAINER_NAME) bash

stop: ## Stop and remove a running container
	docker stop $(CONTAINER_NAME); docker rm $(CONTAINER_NAME)
