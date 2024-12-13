-module(my_cache).
-export([create/1, insert/3, insert/4, lookup/2, delete_obsolete/1]).

create(TableName) ->
    ets:new(TableName, [named_table, public, set]),
    ok.

insert(TableName, Key, Value) ->
    ets:insert(TableName, {Key, Value, undefined}),
    ok.

insert(TableName, Key, Value, Timeout) ->
    ExpiryTime = calendar:now_to_universal_time(calendar:now_to_seconds() + Timeout),
    ets:insert(TableName, {Key, Value, ExpiryTime}),
    ok.

lookup(TableName, Key) ->
    case ets:lookup(TableName, Key) of
        [{Key, Value, undefined}] -> Value;
        [{Key, Value, ExpiryTime}] ->
            CurrentTime = calendar:now_to_universal_time(calendar:now_to_seconds()),
            case CurrentTime > ExpiryTime of
                true -> undefined;
                false -> Value
            end;
        [] -> undefined
    end.

delete_obsolete(TableName) ->
    CurrentTime = calendar:now_to_universal_time(calendar:now_to_seconds()),
    ets:select_delete(TableName, [{{'$1', '_', '$2'}, [{'=/=', '$2', undefined}, {'<', '$2', CurrentTime}], ['$_']}]),
    ok.
