/* 
 * module <address>::<name>;
 * 
**/

// module module_2::my_module {
//     // === Imports ===
//     // std: 0x1
//     // sui: 0x2
//     use std::string::{Self, String};
//     use std::debug::{ Self };
    
//     // === Constants ===
//     const TOTAL_NUM: u64 = 0;

//     // === Structs ===
//     public struct Person has drop{
//         name: String,
//         age: u8,
//     }

//     //=== Public Function ===
//     public fun print() {
//         let paul = Person{
//             name: string::utf8(b"Paul"),
//             age: 10,
//         };
//         debug::print(&paul)
//     }
// }

module module_2::my_module;
// === Imports ===
// std: 0x1
// sui: 0x2
use std::string::{Self, String};
use std::debug;

// === Constantss ===
// const TOTAL_NUM: u64 = 0;

// === Public Structs ===
public struct Person has drop{
    name: String,
    age: u8,
}

//=== Functions ===
public fun print() {
    let paul = Person{
        name: string::utf8(b"Paul"),
        age: 10,
    };
    debug::print(&paul)
}