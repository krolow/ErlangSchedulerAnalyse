-module(fib_n_processes).
-compile([export_all]).

fibonnaci(0, _) -> 0;

fibonnaci(1, _) -> 1;

fibonnaci(Number, Processes) when Number >= Processes ->
    Pid = self(),
    
    spawn(
        fun() ->
            Pid ! fibonnaci(Number - 1, Processes)
        end
    ),
    
    spawn(
        fun() ->
            Pid ! fibonnaci(Number - 2, Processes)
        end
    ),
    
    receive
        F1 ->
            receive
            F2 ->
                F1 + F2
            end
    end;

fibonnaci(Number, Processes) when Number < Processes ->
    Pid = self(),
    
    spawn(fun() ->
        Pid ! fib_recursive:fibonnaci(Number - 1)
    end),
    
    spawn(fun() ->
        Pid ! fib_recursive:fibonnaci(Number - 2)
    end),
    
    receive
    F1 ->
        receive
        F2 ->
            F1 + F2
        end
    end.

fibonnaci_5_processes(Number) ->
    fibonnaci(Number, Number - 4).

fibonnaci_6_processes(Number) ->
    fibonnaci(Number, Number - 5).

fibonnaci_7_processes(Number) ->
    fibonnaci(Number, Number - 6).

fibonnaci_8_processes(Number) ->
    fibonnaci(Number, Number - 7).

fibonnaci_9_processes(Number) ->
    fibonnaci(Number, Number - 8).

fibonnaci_10_processes(Number) ->
    fibonnaci(Number, Number - 9).

fibonnaci_11_processes(Number) ->
    fibonnaci(Number, Number - 10).
