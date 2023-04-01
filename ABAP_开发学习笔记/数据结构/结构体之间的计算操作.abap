
*结构体之间的计算操作。
*add-corresponding
*subtract-corresponding
*multiply-corresponding
*divide-corresponding

*multiply-corresponding是进行两个结构体之间的乘法运算，常用于计算比重。
*只能计算两个结构中相同的列


types:begin of gs_rate,
         peng type f value '0.8',
         zhou type f value '1.0',
         stu  type f value '3.4',
      end of gs_rate.

types:begin of gs_result,
         peng type f value '95',
         zhou type f value '70',
         stm  type f value '73',
      end of gs_result.


multiply-corresponding gs_result by gs_rate.       "此处之后只能输出gs_result。

write:'test result','peng',gs_result-peng,gs_result-zhou,gs_result-stm.