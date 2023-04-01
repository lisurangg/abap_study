


data: tomorrow   type d.
data: next_hour  type t.


data(today) = sy-datlo.
data(now)  = sy-timlo.

tomorrow  = today + 1.
next_hour = ( now + 3600 ) / 3600 * 3600.

write:tomorrow.
write:next_hour.