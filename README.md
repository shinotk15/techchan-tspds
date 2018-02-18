# techchan-tspds
Techchan dialogue system for a Prolog exercise.  

This code is as a template for an assignment of a Prolog exercise at my  
class "Logic and Reasoning."  
It takes a list of words as a query and returns an answer.  

Usage Examples:  
    ?- consult('techchan.pro').  
    true.  
    ?- techchan([futakotamagawa, kara, oookayama, made], Answer).  
    [futakotamagawa,kara,ooimachisen,ninotte,oookayama,ni,tsukeruyo]  
    Answer = [futakotamagawa, kara, ooimachisen, ninotte, oookayama, ni, tsukeruyo] .  
    ?- techchan([anata, ha, dare, desu, ka], Answer).  
    [konnichiwa,boku,tokodai,no,techchan,desu]  
    Answer = [konnichiwa, boku, tokodai, no, techchan, desu].  

Tested Prolog environments:  
SWI-Prolog version 7.2.3 on Ubuntu 16.04  
SWI-Prolog version 7.6.4 on Windows 10  

Note:  
TechChan is a mascot for Kodai-sai, which is a campus festival held at  
Tokyo Institute of Technology.  
It is allowed to use the mascot with some constraints freely.  
When you extend this program, you have to follow the rules of TechChan.  
<https://koudaisai.jp/mascot/>  

--------------------------------------------------------------------------  
Takahiro Shinozaki  
Tokyo Institute of Technology  
<www.ts.ip.titech.ac.jp>  
