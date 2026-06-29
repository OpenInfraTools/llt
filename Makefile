NAME = llt
CC = zig cc

KERNEL = llt/kernel
PLUGIN = llt/plugin
UTILS  = llt/utils
BUILD  = build

INCLUDES = \
	-I$(KERNEL)/include \
	-I$(PLUGIN)/include \
	-I$(UTILS)/include

SRCS = \
	$(KERNEL)/src/api.c \
	$(PLUGIN)/src/plugin.c \
	$(UTILS)/src/arena.c

OBJS = $(SRCS:.c=.o)

CFLAGS = -std=c11 -Wall -Wextra -fPIC $(INCLUDES)

ifeq ($(DEBUG),1)
	CFLAGS += -O0 -g
else
	CFLAGS += -O3
endif

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
	SHARED = -shared
	OUT = lib$(NAME).so
endif

ifeq ($(UNAME_S),Darwin)
	SHARED = -dynamiclib
	OUT = lib$(NAME).dylib
endif

all: $(BUILD)/$(OUT)

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/$(OUT): $(OBJS) | $(BUILD)
	$(CC) $(SHARED) -o $@ $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS)
	rm -rf $(BUILD)

re: clean all

.PHONY: all clean re