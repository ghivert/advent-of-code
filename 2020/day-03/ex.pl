read_file_lines(Stream, []) :- at_end_of_stream(Stream).
read_file_lines(Stream, [X | L]) :-
  \+ at_end_of_stream(Stream),
  read_line_to_string(Stream, X),
  read_file_lines(Stream, L).

read_file(Lines) :-
  open('input.txt', read, Str),
  read_file_lines(Str, Lines),
  close(Str).

increment_acc(Change, NewPos, Count, Acc) :-
  NewCount is Count + 1,
  Acc = folder_acc(Change, NewPos, NewCount).

folder(Line, folder_acc(Change, Position, Count), Acc) :-
  string_length(Line, StrLen),
  NewPos is (Position + Change) mod StrLen,
  sub_string(Line, NewPos, 1, _, Char),
  (Char = "#" ->
    increment_acc(Change, NewPos, Count, Acc)
  ; Acc = folder_acc(Change, NewPos, Count)
  ).

is_pair(Nth, List, Elem) :- nth0(N, List, Elem), N mod Nth =:= 0.
keep_nth(Nth, List, Res) :- include(is_pair(Nth, List), List, Res).

compute_trees(Move, Lines, Count) :-
  [_ | Rest] = Lines,
  foldl(folder, Rest, folder_acc(Move, 0, 0), Res),
  folder_acc(_, _, Count) = Res.

main :-
  read_file(Lines),
  keep_nth(2, Lines, OneOfTwo),
  compute_trees(1, Lines, Count1),
  compute_trees(3, Lines, Count3), % This is also Exercise 1.
  compute_trees(5, Lines, Count5),
  compute_trees(7, Lines, Count7),
  compute_trees(1, OneOfTwo, Count9),
  Res is Count1 * Count3 * Count5 * Count7 * Count9,
  write(Res), nl.
