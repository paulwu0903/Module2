module module_2::functino_sample1;

use sui::tx_context::TxContext;
use std::u64;

/*
 * Functions:
 * <visibility?>/<entry?>/<> fun <function name>((<param name>:<type>)*): <return type>
 * - Entry Function: return 需有 drop 能力
 * - Public Function: 任何外部都可以呼叫
 * - Public(Package) Function: 僅有與此 Function 相同的 Package 的 functions 才能使用
 * - Private Function: 僅有同個 Module 的 Function 才能使用。
 * TODO: Example
**/


// public function
public fun add_public(
    num1: u64,
    num2: u64,
): u64{
    add(num1, num2)
}

// package function
public(package) fun add_package(
    num1: u64,
    num2: u64,
): u64{
    add(num1, num2)
}

// private function
fun add(
    num1: u64,
    num2: u64,
): u64{
    let sum = num1 + num2;
    sum
}

/*
 * Init Function: 部署合約會直接執行的 Function，只執行一次
 * TODO: Example
*/
fun init(ctx: &mut TxContext){
}
