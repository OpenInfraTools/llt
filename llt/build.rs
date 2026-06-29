use std::process::Command;

fn main() {
    println!("cargo:rerun-if-changed=src/");

    let status = Command::new("cbindgen")
        .arg(".")
        .arg("-o")
        .arg("include/llt.h")
        .status()
        .expect("failed to run cbindgen");

    if !status.success() {
        panic!("cbindgen failed");
    }
}