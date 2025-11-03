/*
 * use <Package>::<ModuleName>;
 * use <Package>::<ModuleName>::<Function>;
 * use <Package>::<ModuleName>::<Struct>;
 * use <Package>::<ModuleName>::{Self,};
 * use <Package>::<ModuleName>::{Self, <Struct>};
 * use <Package>::<ModuleName>::{Self, <Struct>, <Struct>};
 * Ex: 
 * use sui::object::{Self, UID}; 
 * use sui::transfer::transfer;
 * use 0x2::table::Table;
 * use sui::coin;
 * 
 * 補充：
 * Self 表示所有 function
 * as 關鍵字用來取別名。
**/

module module_2::import;

use std::string::{ Self, String };
use std::ascii::{ Self, String as AsciiString };





fun a(
    s1: string::String,
    s2: AsciiString,
){
   //string::append(s, r)
}





// === Imports ===
