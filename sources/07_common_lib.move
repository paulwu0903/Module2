module module_2::sui_framework_sample;

// std: https://github.com/MystenLabs/sui/tree/main/crates/sui-framework/packages/move-stdlib/sources
// sui: https://github.com/MystenLabs/sui/tree/main/crates/sui-framework/packages/sui-framework/sources


// Exercise
// 1. 寫一個合約，當你執行其中一個 function 時，會產生 10 個 Objects，這 10 個 objects 裡面都只有 u64 的 field，且數字按序 1 ~ 10。

// 2.寫一個學校合約(school.move)，再寫一個學生合約(student.move)，再寫一個老師合約(teacher.move)。 期望在鏈上發生以下行為：
// - 產生 1位學生、1位老師
// - 老師給兩位學生打分數，分數介於 0 ~ 100 之間
// - 老師和學生一起進入學校 (一個 function: 老師和學生當作 input，產出 school object，也就是 schoole object 包含 student object 與 teacher object)