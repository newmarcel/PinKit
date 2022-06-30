NAME = PinKit

BUILD_DIR = build
DOCS_DIR = docs
SOURCE_FILES = $(shell pwd)/$(NAME)/**/*.{h,m}

clean:
	rm -rf $(BUILD_DIR)
	rm -rf Carthage
	rm -rf $(NAME).framework.zip
	rm -rf $(DOCS_DIR)

test:
	set -o pipefail && env NSUnbufferedIO=YES \
	xcodebuild test \
	-scheme "$(NAME)" \
	-destination "platform=macOS"

clangformat:
	clang-format -style=file -i $(SOURCE_FILES)

.PHONY: clean test clangformat
