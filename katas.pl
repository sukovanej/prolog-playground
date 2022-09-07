% =======================================================================
% Multiplication table
% https://www.codewars.com/kata/5a2fd38b55519ed98f0000ce/train/prolog
% =======================================================================

multi_table(Number, Result) :-
  multi_table(Number, 1, Result).

multi_table(Number, 10, Result) :-
  LineResult is Number * 10,
  format_line(Number, 10, LineResult, Result).

multi_table(Number, LineNumber, Result) :-
  LineResult is Number * LineNumber,
  NextLineNumber is LineNumber + 1,
  format_line_ln(Number, LineNumber, LineResult, CurrentResult),
  multi_table(Number, NextLineNumber, Rest),
  string_concat(CurrentResult, Rest, Result).

format_line(A, B, C, Result) :-
  string_concat(B, " * ", R1),
  string_concat(R1, A, R2),
  string_concat(R2, " = ", R3),
  string_concat(R3, C, Result).

format_line_ln(A, B, C, Result) :- 
  format_line(A, B, C, Line),
  string_concat(Line, "\n", Result).

% =======================================================================
% Summing a number's digits
% https://www.codewars.com/kata/52f3149496de55aded000410/train/prolog
% =======================================================================

% Store the result inside the 2nd argument
sum_digits(Number, Result) :-
  N is abs(Number), sum_positive_digits(N, Result).

sum_positive_digits(N, Result) :-
  number_string(N, Nstr),
  string_chars(Nstr, Nchars),
  maplist([Char, Num] >> atom_number(Char, Num), Nchars, Nnums),
  sumlist(Nnums, Result).

sumlist([Result], Result).
sumlist([A|B], Result) :- sumlist(B, R), Result is A + R.

% =======================================================================
% Beginner Series #3 Sum of Numbers
% https://www.codewars.com/kata/55f2b110f61eb01779000053/train/prolog
% =======================================================================

get_sum(A, A, A).
get_sum(A, B, Result) :- A > B, get_sum(B, A, Result).
get_sum(A, B, Result) :- A2 is A + 1, get_sum(A2, B, R), Result is A + R.

% =======================================================================
% Drying Potatoes
% https://www.codewars.com/kata/58ce8725c835848ad6000007/train/prolog
% =======================================================================