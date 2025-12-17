#ifndef HELPERS_H
#define HELPERS_H

#define freeandnull(ptr) do { \
    if (ptr != NULL) { \
        (free)(ptr); \
        (ptr) = NULL; \
    } \
} while(0)

#endif