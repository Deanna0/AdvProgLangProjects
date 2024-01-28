% Base case: Reversing an empty list results in an empty list.
reverse_list([], []).

% Recursive rule: To reverse a non-empty list, append the first element to the reversed tail.
reverse_list([Head|Tail], Reversed) :-
    reverse_list(Tail, ReversedTail),
    append(ReversedTail, [Head], Reversed).

main :- read(Input),
    reverse_list(Input, Result),
    write(Result).