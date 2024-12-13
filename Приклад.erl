1> my_cache:create(my_table).
ok
2> my_cache:insert(my_table, key1, value1).
ok
3> my_cache:insert(my_table, key2, value2, 10).
ok
4> my_cache:lookup(my_table, key1).
value1
5> timer:sleep(11000).
6> my_cache:lookup(my_table, key2).
undefined
7> my_cache:delete_obsolete(my_table).
ok
