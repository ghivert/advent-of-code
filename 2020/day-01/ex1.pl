read_file_lines(Stream, []) :- at_end_of_stream(Stream).
read_file_lines(Stream, [X | L]) :-
  \+ at_end_of_stream(Stream),
  read_line_to_string(Stream, Y),
  number_string(X, Y),
  read_file_lines(Stream, L).

read_file(Lines) :-
  open('input1.txt', read, Str),
  read_file_lines(Str, Lines),
  close(Str).

is_2020(Found, First, Second) :- First + Second =:= 2020, Found = Second.

find_2020_composite(Found, _First, []) :- Found = -1.
find_2020_composite(Found, First, [Second | Rest]) :-
  is_2020(Found, First, Second);
  find_2020_composite(Found, First, Rest).

find_multiplied_result(Result, []) :- Result = -1.
find_multiplied_result(Result, [First | Rest]) :-
  find_2020_composite(Found, First, Rest),
  Found > -1,
  Result is Found * First;
  find_multiplied_result(Result, Rest).

main :-
  read_file(Numbers),
  find_multiplied_result(Result, Numbers),
  print(Result), nl.
