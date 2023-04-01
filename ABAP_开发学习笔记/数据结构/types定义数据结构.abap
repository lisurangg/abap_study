
types: begin of gs_stu,
       name type c length 5,
       sex  type c length 1,
       age  type i,
       id   type c length 12,
    end of gs_stu.


    data mytable type standard table of gs_stu with header line.


    mytable-name = '李强'.
    mytable-sex  = '男'.
    mytable-age  = '21'.
    mytable-id   = '2041'.


    append mytable.


    write: / mytable-name.
    write: / mytable-sex.
    write: / mytable-age.
    write: / mytable-id.