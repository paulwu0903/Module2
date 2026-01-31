module module_2::functino_sample2;


use module_2::functino_sample1::add_package;

fun add_function2(): u64{
    let sum =add_package(1,2);
    sum
}

