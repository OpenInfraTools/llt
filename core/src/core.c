#include "core.h"

void math_add(const MathInput *in, MathOutput *out) {
    if (!in || !out) {
        if (out) {
            out->result = 0;
            out->error = 1;
        }
        return;
    }

    out->result = in->a + in->b;
    out->error = 0;
}