#!/usr/bin/make -f

define get_extension_name
	cat "$1" | \
	gawk ' \
		{ \
			if ($$1 ~ /"name"\s*:/) \
			{ \
				$$1 = "" ;\
				match($$0, /^\s*"(.+)"\s*,?\s*$$/, arr); \
				print gensub(/\W+/, "-", "g", tolower(arr[1])) \
			} \
		} \
	'
endef

define get_png_incons_filename
	cat "$1" | \
	gawk ' \
		BEGIN { icons_found = 0 } \
		{ \
			if ($$1 ~ /"icons"\s*:/) \
			{ \
				icons_found = 1 \
			} else if (icons_found && $$1 ~ /}/) \
			{ \
				icons_found = 0 \
			} else if (icons_found) { \
				match($$2, /^\s*"(.+)"\s*,?\s*$$/, arr); \
				print arr[1] \
			} \
		} \
	'
endef

SRC_DIR := $(CURDIR)/src
OUT_DIR := $(CURDIR)/out

EXTENSION_NAME := $(shell $(call get_extension_name,$(SRC_DIR)/manifest.json))
OUT_CRX := $(OUT_DIR)/$(EXTENSION_NAME).crx
OUT_TAR := $(OUT_DIR)/$(EXTENSION_NAME).tar.gz

PNG_FILES := $(foreach fn,$(shell $(call get_png_incons_filename,$(SRC_DIR)/manifest.json)),$(SRC_DIR)/$(fn))

.PHONY: all tar crx
all: tar crx
tar: $(OUT_TAR)
crx: $(OUT_CRX)

.PHONY: $(OUT_TAR)
$(OUT_TAR): check-prereq-tar $(PNG_FILES)
	mkdir -p "$$(dirname $(OUT_TAR))"
	find $(SRC_DIR) \( -name '*.json' -o -name '*.js' -o -name '*.html' -o -name '*.png' \) -printf "./%f\0" | \
		tar -cvz -f "$@" --transform 's,./,$(EXTENSION_NAME)/,' -C "$(SRC_DIR)" --null --files-from -

.PHONY: $(OUT_CRX)
$(OUT_CRX): check-prereq-crx $(PNG_FILES)
	mkdir -p "$$(dirname $(OUT_CRX))"
	chromium-browser --headless=new --pack-extension="$(SRC_DIR)" --pack-extension-key="key.pem"
	mv "$$(basename "$(SRC_DIR)").crx" "$(OUT_CRX)"

.PHONY: $(PNG_FILES)
$(PNG_FILES): $(SRC_DIR)/icon%.png: $(SRC_DIR)/icon.svg
	DISPLAY="" dbus-run-session inkscape -w "$*" -h "$*" -o "$@" "$^"

.PHONY: check-prereq-tar check-prereq-crx
check-prereq-tar:
	which gawk >/dev/null
	which inkscape >/dev/null
check-prereq-crx: check-prereq-tar
	which chromium-browser >/dev/null
