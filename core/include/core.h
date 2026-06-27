#ifndef MATH_API_H
#define MATH_API_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    int a;
    int b;
} MathInput;

typedef struct {
    int result;
    int error;
} MathOutput;

void math_add(const MathInput *in, MathOutput *out);

#ifdef __cplusplus
}
#endif

#endif