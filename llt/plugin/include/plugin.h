#ifndef PLUGIN
#define PLUGIN

#include <stddef.h>

typedef struct {
    char *name;
} Plugin;

typedef struct {
    int *data;
    size_t len;
} Plugins;

#endif