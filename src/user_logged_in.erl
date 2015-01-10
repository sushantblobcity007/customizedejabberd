%%%-------------------------------------------------------------------
%%% @author sushantsawant
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Jan 2015 2:18 PM
%%%-------------------------------------------------------------------
-module(user_logged_in).
-author("sushantsawant").
-include("logger.hrl").
%% API
-export([check/3]).
  check(From,To,Packet) ->
    ?DEBUG("from",From),

    T1=element(2,From),
    Temp2=binary_to_list(T1),
    ?DEBUG("From",Temp2),
    T2=element(2,To),
    ?DEBUG("To",T2),
    T3=element(3,To),
    T4 = <<"localhost">>,
    Nothing = <<>>,
    FourthElement1=element(4,Packet),
    FourthElement2=lists:flatten(io_lib:format("~p", [FourthElement1])),
    Fourth1=[{xmlel,<<"query">>,[{<<"xmlns">>,<<"http://jabber.org/protocol/disco#items">>}],[]}],
    Fourth2=lists:flatten(io_lib:format("~p", [Fourth1])),
%%     Was=lists:flatten(io_lib:format("~p", [Packet])),
%%     Temp11=string:str(Was, "<<\"http://jabber.org/protocol/disco#items"),


    if ((Nothing == T2) and (T3 == T4) and (FourthElement2 == Fourth2))
       -> ?DEBUG("This should be sent to rest as logged in",[From]);
      true -> do
    end,

    ?DEBUG("from",Temp2),
    ?DEBUG("kuch ni",To).

