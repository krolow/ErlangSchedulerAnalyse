-module(fib).
-export([fibonnaci/1, calculate_fibonnaci/2]).

record_result() ->
    receive
        X -> X
    end.

calculate_fibonnaci(0, Parent) ->
    Parent ! 0;

calculate_fibonnaci(1, Parent) ->
    Parent ! 1;

calculate_fibonnaci(Number, Parent) ->
    spawn(fib, calculate_fibonnaci, [Number - 1, self()]),
    spawn(fib, calculate_fibonnaci, [Number - 2, self()]),

    Parent! (record_result() + record_result()).

fibonnaci(N) ->
    _ = calculate_fibonnaci(N, self()),
    receive
        X -> X
    end.
