mod Module;

#[repr(C)]
pub struct ModuleHandle {
    ptr: *mut Module,
}

pub struct Module {
    functions: Vec<Function>,
}