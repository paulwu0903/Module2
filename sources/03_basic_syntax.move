module module_2::syntax;

// === Imports ===


// === Constants ===

// === Errors ===
const ENumTooLarge: u64 = 0;

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

    //usigned integer
    let num1: u64 = 1; // u64: 0 ~ 2**64-1, u8, u16,u32, u64, u128,u256
    let num2: u8 = 2;
    let num3 = 3u32;
    let sum = num1 + (num2 as u64);
    // boolean
    let isOk: bool = true; // false
    // address
    let paul_address: address = @0x11111111;

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

    let k = 0;
    if (num1 == 1){
        k = (num1 as u8)+ 1;
    }else if (num2 == 3){
        k = (num2 as u64) * 2;
    }else{
        k = 1;
    };

    let k = if (num1 == 1){
        (num1 as u8)+ 1
    }else if (num2 == 3){
        (num2 as u64) * 2
    }else{
        1
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


    let i :u64 = 0;
    while(i < 10 ){
        i = i + 1;
        if (i == 9 ) break;
        if (i == 5 ) continue;
    };

    loop{
        i = i + 1;
        if (i == 9 ) break;
        if (i == 5 ) continue;
    };

    
    /*
    * Abort & Assert：
    *  abort 通常會搭配條件式。
    *  if (<不期望的condition>) abort <Error Code>;
    * 
    * assert! 則可以把上面的寫法整合成一句，類似 Solidity 的 require
    * assert!(<期望的condition>, <Error Code>)
    * TODO: Example
    **/ 

    
    // abort
    if (num1 == 10 ) {
        abort ENumTooLarge // u64
    };

    // assert!
    assert!(num1 != 10, ENumTooLarge);


}
