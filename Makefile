NAME = PinKit
SCHEME = $(NAME) (macOS)
WORKSPACE = $(NAME).xcworkspace

BUILD_DIR = $(shell pwd)/build
DOCS_DIR = $(shell pwd)/docs
REPORTS_DIR = $(shell pwd)/build/Reports
SOURCE_FILES = $(shell pwd)/$(NAME)/**/*.{h,m}

clean:
	rm -rf $(BUILD_DIR)
	rm -rf Carthage
	rm -rf $(NAME).framework.zip
	rm -rf $(DOCS_DIR)

init:
	gem install bundler
	bundle install
	brew reinstall carthage

bootstrap:
	carthage bootstrap

test:
	@mkdir -p '$(BUILD_DIR)/TestOutput'
	@set -o pipefail && \
	env LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 NSUnbufferedIO=YES \
	xcodebuild \
	-workspace "$(WORKSPACE)" \
	-scheme "$(SCHEME)" \
	-derivedDataPath '$(BUILD_DIR)' \
	clean build test \
	| tee '$(BUILD_DIR)/TestOutput/${SCHEME}.log' \
	| xcpretty \
	--report html \
	--output '${BUILD_DIR}/TestOutput/report.html' \
	--report junit --output '${BUILD_DIR}/TestOutput/report.junit'

framework:
	carthage build --no-skip-current
	carthage archive $(NAME)

docs: docs-pre jazzy docs-post

docs-pre:
	mkdir -p include/$(NAME)
	find "$(shell pwd)/$(NAME)" -iname "*.h" -not -path "*/$(NAME).h" \
	  -exec ln -s {} "$(shell pwd)/include/$(NAME)" \;
	ln -s $(shell pwd)/$(NAME)/$(NAME).h $(shell pwd)/include/$(NAME).h

docs-post:
	rm -rf include

jazzy:
	jazzy \
	--objc \
	--clean \
	--umbrella-header include/$(NAME).h \
	--framework-root . \
	--module $(NAME) \
	--hide-documentation-coverage \
	--sdk macosx \
	--exclude "$(NAME)Tests" \
	--skip-undocumented \
	--output "$(DOCS_DIR)" \
	--author "Marcel Dierkes" \
	--github_url "https://github.com/newmarcel/PinKit" \
	--theme fullwidth \
	--author_url "https://github.com/newmarcel"
	open "$(DOCS_DIR)/index.html"

clangformat:
	clang-format -style=file -i $(SOURCE_FILES)

coverage: test
	slather coverage --html
	open '$(REPORTS_DIR)/index.html'

.PHONY: clean bootstrap test framework docs docs-pre jazzy docs-post clangformat coverage
