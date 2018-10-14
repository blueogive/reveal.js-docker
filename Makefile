.PHONY : docker-build docker-clean docker-prune docker-check

docker-build:
	@docker build \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` .

docker-clean :
	@echo Removing dangling/untagged images
	docker images -q --filter dangling=true | xargs docker rmi --force

docker-prune :
	@echo Pruning Docker images/containers not in use
	docker system prune -a

docker-check :
	@echo Computing reclaimable space consumed by Docker artifacts
	docker system df
