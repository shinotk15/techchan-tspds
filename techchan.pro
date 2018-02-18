% TechChan Question Answering System
% (Template code for an exercise of Logic and Reasoning)
% Takahiro Shinozaki, 2018/2/1
% Ver1.1
%
% Ver. 1.1 fixed the position of cut(!) at techchan(Query, Answer)
% clause 2018/2/2
% Ver. 1.0 Initial version 2018/2/1
%
% Examples
% ?- techchan([suzukakedai, kara, oookayama, made], Answer).
% ?- techchan([anata, ha, dare, desu, ka], Answer).

% TechChan is a mascot for Kodai-sai.
% https://koudaisai.jp/mascot/
% When you extend this program, follow the rules of TechChan.
% https://koudaisai.jp/mascot/agreement/

techchan(Query, Answer):-recognize(Query, Slots, Flags),!,think(Slots, Flags, Answer),writeln(Answer).
techchan(_, Answer):-Answer=[konnichiwa, boku, tokodai, no, techchan, desu], writeln(Answer).

% Basic concepts
station(chuorinkan).
station(suzukakedai).
station(nagatsuta).
station(futakotamagawa).
station(kikuna).
station(jiyugaoka).
station(jiyugaoka).
station(oookayama).
train(denentoshisen).
train(yokohamasen).
train(toyokosen).
train(ooimachisen).

% knowledge about language to understand the query(automaton)
%% delta(fromState, arcSymbol, toState, slot, flag)
delta(0, W, 1, [transport, W,_],[1,1,0]):-station(W).
delta(1, kara, 2, _, _).
delta(2, W, 3, [transport, _,W], [1,0,1]):-station(W).
delta(2, W, 5, [transport, _,W], [1,0,1]):-station(W).
delta(3, made, 4, _, _).
delta(3, made, 5, _, _).
delta(4, ikitai, 5, _, _).
goal(5).

% knowledge about transportation to answer the question (directed graph)
%% link(transportation, fromStation, toStation)
link(denentoshisen, chuorinkan, suzukakedai).
link(denentoshisen, suzukakedai, nagatsuta).
link(denentoshisen, suzukakedai, futakotamagawa).
link(yokohamasen, nagatsuta, kikuna).
link(toyokosen, kikuna, jiyugaoka).
link(ooimachisen, futakotamagawa, jiyugaoka).
link(ooimachisen, jiyugaoka, oookayama).
% Assume the links are bi-directional (make it undirected)
bilink(X, Y, Z):-link(X, Y, Z).
bilink(X, Y, Z):-link(X, Z, Y).

% recognize (Slot filling based on automaton)
recognize(Ss, Slots, Flags):-goal(G),path(0, Ss, G, Slots, [0,0,0], Flags).
path(X,[S],Y, Slots, Flags, NewFlags):-delta(X, S, Y, Slots, Flags1), listOr(Flags, Flags1, NewFlags).
path(X,[S|Ss],Y, Slots, Flags, NewFlags)
:-delta(X, S, Z, Slots, Flags1), listOr(Flags, Flags1, NewFlags1), path(Z, Ss, Y, Slots, NewFlags1, NewFlags).

% think to answer
think([transport, From, To], [1,1,1], Answer):-reachBy(From, To, _, Transports), transports2utterance(Transports, Answer).

% think engine about transportation (graph search)
% search how to move
reachBy(From, To, Stations, Transports):-reachBySub(From, To, [], Stations, [], Transports).
reachBySub(P, P, Ss, Stations, Y, Transports)
:-not(myMember(P, Ss)),myReverse([P|Ss], Stations), myReverse([[P, you_arrived]|Y], Transports).
reachBySub(From, To, [], Stations, [], Transports)
:-bilink(Tr, From, Y),reachBySub(Y, To, [From], Stations, [[From,Tr]], Transports).
reachBySub(From, To, Ss, Stations, [[Fr,Tr]|FrTrs], Transports)
:-not(myMember(From, Ss)),bilink(Tr, From, Y),reachBySub(Y, To, [From|Ss], Stations, [[Fr,Tr]|FrTrs], Transports).
reachBySub(From, To, Ss, Stations, [[Fr,Tr]|FrTrs], Transports)
:-not(myMember(From, Ss)),bilink(Tr1, From, Y),not(Tr==Tr1),reachBySub(Y, To, [From|Ss], Stations, [[From,Tr1],[Fr,Tr]|FrTrs], Transports).

% form answer utterance
transports2utterance([[X, you_arrived]], [X, ni, tsukeruyo]).
transports2utterance([[From, By]|X], [From, kara, By, ninotte|Utterance]):-transports2utterance(X, Utterance).

% some list tools
myAppend([], X, X).
myAppend([X | L], Y, [X | Z]) :- myAppend(L, Y, Z).

myReverse([], []).
myReverse([X | L], Y):-myReverse(L, Z), myAppend(Z, [X], Y).

myMember(X, [X | _]).
myMember(X, [_ | L]):-myMember(X, L).

listOr([],[],[]).
listOr([0|X], [0|Y], [0|Z]):-!,listOr(X, Y, Z).
listOr([_|X], [_|Y], [1|Z]):-listOr(X, Y, Z).


