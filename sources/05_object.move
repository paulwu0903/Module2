module module_2::sample_object;


/*
 * Struct是自定義的資料結構
 * 只有 Struct 所屬的 Module 可以定義操作該 Struct 的 Functions
 * 
 * 定義 Struct 
 * public struct <struct name> has <ability *>{
 *   <field>: <type>,
 *   <field>: <type>,
 *    ...
 *   } 
 * 
 * abilities:
 * - key: 擁有此 ability 的 struct 第一個欄位必須要是 id: UID，如此便可透過id來定位到此 Object，在擁有權限的情況，對它下進行操作
 * - copy: 擁有此 ability 的 struct 可以直接被複製
 * - store: 擁有此 ability 的 struct 可以被儲存到全域存儲，且擁有此 ability 才可以放到 struct 內
 * - drop: 擁有此 ability 的  struct 可以在 function 執行結束後，自動被移除
 * 
 * Object: 
 * 一定要有 key ability ， 第一個欄位一定要是 UID 類型且欄位名稱為 id
 * 不能有 drop、copy abilities
 * 
 * object ownership:
 * - owned object: 僅擁有者可操作
 * - shared object: 共享，可讀、可寫
 * - immutable object: 唯讀
 * 
 * TODO: Example
**/

use std::string::String;
use sui::object::UID;
use sui::transfer::{Self};

// key, store, copy, drop
// key -> object 

// store, copy, drop


public struct Student has key, store {
    id: UID,
    name: String,
    score: Score
}

public struct Score has store{
    math: u8,
    eng: u8,
}


public fun new(
    name: String,
    math: u8,
    eng: u8,
    ctx: &mut TxContext,
){
    let score = Score{
        math, // math : math
        eng, // eng: eng
    };
    let student = Student{
        id: object::new(ctx),
        name,
        score: score
    };

    transfer::public_transfer(student, tx_context::sender(ctx));   
}

public fun test(
    num1: u8,
){
    let test1 = num1;
}

public fun handle_student(
    student: Student, // key  -> object
    receiver: address,
){

    // assign ownership
    // transfer::public_transfer(student, receiver);
    // transfer::public_share_object(student);
    // transfer::public_freeze_object(student);
    // burn object
    let Student{
        id: std_id, // UID
        name: std_name, // String,
        score: std_score, // Score: store
    } = student;

    let Score{
        math: math_score,
        eng: eng_score,
    } = std_score;

    object::delete(std_id);
}

public fun set_math(
    student: &mut Student,
    math: u8,
){
    student.score.math = math;
}

// public fun test(
//     score: Score,
// ){
//     let test1 = score;
// }




/* 
 * 實例化 Struct 
 * <struct name>{
 *   <field>: <value>,
 *   <field>: <value>,
 *   ...
 * }
 * TODO: Example
**/



/*
 * Function input 有 Struct 類型
 * TODO: Example
 *
**/

/*
 * Wrap
 * TODO: Example
 * Unwrap
 *  let <type>{
 *    <field>:<variable>,
 *    <field>:<variable>,
 *    ...,
 *    <field>:<variable>,
 *  } = instance;
 * TODO: Example
 * 
**/
