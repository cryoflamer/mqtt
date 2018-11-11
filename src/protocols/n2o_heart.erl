-module(n2o_heart).
-author('Maxim Sokhatsky').
-export([info/3]).

info({text,<<"PING">> = _Ping}=Message, Req, State) ->
    wf:info(?MODULE,"PING: ~p",[Message]),
    {reply, <<"PONG">>, Req, State};

info({text,<<"N2O,",Process/binary>> = _InitMarker}=Message, Req, State) ->
    wf:info(?MODULE,"N2O INIT: ~p",[Message]),
    n2o_proto:push({init,Process},Req,State,n2o_proto:protocols(),[]);

info(Message, Req, State) -> {unknown,Message, Req, State}.
