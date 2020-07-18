# PrisonersPuzzle
Solver for the generalized prisoners chessboard problem

Written as a solution to Reddit Daily Programmer challenge #385 https://www.reddit.com/r/dailyprogrammer/comments/hrujc5/20200715_challenge_385_intermediate_the_almost/.

This program solves a generalized version of the problem for which the maths behind it are explained in section (d) of the following writeup: http://olivernash.org/2009/10/31/yet-another-prisoner-puzzle/index.html. It takes two arguments on the command line:

- *a* = size of the dice (>= 2)

- *d* = number of dimensions (>= 0)

Those two arguments will determine the size of the board (*n* = *a*^*d*). The dice value in each square of the board and the magic square are generated randomly. Calculation are done on vectors of size *d* using modulo *a* arithmetic.
