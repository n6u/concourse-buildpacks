include .env

IMAGE := concourse-buildpacks
PACK_VERSION := 0.23.0
JAVA_VERSION := 17
IMAGE_FULL := $(CONTAINER_REG)/$(IMAGE):java$(JAVA_VERSION)-pack$(PACK_VERSION)

.PHONY:build

build: .initialized
	@docker buildx use $(IMAGE)-builder
	@echo $(CONTAINER_REG_PASSWORD) | docker login -u $(CONTAINER_REG_USER) --password-stdin
	@docker buildx build \
		--platform linux/amd64,linux/arm64 \
		--push \
		--build-arg "src_image=cycloid/concourse-dind:latest" \
		--build-arg "pack_version=$(PACK_VERSION)" \
		--build-arg "java_version=$(JAVA_VERSION)" \
		-t $(IMAGE_FULL) .

.initialized:
	touch .initialized
	@docker buildx create --name concourse-buildpacks-builder
