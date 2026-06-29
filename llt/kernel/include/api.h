#ifndef API
#define API

#include "plugin.h"

typedef struct context {

} Context;

typedef struct project {
    Plugins plugins;
    Context context;
} Project;

Project project_init(Context *ctx, Plugins *plgs);

#endif