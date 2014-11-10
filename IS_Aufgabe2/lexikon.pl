:- load_files('../IS_Aufgabe1/Teil1/stammbaum.pl').

lex(wer, ip, _).
lex(ist, v, sg).
lex(sind, v, pl).
lex(der, det, sg).
lex(die, det, sg).
lex(die, det, pl).
lex(das, det, sg).

%----------

lex(eltern, n, pl).
lex(vater, n, sg).
lex(mutter, n, sg).
lex(eltern, n, sg).

lex(geschwister, n, pl).
lex(halbgeschwister, n, pl).

lex(schwestern, n, pl).   %= weibliche Geschwister einer Frau
lex(schwester, n, sg).   %=ist jemand die Schwester von
lex(brueder, n, pl).         %= männliche Geschwister eines Mannes
lex(bruder, n, sg).      %= ist jemand der Bruder von

lex(grossvater, n, sg).
lex(grossvater, n, pl).

lex(grossmutter, n, sg).
lex(grossmutter, n, pl).

lex(cousin, n, sg).
lex(cousine, n, sg).
lex(cousin, n, pl).

lex(nichte, n, sg).
lex(neffe, n, sg).

lex(von, prae, _).
lex(mit, prae, _).


lex(PN, pn, _) :- mann(PN).
lex(PN, pn, _) :- frau(PN).