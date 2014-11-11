:- load_files(['../IS_Aufgabe1/Teil1/stammbaum.pl', 'lexikon.pl']).

bruder(X,Y) :- geschwister(X,Y).
schwester(X,Y) :- geschwister(X,Y).
neffe(X,Y) :- nichte(X,Y).
cousine(X,Y) :- cousin(X,Y).

% Entscheidungsfrage:
% "Ist Homer der Vater von Bart?"
s(Sem)  --> vp(SemVP, VP, Numerus),      %ist homer
            np(SemNP, NP, Numerus),      %der Vater
            pp(SemPP, PP, Numerus),      %von bart
            {
              %Nomen
              arg(2,VP,VP1), arg(1,VP1,VP2), arg(1,VP2,N), %Homer

              %Artikel
              arg(1,NP,A0), arg(1,A0,Artikel), %der

              %Praeposition
              arg(1,PP,P0), arg(1,P0,Praeposition), %von
              

              call(SemNP, N, Erg),


              SemPP = Erg ->
                   Antwortliste=['JA! ',N,' ',SemVP,' ',Artikel,' ',SemNP,' ',Praeposition,' ',SemPP,'!'],
                   with_output_to(atom(Antwortsatz), maplist(write, Antwortliste)),
                   writeln(Antwortsatz),
                   Sem=true
                   ;
                   writeln('Nein ganz falsch...'),
                   Sem=false
             }.
             
             
% Ergšnzungsfrage:
% "Wer ist der Vater von Homer?"
s(Sem)  --> ip(_SemIP, Numerus),       %wer
            vp(SemVP, VP, Numerus),    %ist der vater
            pp(SemPP, PP, Numerus),    %von homer
            {
              %Nomen
              arg(2,VP,VP1), arg(2,VP1,VP2), arg(1,VP2,Beziehung), %Vater

              %Artikel
              arg(1,VP1,VPA),arg(1,VPA,Artikel),
              
              %Praeposition
              arg(1,PP,PP1), arg(1,PP1,Praeposition),

              
              call(Beziehung, Ergebnis, SemPP),
              Sem = Ergebnis,

              Antwortliste=[Ergebnis,' ',SemVP,' ',Artikel,' ',Beziehung,' ',Praeposition,' ',SemPP,'!'],
              with_output_to(atom(Antwortsatz), maplist(write, Antwortliste)),
              write(Antwortsatz),nl
            }.


%Eine Nominalphrase kann sein:
  %Eigenname
  np(SemPN,np(N),Numerus)              --> pn(SemPN, N, Numerus).
  
  %Artikel, Nomen
  np(SemN,np(Det,N),Numerus)          --> det(Det, Numerus), n(SemN, N, Numerus).

  %Artikel, Nomen, Pršpositionalphrase
  np(SemN,np(Det,N,PP),Numerus)       --> det(Det, Numerus), n(SemN, N, Numerus), pp(SemN, PP, Numerus).



%Eine Pršpositionalphrase kann sein:
  %Pršposition, Nominalphrase
  pp(SemPN, pp(PRAE, NP), Numerus)    --> prae(PRAE, Numerus), np(SemPN, NP, Numerus).

  
  
%Eine Verbalphrase kann sein:
  %Verb
  vp(SemV, vp(V), Numerus)            --> v(SemV, V, Numerus).
  
  %Verb, Nominalphrase
  vp(SemV, vp(V,NP),Numerus)          --> v(SemV, V, Numerus), np(_SemNP, NP, Numerus).





%Interrogativpronomen
  ip(ip(IP), Numerus)                 --> [IP], {lex(IP, ip, Numerus)}.

%Verb
  v(V, v(V), Numerus)                 --> [V], {lex(V, v, Numerus)}.

%Artikel
  det(det(Det), Numerus)              --> [Det], {lex(Det, det, Numerus)}.
  
%Nomen
  n(N, n(N), Numerus)                 --> [N], {lex(N, n, Numerus)}.

%Pršposition
  prae(prae(Prae), Numerus)           --> [Prae], {lex(Prae, prae, Numerus)}.

%Eigenname
  pn(PN, pn(PN), Numerus)             --> [PN], {lex(PN, pn, Numerus)}.



