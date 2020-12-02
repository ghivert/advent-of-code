read_file_lines(Stream, []) :- at_end_of_stream(Stream).
read_file_lines(Stream, [X | L]) :-
  \+ at_end_of_stream(Stream),
  read_line_to_string(Stream, Y),
  number_string(X, Y),
  read_file_lines(Stream, L).

is_2020(Found, First, Second, Third) :-
  First + Second + Third =:= 2020,
  Found = Third.

find_2020_composite(Found, _First, _Second, []) :- Found = -1.
find_2020_composite(Found, First, Second, [Third | Rest]) :-
  is_2020(Found, First, Second, Third);
  find_2020_composite(Found, First, Second, Rest).

find_2020_second_composite(Found, _, []) :- Found = -1.
find_2020_second_composite(Found1, Found2, First, [Second | Rest]) :-
  find_2020_composite(Found, First, Second, Rest),
  Found > -1,
  Found1 = Second, Found2 = Found;
  find_2020_second_composite(Found1, Found2, First, Rest).

find_multiplied_result(Result, []) :- Result = -1.
find_multiplied_result(Result, [First | Rest]) :-
  find_2020_second_composite(Found1, Found2, First, Rest),
  Found1 > -1,
  Result is Found1 * Found2 * First, !;
  find_multiplied_result(Result, Rest).

read_file(Lines) :-
  open('input1.txt', read, Str),
  read_file_lines(Str, Lines),
  close(Str).

main :-
  read_file(Numbers),
  find_multiplied_result(Result, Numbers),
  print(Result), nl.
