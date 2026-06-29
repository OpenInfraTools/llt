#ifndef ARENA_H
#define ARENA_H

#include <stddef.h>
#include <stdint.h>


typedef struct Arena {
    uint8_t *buffer;
    size_t capacity;
    size_t offset;
} Arena;

void arena_init(Arena *a, size_t capacity);
void arena_free(Arena *a);
void arena_reset(Arena *a);

void* arena_alloc(Arena *a, size_t size);
void* arena_alloc_aligned(Arena *a, size_t size, size_t align);

#endif