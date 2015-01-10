%%%-------------------------------------------------------------------
%%% @author sushantsawant
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Jan 2015 9:44 PM
%%%-------------------------------------------------------------------
-module(extractMessage).
-author("sushantsawant").
-include("logger.hrl").
%% API
-export([messageIdentifier/2]).




messageIdentifier(From,Packet) ->
  ?DEBUG("From",[From]),

  ?DEBUG("Packet",[Packet]),
  Test=element(2,Packet),
  Temp=binary_to_list(Test),
  ?DEBUG(" ", [Temp]),

  if

  (Temp == "message") ->
    part3for_offline(From,Packet);
    true -> do
end.



part3for_offline(From,Packet) ->
  ?DEBUG("From",[From]),
  Was=lists:flatten(io_lib:format("~p", [Packet])),
    Temp1=string:str(Was, "xmlcdata,<<\"Offline Storage\">>"),

  if (Temp1 > 0)
    -> drop;
    true -> print(From,Packet)
  end.
%% TODO


extractMessage(Packet) ->

    extractMessageActual(1, element(4,Packet)).


 extractMessageActual(N,Param) ->
   ?DEBUG("Part of packet",[Param]),


   case lists:nth(N,Param) of
      {_,Body,[],[{_,Message}]} when Body == <<"body">> -> Message;


      _ ->
        Len=length(Param),
        if(Len==1)
          -> drop;
          true -> Temp=[Param],
            ?DEBUG("temp",[Temp]),
            extractMessageActual(N+1,Param)
    end
    end.



  print(From,Packet) ->
    UltimateMessage=extractMessage(Packet),

    if(is_binary(UltimateMessage))
    -> ?DEBUG("Ultimate",[UltimateMessage]),
      T1=element(2,From),
      Temp2=binary_to_list(T1),
      Temp3=binary_to_list(UltimateMessage),

      ?DEBUG("Ultimate from",Temp3),
      UltimateFrom=Temp2,
      ?DEBUG("Ultimate from",UltimateFrom),

      Var1 ="http://192.168.0.105/InfinitumToday/message?.htm?",

      Var2=lists:concat(["uid=",UltimateFrom,"&to=",Temp3]),


      httpc:request(get, {Var1++Var2, []}, [], []);

%%       httpc:request(post,{"http://192.168.0.105/InfinitumToday/message?", [],"application/x-www-form-urlencoded",lists:concat(["uid",UltimateFrom,"&to=",Temp3])}, [], []);
      true -> do


  end.















