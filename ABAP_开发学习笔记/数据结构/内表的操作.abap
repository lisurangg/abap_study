types:begin of initial_type,                                                 "定义一个initial_type结构。
      group       type c length 1,
      number      type i,
      descrioyion type string, 
  end of initial_type.

data i_wa type initial_type.                                                  "这个暂时不懂
data: itab_data_type type standard table of initial_type.                      "根据initial_type结构定义一个标准表‘itab_data_type’。
data fill_itab type table of initial_type.                                     "根据initial_type结构定义一个表fill_itab。


i_wa-group       = 'A' .                                                       
i_wa-number      = '10'.
i_wa-descrioyion = 'A-2'. 
append i_wa to itab_data_type.                                                 "将数据i_wa加入到表itab_data_type。
i_wa-group       = 'B'.
i_wa-number      = '5'.
i_wa-descrioyion = 'B'.
append i_wa to itab_data_type.                                                  
i_wa-group       = 'A'.
i_wa-number      = '6'.
i_wa-descrioyion = 'A-1'.
append i_wa to itab_data_type.
i_wa-group       = 'c'.
i_wa-number      = '22'.
i_wa-descrioyion = 'C-1'.
append i_wa to itab_data_type.
i_wa-group       = 'A'.
i_wa-number      = '13'.
i_wa-descrioyion = 'A-3'.
append i_wa to itab_data_type.
i_wa-group       = 'C'.
i_wa-number      = '200'.
i_wa-descrioyion = 'C-2'.
append i_wa to itab_data_type.


itab_data_type = corresponding #( fill_itab ).                               "将内表数据复制到内表fill_itab

append value #( group = 'a' number = '19' descrioyion = 'A-4' ) to fill_itab.   "在内表fill_itab中插入一行数据。


sort fill_itab by group ascending number descending.                             "将内表按照group进行升序排列，按照number进行降序排列。

data(temp_itab) = fill_itab.                                                     "根据内表fill_itab定义一个内表temo_itab。
read TABLE temp_itab with key number = '6' into data(temp_ita1).                 "读取内表temp_itab中number=6的数据到temp_ita1.
write:temp_ita1-group,temp_ita1-number,temp_ita1-descrioyion.