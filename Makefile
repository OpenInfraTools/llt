NAME = llt

ZIG = zig

BUILD_DIR = build

CFLAGS = -Wall -Wextra -O2 -fPIC

MODULES = core

INCLUDES := $(foreach m,$(MODULES),-I$(m)/include)

SRCS := $(foreach m,$(MODULES),$(wildcard $(m)/src/*.c))

TARGET = $(BUILD_DIR)/lib$(NAME).so

all:
	@mkdir -p $(BUILD_DIR)
	$(ZIG) cc -shared $(CFLAGS) $(INCLUDES) $(SRCS) -o $(TARGET)

linux:
	@mkdir -p $(BUILD_DIR)/linux
	$(ZIG) cc -shared -target x86_64-linux $(CFLAGS) $(INCLUDES) $(SRCS) -o $(BUILD_DIR)/linux/lib$(NAME).so

windows:
	@mkdir -p $(BUILD_DIR)/windows
	$(ZIG) cc -shared -target x86_64-windows $(CFLAGS) $(INCLUDES) $(SRCS) -o $(BUILD_DIR)/windows/lib$(NAME).dll

darwin-x64:
	@mkdir -p $(BUILD_DIR)/darwin/x64
	$(ZIG) cc -dynamiclib -target x86_64-macos $(CFLAGS) $(INCLUDES) $(SRCS) -o $(BUILD_DIR)/darwin/x64/lib$(NAME).dylib

DARWIN_TARGET = build/libllt.dylib

darwin:
	@mkdir -p build
	zig cc -dynamiclib \
	-Wall -Wextra -O2 -fPIC \
	-Icore/include \
	core/src/core.c \
	-o $(DARWIN_TARGET)

test:
	$(ZIG) cc $(CFLAGS) $(INCLUDES) tests/*.c $(SRCS) -o $(BUILD_DIR)/test
	./$(BUILD_DIR)/test

test-go: darwin
	go run main.go

info:
	@echo $(MODULES)
	@echo $(SRCS)
	@echo $(INCLUDES)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all linux windows darwin-x64 darwin-arm test info clean