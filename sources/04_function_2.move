module module_2::functino_sample2;

use module_2::functino_sample1::{ add_package };

fun add_function(
    num1: u64,
    num2: u64
): u64{
    add_package(num1, num2)
}