-module(fib2).
-export([fibonnaci/1]).

fibonnaci(0) -> 0;
fibonnaci(1) -> 1;
fibonnaci(N) ->
    Pid = self(),

    spawn(fun() ->
        Pid ! fibonnaci(N - 1)
    end),

    spawn(fun() ->
        Pid ! fibonnaci(N - 2)
    end),
    
    receive
        F1 ->
            receive
                F2 ->
                    F1 + F2
            end
    end.
