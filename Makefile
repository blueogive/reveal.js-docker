.PHONY : docker-build docker-clean docker-prune docker-check

VCS_URL := $(shell git remote get-url --push gh)
VCS_REF := $(shell git rev-parse --short HEAD)
BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
TAG_DATE := $(shell date -u +"%Y%m%d")
DOCKER_HUB_USER := blueogive
DOCKER_IMG_NAME := reveal.js-docker
# Use BuildKit
export DOCKER_BUILDKIT := 1

docker-login:
	@pass hub.docker.com/$(DOCKER_HUB_USER) | docker login -u $(DOCKER_HUB_USER) --password-stdin

docker-build: Dockerfile demo.html whiteboard.html index.html docker-login
	@docker build \
	--build-arg VCS_URL=${VCS_URL} \
	--build-arg VCS_REF=${VCS_REF} \
	--build-arg BUILD_DATE=${BUILD_DATE} \
	--tag $(DOCKER_HUB_USER)/$(DOCKER_IMG_NAME):$(TAG_DATE) \
	--tag $(DOCKER_HUB_USER)/$(DOCKER_IMG_NAME):latest .

docker-push : docker-build
	@docker push $(DOCKER_HUB_USER)/$(DOCKER_IMG_NAME):$(TAG_DATE)
	@docker push $(DOCKER_HUB_USER)/$(DOCKER_IMG_NAME):latest

docker-clean :
	@echo Removing dangling/untagged images
	docker images -q --filter dangling=true | xargs docker rmi --force

docker-prune :
	@echo Pruning Docker images/containers not in use
	docker system prune -a

docker-check :
	@echo Computing reclaimable space consumed by Docker artifacts
	docker system df
