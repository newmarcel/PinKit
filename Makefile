NAME = PinKit
SCHEME = $(NAME) (macOS)
WORKSPACE = PinKit.xcworkspace

BUILD_DIR = $(shell pwd)/build
DOCS_DIR = $(shell pwd)/docs
SOURCE_FILES = $(shell pwd)/$(NAME)/**/*.{h,m}

clean:
	rm -rf $(BUILD_DIR)
	rm -rf Carthage
	rm -rf $(NAME).framework.zip
	rm -rf $(DOCS_DIR)

bootstrap:
	carthage bootstrap --use-ssh --cache-builds

test:
	fastlane scan \
	--clean \
	--workspace "$(WORKSPACE)" \
	--scheme "$(SCHEME)" \
	--derived_data_path "$(BUILD_DIR)" \
	--output_directory "$(BUILD_DIR)/TestOutput"

framework:
	carthage build --no-skip-current
	carthage archive $(NAME)

docs:
# TODO: JAZZY
	open "$(DOCS_DIR)/html/index.html"

clangformat:
	clang-format -style=file -i $(SOURCE_FILES)

.PHONY: clean bootstrap test framework docs clangformat
