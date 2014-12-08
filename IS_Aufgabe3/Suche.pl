/*
%% Manual: %%
TEIL 1:
   Tiefensuche:
   ?- solve(depth).

   Breitensche:
   ?- solve(breadth).

TEIL 2:
   F‹R HEURISTIKEN: entweder 127-130 oder 134-139 ein bzw AUSkommentieren in "Suche_Modul_Planung.pl"

   A-Algorithmus:
   111-114 AUSkommentieren in "Suche_Modul_Planung.pl"
   ?- solve(informed).

   gierige Bestensuche:
   103-107 AUSkommentieren in "Suche_Modul_Planung.pl"
   ?- solve(informed).

   optimistisches Bergsteigen:
   ?- solve(hill_climbing).

   Bergsteigen mit Backtracking:
   ?- solve(hill_climbing_bt).

*/

:- consult('Suche_Modul_Allgemein.pl').


:- consult('Suche_Modul_Informierte_Suche.pl').



%%% Spezieller Teil: Wassergef‰ﬂe
%:- consult('Suche_Modul_Wasser.pl').



%%% Spezieller Teil: Planung
:- consult('Suche_Modul_Planung.pl').


