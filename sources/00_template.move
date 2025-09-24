/*
 * Package - Modules - Structs 
 *                   - Functions --- Entry Functions: 可以直接被使用（有限制）
 *                   - Constants   - Public Functions: 所有合約都可以使用
 *                   - Imports     - Public(Package) Functions：只有相同 Package 的合約可以使用
 *                   - Errors      - Private Functions：只有相同 Module 的 Functions 可以使用
 *                                 - Init Function: 部署合約時會直接執行的 Function (只會執行一次)
**/

/* 假設有一個 Package: hello , modules: a, b, c, d, 
 * a - functions: fna1, fna2, fna3
 * a - structs: A1, A2, A3
 * b - functions: fnb1, fnb2, fnb3
 * b - structs : B1, B2, B3
 * c - functions: fnc1, fnc2, fnc3
 * c - structs: C1, C2, C3
 * d - functions: fnd1, fnd2, fnd3
 * d - structs: D1, D2, D3
 *
 * 用 "::"當作往下定位的符號
 * Ex：
 * 1. C3: 
 * 2: fna3: 
 * 3. D2: 
 * 4. a: hello::a
**/
module module_2::template;
// === Imports ===


// === Constants ===


// === Errors ===


// === Structs ===

// === Init Functions ===


// === Entry Functions ===


// === Public Functions ===


// === Public (Pacakge) Functions ===


// === Private Functions === 

