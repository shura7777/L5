{Time, _Result} = timer:tc(fun() -> maps:put(key, value, Map) end),
io:format("Час виконання: ~p мікросекунд~n", [Time]).
