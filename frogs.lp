#include <incmode>.

#program base.

frog(1..n).
holds(F, 0) :- init(F).
    
#program base.
init(on(frog(X), X)) :- frog(X), X<=n/2.
init(on(frog(Y), Y+1)) :- frog(Y), Y>n/2.
init(on(none, n/2+1)).

goal(on(frog(X), n/2+X+1)) :- frog(X), X <= n/2.
goal(on(frog(X), X-n/2)) :- frog(X), X > n/2.
goal(on(none, n/2+1)).


#program step(t).

{move(frog(X), Y, Z, t): holds(on(frog(X), Y), t-1), holds(on(none, Z), t-1)} = 1.

:- move(frog(X), Y, Z, t), Z-Y>2.
:- move(frog(X), Y, Z, t), Y-Z>2.
:- move(frog(X), Y, Z, t), X<=n/2, Z<Y.
:- move(frog(X), Y, Z, t), X>n/2, Z>Y.
    
moved(X, t) :- move(X, Y, Z, t).
holds(on(X,Z), t):- move(X,Y,Z, t).
holds(on(none, Y), t) :- move(X, Y, Z, t).
holds(on(X,Z), t) :- holds(on(X,Z), t-1), not moved(X, t), X != none.

#program check(t).
:- query(t), goal(F), not holds(F,t).

#show moved/2.


