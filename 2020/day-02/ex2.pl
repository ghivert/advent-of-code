read_file_lines(Stream, []) :- at_end_of_stream(Stream).
read_file_lines(Stream, [X | L]) :-
  \+ at_end_of_stream(Stream),
  read_line_to_string(Stream, X),
  read_file_lines(Stream, L).

read_file(Lines) :-
  open('input1.txt', read, Str),
  read_file_lines(Str, Lines),
  close(Str).

get_indexes([Start, End], Result) :-
  number_string(StartNumber, Start),
  number_string(EndNumber, End),
  Result = (StartNumber, EndNumber).

get_separator(Separator, Result) :-
  split_string(Separator, ":", "", Res),
  nth0(0, Res, Result).

keep_indexes_and_sep(Line, Result) :-
  split_string(Line, " ", "", RawResult),
  [Indexes, RawSeparator, Password] = RawResult,
  split_string(Indexes, "-", "", AllIndexes),
  get_indexes(AllIndexes, NumberIndexes),
  get_separator(RawSeparator, Separator),
  Result = idx_sep_pass(NumberIndexes, Separator, Password).

is_one_of_two(MinChar, MaxChar, Sep) :-
  MinChar =@=  Sep, MaxChar \=@= Sep;
  MinChar \=@= Sep, MaxChar =@=  Sep.

folder(idx_sep_pass((Min, Max), Sep, Pass), PrevAcc, Acc) :-
  N is Min - 1, M is Max - 1,
  sub_string(Pass, N, 1, _, MinChar),
  sub_string(Pass, M, 1, _, MaxChar),
  is_one_of_two(MinChar, MaxChar, Sep),
  Acc is PrevAcc + 1;
  Acc is PrevAcc.

main :-
  read_file(Lines),
  maplist(keep_indexes_and_sep, Lines, Rss),
  foldl(folder, Rss, 0, Res),
  write(Res), nl.
