#include "arena.h"
#include <stdlib.h>
#include <string.h>

static size_t align_up(size_t x, size_t align)
{
    return (x + (align - 1)) & ~(align - 1);
}

void arena_init(Arena *a, size_t capacity)
{
    a->buffer = (uint8_t*)malloc(capacity);
    a->capacity = capacity;
    a->offset = 0;
}

void arena_free(Arena *a)
{
    free(a->buffer);
    a->buffer = NULL;
    a->capacity = 0;
    a->offset = 0;
}

void arena_reset(Arena *a)
{
    a->offset = 0;
}

void* arena_alloc_aligned(Arena *a, size_t size, size_t align)
{
    size_t current = align_up(a->offset, align);

    if (current + size > a->capacity) {
        return NULL;
    }

    void *ptr = a->buffer + current;
    a->offset = current + size;
    return ptr;
}

void* arena_alloc(Arena *a, size_t size)
{
    return arena_alloc_aligned(a, size, 8);
}