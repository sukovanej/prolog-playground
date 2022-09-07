% https://www.codewars.com/kata/54d512e62a5e54c96200019e/train/prolog

prime_factors(N, R) :- prime_factors(N, 2, R).
prime_factors(N, D, R) :- R is 0.