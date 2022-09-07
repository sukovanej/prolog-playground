/*
Our simple automaton, accepts the language of A, defined as {0, 1} and 
should have three states: q1, q2, and q3. Here is the description of the states:

q1 is our start state, we begin reading commands from here
q2 is our accept state, we return true if this is our last state
And the transitions:

q1 moves to q2 when given a 1, and stays at q1 when given a 0
q2 moves to q3 when given a 0, and stays at q2 when given a 1
q3 moves to q2 when given a 0 or 1
*/

read_commands([], q2).

read_commands([Command|Rest], State) :- 
  transition(State, NewState, Command),
  read_commands(Rest, NewState).

read_commands(Commands) :-
  string_chars(Commands, CommandsArr),
  read_commands(CommandsArr, q1).

transition(q1, q2, '1').
transition(q1, q1, '0').
transition(q2, q3, '0').
transition(q2, q2, '1').
transition(q3, q2, _).