:- load_files(['../IS_Aufgabe1/Teil1/stammbaum.pl', 'lexikon.pl']).

bruder(X,Y) :- geschwister(X,Y).
schwester(X,Y) :- geschwister(X,Y).
neffe(X,Y) :- nichte(X,Y).
cousine(X,Y) :- cousin(X,Y).

% Entscheidungsfrage:
% "Ist Homer der Vater von Bart?"
s(Sem)  --> vp(_SemVP, VP, Numerus),      %ist
            np(_SemNP1, NP1, Numerus),    %homer
            np(SemNP, NP2, Numerus),      %der Vater von bart

            {
            writeln(VP),
            writeln(NP1),
            writeln(NP2),

              arg(1,VP,VP1), arg(1,VP1,VP2), %ist

              arg(1,NP1,NP11), arg(1,NP11,NP12), %homer

              arg(1,NP2,NP22), arg(1,NP22,NP23), %der

              arg(2,NP2,NP24), arg(1,NP24,NP244), %Vater

              arg(3,NP2,NP25), arg(1,NP25,NP255), arg(1,NP255,NP2555), %von

              arg(2,NP25,NP26), arg(1,NP26,NP266), arg(1,NP266,NP2666), %bart



              call(SemNP, NP12, Erg),


              NP2666 = Erg ->
                   Antwortliste=['JA! ',NP12,' ',VP2,' ',NP23,' ',NP244,' ',NP2555,' ',NP2666,'!'],
                   with_output_to(atom(Antwortsatz), maplist(write, Antwortliste)),
                   writeln(Antwortsatz),
                   Sem=true
                   ;
                   writeln('Nein!'),
                   Sem=false
             }.
             
             
% Ergänzungsfrage:
% "Wer ist der Vater von Homer?"
s(Sem)  --> ip(_SemIP, Numerus),       %wer
            vp(_SemVP, VP, Numerus),    %ist der vater von homer

            {


            arg(1,VP,VP1),arg(1,VP1,VP11),     %ist

            arg(2,VP,VP2),arg(1,VP2,VP22),arg(1,VP22,VP222),     %der

            arg(2,VP2,VP3),arg(1,VP3,VP33),     %vater

            arg(3,VP2,VP4),arg(1,VP4,VP44),arg(1,VP44,VP444),     %von

            arg(2,VP4,VP5),arg(1,VP5,VP55),arg(1,VP55,VP555),     %homer


            
              call(VP33, Ergebnis, VP555),
              Sem = Ergebnis,

              Antwortliste=[Ergebnis,' ',VP11,' ',VP222,' ',VP33,' ',VP444,' ',VP555,'!'],
              with_output_to(atom(Antwortsatz), maplist(write, Antwortliste)),
              writeln(Antwortsatz)

          }.


%Eine Nominalphrase kann sein:
  %Eigenname
  np(SemPN,np(N),Numerus)              --> pn(SemPN, N, Numerus).
  
  %Artikel, Nomen, Präpositionalphrase
  np(SemN,np(Det,N,PP),Numerus)       --> det(Det, Numerus), n(SemN, N, Numerus), pp(_SemN1, PP, Numerus).
  
  
  %Artikel, Nomen
  np(SemN,np(Det,N),Numerus)          --> det(Det, Numerus), n(SemN, N, Numerus).





%Eine Präpositionalphrase kann sein:
  %Präposition, Nominalphrase
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

%Präposition
  prae(prae(Prae), Numerus)           --> [Prae], {lex(Prae, prae, Numerus)}.

%Eigenname
  pn(PN, pn(PN), Numerus)             --> [PN], {lex(PN, pn, Numerus)}.



