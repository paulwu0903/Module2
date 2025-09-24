module module_2::syntax;

// === Imports ===


// === Constants ===

//test function
#[test]
public fun demo_variables_and_constants(){
    /* 
    * 基本類型(type)：
    * 整數(u8, u32, u64, u128, u256)、布林值(bool)、地址(address)
    * PS：地址前要加 "@"
    * 變數：
    * let <variable name>: <type> = <初始值>;
    * let <variabe name> = <初始值>;
    * let <variable name>;
    * 常數：
    * const <name>: <type> = <value>;
    *
    * TODO: Example 
    **/


    /*
    * 條件式：
    *   if (<condition>){
    *
    *   }else if (<condition>){
    *       
    *   }else{
    *       
    *   };
    * TODO: Example
    **/

    /*
    * 迴圈：
    *   loop: 無限迴圈，須設定終止點。
    *   loop {
    *        if(<condition>) break
    *         if (<condition>) continue
    *     };
    *  
    * while: 設進入迴圈條件，當條件不成立則終止。
    * while (<bool_expression>) <expression>;
    * TODO: Example
    **/

    
    /*
    * Abort & Assert：
    *  abort 通常會搭配條件式。
    *  if (<不期望的condition>) abort <Error Code>;
    * 
    * assert! 則可以把上面的寫法整合成一句，類似 Solidity 的 require
    * assert!(<期望的condition>, <Error Code>)
    * TODO: Example
    **/ 

    
}
