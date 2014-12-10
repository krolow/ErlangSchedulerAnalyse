-module(fib_recursive).
-export([fibonnaci/1]).

fibonnaci(0) -> 0;
fibonnaci(1) -> 1;

fibonnaci(Number) ->
    fibonnaci(Number - 1) + fibonnaci(Number - 2).
