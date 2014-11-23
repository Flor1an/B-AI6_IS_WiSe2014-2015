% Die Schnittstelle umfasst
%   start_description   ;Beschreibung des Startzustands
%   start_node          ;Test, ob es sich um einen Startknoten handelt
%   goal_node           ;Test, ob es sich um einen Zielknoten handelt
%   state_member        ;Test, ob eine Zustandsbeschreibung in einer Liste
%                        von Zustandsbeschreibungen enthalten ist
%   expand              ;Berechnung der Kind-Zustandsbeschreibungen
%   eval-path           ;Bewertung eines Pfades


start_description([
  block(block1),
  block(block2),
  on(table,block1),
  on(table,block2),
  clear(block1),
  clear(block2),
  handempty
  ]).

goal_description([
  block(block1),
  block(block2),
  on(table,block1),
  on(block1,block2),
  clear(block2),
  handempty
  ]).



start_node((start,_,_)).

goal_node((_,State,_)):-
  %TODO:"Zielbedingungen einlesen"
  goal_description(Goal),
  %TODO:"Zustand gegen Zielbedingungen testen"
  state_member(State,[Goal]).


% Aufgrund der Komplexität der Zustandsbeschreibungen kann state_member nicht auf
% das Standardprädikat member zurückgeführt werden.
%
state_member(_,[]):- !,fail.

state_member(State,[FirstState|_]):-
  %used TODO:"Test, ob State bereits durch FirstState beschrieben war. Tipp: Eine Lösungsmöglichkeit besteht in der Verwendung einer Mengenoperation, z.B. subtract"  ,!.
  mysubset(State,FirstState).

%Es ist sichergestellt, dass die beiden ersten Klauseln nicht zutreffen.
state_member(State,[_|RestStates]):-
  %used TODO:"rekursiver Aufruf".
  state_member(State,RestStates).


eval_path([(_,State,Value)|RestPath]):-  false.
  %TODO:%TODO:eval_state(State,"Rest des Literals bzw. der Klausel"
  %TODO:%TODO:"Value berechnen".



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
  action(Name, ConditionList, DeleteList, AddList),
  
  %used TODO:"Conditions testen" Folie: "Unter welchen Vorbedingungen ist die Aktion anwendbar?"
  mysubset(ConditionList,State),
  
  %used TODO:"Del-List umsetzen"  Folie: "Welche Formeln gelten nach Ausführung der Aktion nicht mehr?"
  subtract(State, DeleteList, TempNewState),
      /*writeln(['STATE: ',State]),
      writeln(['DEL: ', DeleteList]),
      writeln(['AFTER: ',TempNewState]),nl,*/
  
  %used TODO:"Add-List umsetzen". Folie: "Welche Formeln kommen nach Ausführung der Aktion hinzu?"
  append(TempNewState,AddList,NewState).
      /*writeln(['ADD: ', AddList]),
      writeln(['AFTER: ',NewState]),nl.*/


expand((_,State,_),Result):-
  findall((Name,NewState,_),expand_help(State,Name,NewState),Result).