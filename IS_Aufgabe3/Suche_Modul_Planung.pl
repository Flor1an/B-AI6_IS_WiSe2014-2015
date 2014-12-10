% Die Schnittstelle umfasst
%   start_description   ;Beschreibung des Startzustands
%   start_node          ;Test, ob es sich um einen Startknoten handelt
%   goal_node           ;Test, ob es sich um einen Zielknoten handelt
%   state_member        ;Test, ob eine Zustandsbeschreibung in einer Liste
%                        von Zustandsbeschreibungen enthalten ist
%   expand              ;Berechnung der Kind-Zustandsbeschreibungen
%   eval-path           ;Bewertung eines Pfades
/*
%<3 Blöcke>
start_description([
  block(block1),
  block(block2),
  block(block3),
  on(table,block2),
  on(table,block3),
  on(block2,block1),
  clear(block1),
  clear(block3),
  handempty
]).
goal_description([
  block(block1),
  block(block2),
  block(block3),
  on(table,block3),
  on(table,block1),
  on(block1,block2),
  clear(block3),
  clear(block2),
  handempty
]).
%</3 Blöcke>
 */

%<4 Blöcke>
start_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  on(table,block2),
  on(table,block3),
  on(block2,block1),
  on(table,block4),
  clear(block1),
  clear(block3),
  clear(block4),
  handempty
]).

goal_description([
  block(block1),
  block(block2),
  block(block3),
  block(block4),
  on(block4,block2),
  on(table,block3),
  on(table,block1),
  on(block1,block4),
  clear(block3),
  clear(block2),
  handempty
]).
%</4 Blöcke>



start_node((start,_,_)).

goal_node((_,State,_)):-
  %used TODO:"Zielbedingungen einlesen"
  goal_description(Goal),
  %used TODO:"Zustand gegen Zielbedingungen testen"
  %state_member(State,[Goal])
  mysubset(Goal,State).


% Aufgrund der Komplexität der Zustandsbeschreibungen kann state_member nicht auf
% das Standardprädikat member zurückgeführt werden.
%
state_member(_,[]):- !,fail.

state_member(State,[FirstState|_]):-
  %used TODO:"Test, ob State bereits durch FirstState beschrieben war. Tipp: Eine Lösungsmöglichkeit besteht in der Verwendung einer Mengenoperation, z.B. subtract"  ,!.
  mysubset(State,FirstState),
  mysubset(FirstState,State).

%Es ist sichergestellt, dass die beiden ersten Klauseln nicht zutreffen.
state_member(State,[_|RestStates]):-
  %used TODO:"rekursiver Aufruf".
  state_member(State,RestStates).

