package main

import (
	"fmt"
	"unsafe"

	"github.com/ebitengine/purego"
)

// Структуры должны совпадать по layout с C-структурами.
// int в C на большинстве платформ — это int32, паддинга здесь нет.
type MathInput struct {
	A int32
	B int32
}

type MathOutput struct {
	Result int32
	Error  int32
}

func main() {
	lib, err := purego.Dlopen("./build/libllt.dylib", purego.RTLD_NOW|purego.RTLD_GLOBAL)
	if err != nil {
		panic(err)
	}

	var mathAdd func(in, out unsafe.Pointer)
	purego.RegisterLibFunc(&mathAdd, lib, "math_add")

	in := MathInput{A: 3, B: 4}
	var out MathOutput

	mathAdd(unsafe.Pointer(&in), unsafe.Pointer(&out))

	fmt.Printf("result=%d error=%d\n", out.Result, out.Error)
}
