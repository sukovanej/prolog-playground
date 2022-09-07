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

% =======================================================================
% Beginner Series #3 Sum of Numbers
% https://www.codewars.com/kata/55f2b110f61eb01779000053/train/prolog
% =======================================================================

get_sum(A, A, A).
get_sum(A, B, Result) :- A > B, get_sum(B, A, Result).
get_sum(A, B, Result) :- A2 is A + 1, get_sum(A2, B, R), Result is A + R.

% =======================================================================
% Evens times last
% https://www.codewars.com/kata/5a1a9e5032b8b98477000004/train/prolog
% =======================================================================

last([A], A).
last([_|B], R) :- last(B, R).

even_last([], 0).
even_last(Numbers, Result) :-
  length(Numbers, NumbersLength),
  NumbersCap is NumbersLength - 1,
  numlist(0, NumbersCap, NumbersIndices),
  maplist([A, I, L] >> (I mod 2 =:= 0, L is A; L is 0), Numbers, NumbersIndices, NumbersWithoutOdds),
  sumlist(NumbersWithoutOdds, SubResult),
  last(Numbers, LastItem),
  Result is SubResult * LastItem.

% =======================================================================
% Sum - Square Even, Root Odd
% https://www.codewars.com/kata/5a4b16435f08299c7000274f/train/prolog
% =======================================================================

sum_square_even_root_odd(Nums, Result) :-
  maplist(square_or_root, Nums, AppliedNums),
  sumlist(AppliedNums, UnroundedResult),
  round_to(UnroundedResult, 2, Result).
  
square_or_root(Num, Result) :-
  Num mod 2 =:= 0, Result is Num ** 2;
  Result is sqrt(Num).
  
round_to(A, P, Result) :-
  A1 is A * 10 ** P,
  round(A1, A2),
  Result is A2 / 10 ** P.

% =======================================================================
% Array Leaders (Array Series #3)
% https://www.codewars.com/kata/5a651865fd56cb55760000e0/train/prolog
% =======================================================================

array_leaders([A], R) :-
  A > 0, R = [A]; R = [].

array_leaders([A|Rest], Result) :-
  get_leader(A, Rest, SubResult),
  !,
  array_leaders(Rest, NextResult),
  !,
  append(SubResult, NextResult, Result).
  
get_leader(A, Rest, Result) :-
  (sumlist(Rest, Sum), A > Sum, Result = [A]); Result = [].