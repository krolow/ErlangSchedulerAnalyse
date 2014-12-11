-module(fib_four_processes).
-export([fibonnaci/1]).

fibonnaci(0) -> 0;

fibonnaci(1) -> 1;

fibonnaci(Number) ->
    Pid = self(),
    spawn(
        fun() ->
            Pid ! fib_recursive:fibonnaci(Number - 1)
        end
    ),

    spawn(
        fun() ->
          Pid ! fib_recursive:fibonnaci(Number - 2)
      end
    ),
    
    receive
        F1 ->
            receive
            F2 ->
                F1 + F2
            end
    end.
