IMAGE_REGISTRY ?= lqshow
TARGET_IMAGE ?= sgx-hello-world

.PHONY: clean
clean:
	@echo "PHASE: Cleaning ..."
	cd src/ && make clean

.PHONY: build
build:
	@echo "PHASE: Building hello_world ..."
	cd src/ && make clean && make

.PHONY: image
image:
	@echo "PHASE: Building image $(TARGET_IMAGE) ..."
	docker build -t $(IMAGE_REGISTRY)/$(TARGET_IMAGE) .

.PHONY:
lint:

