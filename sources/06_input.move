module module_2::input;

/*
 * [Pass-by-value & Pass-by-Reference]
 * Pass-by-Value: 
 * 1. 此種代入方式的類型若無 drop ability，則最後需要對該標的進行處理表示
 * 2. 可讀、可寫、處理
 * Pass-by-Reference
 * - immutable: 
 *     1. 代入參數時，在類型前加上 "&"。
 *     2. 只可讀
 * - mutable: 
 *     1. 代入參數時，在類型前加上 "&mut"。
 *     2. 可讀、可寫
**/
