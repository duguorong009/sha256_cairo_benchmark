%builtins output range_check bitwise

from src.sha256 import (
    sha256,
    finalize_sha256,
)
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.memcpy import memcpy
from starkware.cairo.common.uint256 import uint256_eq

// ref: https://github.com/cartridge-gg/cairo-sha256/blob/main/tests/test_sha256.cairo#L13
func main{output_ptr: felt*, range_check_ptr, bitwise_ptr: BitwiseBuiltin*}() {
    alloc_locals;

    let (hello_world) = alloc();
    assert hello_world[0] = 'hell';
    assert hello_world[1] = 'o wo';
    assert hello_world[2] = 'rld\x00';

    let (local sha256_ptr: felt*) = alloc();
    let sha256_ptr_start = sha256_ptr;
    let (hash) = sha256{sha256_ptr=sha256_ptr}(hello_world, 11);
    finalize_sha256(sha256_ptr_start=sha256_ptr_start, sha256_ptr_end=sha256_ptr);

    let a = hash[0];
    assert a = 3108841401;
    let b = hash[1];
    assert b = 2471312904;
    let c = hash[2];
    assert c = 2771276503;
    let d = hash[3];
    assert d = 3665669114;
    let e = hash[4];
    assert e = 3297046499;
    let f = hash[5];
    assert f = 2052292846;
    let g = hash[6];
    assert g = 2424895404;
    let h = hash[7];
    assert h = 3807366633;

    return ();
}