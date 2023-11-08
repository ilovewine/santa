:- use_module(participants).

santa(Result) :-
    setof([Person, Email], participant(Person, Email), Set),
    permutation(Set, Perm),
    nth1(1, Perm, First),
    append(Perm, [First], Result).