module module_2::syntax;

// === Imports ===

const ENumOneIsOne: u64 = 0;

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

    let mut num1: u64 = 1; // mutable
    let mut num2: u8 = 2; // mutable
    let num3 = num1 + (num2 as u64);
    let num4 = 10u32;

    let is_ok: bool = false;

    let paul_address: address = @0x1232445346;
    
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

    let num4: u64 = if (num1 == 4){
        num1 + 6
    }else if(is_ok){
        num2 as u64 + 5
    }else{
        num1 + 2
    };
    
    
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

    let mut i = 0;
    while(i < 10){
        if(i == 5) break;
        i = i + 1;
   };

    
    /*
    * Abort & Assert：
    *  abort 通常會搭配條件式。
    *  if (<不期望的condition>) abort <Error Code: u64>;
    * 
    * assert! 則可以把上面的寫法整合成一句，類似 Solidity 的 require
    * assert!(<期望的condition>, <Error Code>)
    * TODO: Example
    **/

    if (num1 == 1){
        abort ENumOneIsOne // u64
    };

    assert!(num1 != 1, ENumOneIsOne);
    
}
