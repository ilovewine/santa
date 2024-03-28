:- use_module(participants).
:- use_module(library(lists)).
:- (\+(pack_info(smtp)) -> pack_install(smtp); true), use_module(library(smtp)).

santa(Result) :-
    setof([Person, Email], participant(Person, Email), Set),
    permutation(Set, Perm),
    nth1(1, Perm, First),
    append(Perm, [First], Result).

send_message(Out) :-
    format(Out, 'Hi Alice,\n\n', []),
    format(Out, 'Want to go out tonight?\n\n', []),
    format(Out, '\tCheers, Bob\n', []).

test :-
    From = 'kazdyjestmikolajem@gmail.com',
    From1 = 'mateusz.piatkowski666@gmail.com',
    Pass = dobryfront,
    writeln(From1-Pass),
    smtp_send_mail('mateusz.piatkowski666@gmail.com',
                  send_message,
                  [ 
                    subject('Tonight'),
                    from(From1),
                    smtp('smtp.gmail.com'),
                    security(starttls),
                    content_type(text/html),
                    header('MIME-Version'('1.0')),
                    header('Content-Type'('text/html; charset=utf-8')),
                    auth_method(login),
                    auth(From1-Pass)
                  ]).