%<TEIL 2>
    %eval_path([(X,State,Value)|RestPath]):-
      eval_path(Path):-
        %used TODO:eval_state(State,"Rest des Literals bzw. der Klausel"
        length(Path,G),
        eval_state(Path,G).

    %<Suchverfahren>     //Ein Algorithmus auswählen
        /*
      %used TODO: A-Algorithmus
          eval_state([(_X,State,Value)|_],G) :-
          heuristik(State,H1),
          heuristikFaktor(State,H2),
          F is G + H1 - H2, %A-Algorithmus: f(n) = g(n) + h(n)
          %nl,write(['Moeglichkeit: ', X, ' Kosten: ', F]),  %ToDebug
          Value = F.
       */

      %used TODO: gierige Bestensuche
        eval_state([(_X,State,Value)|_],_) :-
          heuristik(State,H1),
          heuristikFaktor(State,H2),
          %nl,write(['Moeglichkeit: ', X, ' Kosten: ', H]),  %ToDebug
          Value is H1 - H2.

          
      %used TODO: optimistisches Bergsteigen
      %in Suche_Modul_Allgemein.pl gelöst!

      %used TODO: Bergsteigen mit Backtracking
      %in Suche_Modul_Allgemein.pl gelöst!

    %</Suchverfahren>
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %<Heuristiken>     //Ein Algorithmus auswählen
      % Anzahl der Elemente des Ziels, die noch an der falschen Position sind.
      heuristik(State,Value) :-
        goal_description(Ziel),
        differenzmenge(Ziel,State,Differenz),
        length(Differenz,Value).

     /*

      % Anzahl der Elemente, die schon an der richtigen Position sind
      heuristik(State,Value) :-
        goal_description(Ziel),
        schnittmenge(State,Ziel,Schnitt),
        length(Schnitt,AnzSchnitt),
        length(Ziel,AnzZiel),
        Value is (AnzZiel - AnzSchnitt).
       */
      heuristikFaktor(State,Value) :-
        goal_description(Ziel),
        intersection(Ziel,State,Neu),
        collecttable(Neu,X),
        length(X,Val),
        Value is Val * 100.
        
        /*mysubset([on(table,Z1)],State),
        goal_description(Ziel),
        mysubset([on(table,Z2)],Ziel),
        (Z1 = Z2, Value = 100) ;

        mysubset([on(table,Z1)],State),
        goal_description(Ziel),
        mysubset([on(table,Z2)],Ziel),
         (Z1 \= Z2, Value = 0).
        */
        collecttable([],[]).
        
        collecttable([First|Rest],[First|Erg]):-
             First = on(table,_),
             collecttable(Rest,Erg).
             
        collecttable([_|Rest],Erg):-
             collecttable(Rest,Erg).

    %</Heuristiken>
       scheck([],_).
       scheck([H|T],Y):-
          mysubset(on(table,_Z),[H]),
          Y is 100,
          scheck(T,Y).

    % Mengenoperationen
    %-------------------
    % differenzmenge(Menge_A, Menge_B, Differenzmenge)   "A ohne B"
    differenzmenge([], _, []).
    differenzmenge([Element|Tail], Menge, Rest) :-
      member(Element, Menge), !,
      differenzmenge(Tail, Menge, Rest).
    differenzmenge([Head|Tail], Menge, [Head|Rest]) :-
      differenzmenge(Tail, Menge, Rest).
                             
    % schnittmenge(Menge_A, Menge_B, Menge_C)
    schnittmenge([], _, []).
    schnittmenge([Element|Tail], Liste, Schnitt) :-
      member(Element, Liste), !,
      Schnitt = [Element|Rest],
      schnittmenge(Tail, Liste, Rest).
    schnittmenge([_|Tail], Liste, Rest) :-
       schnittmenge(Tail, Liste, Rest).
       
%</TEIL 2>

action(pick_up(X),
       [handempty, clear(X), on(table,X)],
       [handempty, clear(X), on(table,X)],
       [holding(X)]).

action(pick_up(X),
       [handempty, clear(X), on(Y,X), block(Y)],
       [handempty, clear(X), on(Y,X)],
       [holding(X), clear(Y)]).

action(put_on_table(X),
       [holding(X)],
       [holding(X)],
       [handempty, clear(X), on(table,X)]).

action(put_on(Y,X),
       [holding(X), clear(Y)],
       [holding(X), clear(Y)],
       [handempty, clear(X), on(Y,X)]).


% Hilfskonstrukt, weil das PROLOG "subset" nicht die Unifikation von Listenelementen
% durchführt, wenn Variablen enthalten sind. "member" unifiziert hingegen.
%
mysubset([],_).
mysubset([H|T],List):-
  member(H,List),
  mysubset(T,List).


expand_help(State,Name,NewState):-
  %used TODO:"Action suchen"
  action(Name,
         ConditionList,
         DeleteList,
         AddList),
  
  %used TODO:"Conditions testen" Folie: "Unter welchen Vorbedingungen ist die Aktion anwendbar?"
  mysubset(ConditionList,State),
  
  %used TODO:"Del-List umsetzen"  Folie: "Welche Formeln gelten nach Ausführung der Aktion nicht mehr?"
  subtract(State, DeleteList, TempNewState),

  %used TODO:"Add-List umsetzen". Folie: "Welche Formeln kommen nach Ausführung der Aktion hinzu?"
  append(TempNewState,AddList,NewState).


expand((_,State,_),Result):-
  findall((Name,NewState,_),expand_help(State,Name,NewState),Result).