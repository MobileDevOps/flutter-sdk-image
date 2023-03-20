IMAGE_TAG := $(IMAGE_TAG)
IMAGE := mobiledevops/flutter-sdk-image

release: \
	tag_image \
	dockerhub_push

tag_image: build
	docker tag $(IMAGE):latest $(IMAGE):$(IMAGE_TAG)

build:
	docker build -t $(IMAGE) .

dockerhub_push:	
	docker push $(IMAGE):latest \
	&& docker push "$(IMAGE):$(IMAGE_TAG)"

.PHONY: release tag_image build dockerhub_push
