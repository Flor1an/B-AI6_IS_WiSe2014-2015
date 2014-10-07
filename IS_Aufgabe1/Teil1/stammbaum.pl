%männliche Seite Simpsons
mann(orville).
mann(ape).
mann(homer).
mann(herb).
mann(bart).

%männliche Seite Bouvier
mann(clancy).

%weibliche Seite Simpsons
frau(yuma).
frau(edwina).
frau(mona).
frau(abbie).
frau(na).

%weibliche Seite Bouvier
frau(jaqueline).
frau(marge).
frau(patty).
frau(selma).
frau(ling).
frau(lisa).
frau(meggi).


%Ehen
ver(orville,yuma).
ver(ape,edwina).
ver(ape,na).
ver(ape,mona).
ver(clancy,jaqueline).
ver(homer,marge).
verheiratet(M,F):- ver(F,M);ver(M,F).



%S
vater(orville,ape).
vater(ape,homer).
vater(ape,abbie).
vater(ape,herb).
vater(homer,bart).
vater(homer,lisa).
vater(homer,meggi).
vater(clancy,marge).
vater(clancy,patty).
vater(clancy,selma).


%S
mutter(yuma,ape).
mutter(edwina,abbie).
mutter(na,herb).
mutter(mona,homer).
mutter(jaqueline,marge).
mutter(jaqueline,patty).
mutter(jaqueline,selma).
mutter(selma,ling).
mutter(marge,bart).
mutter(marge,lisa).
mutter(marge,meggi).

eltern(Elternteil,Kind) :-
  mutter(Elternteil,Kind);vater(Elternteil,Kind).

geschwister(X,Y) :-
  mutter(Mutter1,X),mutter(Mutter2,Y),
  vater(Vater1,X),vater(Vater2,Y),
  
  (Mutter1 = Mutter2, Vater1=Vater2, X \= Y).

halbgeschwister(X, Y) :-
  vater(Vater1,X), vater(Vater2,Y),
  mutter(Mutter1,X), mutter(Mutter2,Y),

  ((Vater1 = Vater2, Mutter1 \= Mutter2);
  (Vater1 \= Vater2, Mutter1 = Mutter2)).

  
schwester(X,Y) :-
  frau(X),
  frau(Y),
  geschwister(X,Y).
  
bruder(X,Y) :-
  mann(X),
  mann(Y),
  geschwister(X,Y).
  
grossvater(GVater, Enkel) :-
  eltern(Eltern, Enkel),
  vater(GVater, Eltern).
  
grossmutter(GMutter, Enkel) :-
  eltern(Eltern, Enkel),
  mutter(GMutter, Eltern).
  
cousin(X, Person) :-
  eltern(Elternteil, Y),
  geschwister(GeschwisterVonElternteil, Elternteil),
  eltern(GeschwisterVonElternteil, X),
  X \= Y.
  
nichte(X, Y) :-
  geschwister(G1, X),
  eltern(G1, Y).