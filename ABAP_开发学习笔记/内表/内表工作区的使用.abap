

types:begin of initial_type,
        group       type c length 1,
        number      type i,
        descrioyion type c length 3,
      end of initial_type.
data:initial_itab type standard table of initial_type,                "用data定义与此处的types定义内表有何不同?用原有的types：后续用append插入时报错。
     wa_initial type initial_type.                                     "定义wa_initial为initial_itab的工作区


wa_initial-group       = 'A' .
wa_initial-number      = '10'.                                        
wa_initial-descrioyion = 'A-2'.
append wa_initial to initial_itab.
clear wa_initial.

wa_initial-group       = 'B'.
wa_initial-number      = '5'.
wa_initial-descrioyion = 'B'.
append wa_initial to initial_itab.
clear wa_initial.

wa_initial-group       = 'A'.
wa_initial-number      = '6'.
wa_initial-descrioyion = 'A-1'.
append wa_initial to initial_itab.
clear wa_initial.

wa_initial-group       = 'c'.
wa_initial-number      = '22'.
wa_initial-descrioyion = 'C-1'.
append wa_initial to initial_itab.
clear wa_initial.

wa_initial-group       = 'A'.
wa_initial-number      = '13'.
wa_initial-descrioyion = 'A-3'.
append wa_initial to initial_itab.
clear wa_initial.

wa_initial-group       = 'C'.
wa_initial-number      = '200'.
wa_initial-descrioyion = 'C-2'.
append wa_initial to initial_itab.
clear wa_initial.


data:fill_itab type standard table of initial_type,                                  "根据initial_type定义内表fill_itab.
     wa_fill type initial_type.                                                      "根据initial_type定义内表fill_itab的工作区。
                                                                                    " 如果将上面顺序交换，wa_fill一样为fill_itab的工作区。 
fill_itab = corresponding #( initial_itab ).
append value #( group = 'a' number = '19' descrioyion = 'A-4' ) to fill_itab.
sort fill_itab by group ascending.

clear wa_fill.
loop at fill_itab into wa_fill.
  write:wa_fill-group,wa_fill-number,wa_fill-descrioyion,/.
endloop.
