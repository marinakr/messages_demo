-module(req_handler).
-behaviour(cowboy_http_handler).
%% Cowboy_http_handler callbacks
-export([
	init/2,
	handle/2,
	terminate/3
]).

-include("include/URLs.hrl").

init(Req, Opts) ->	
    handle(Req,Opts).

handle(Req, State) ->
	io:format("~p~n",[Req]),	 
	handle( cowboy_req:path(Req),cowboy_req:method(Req),Req,State).

handle(_, <<"POST">> , Req, State) ->
	Body = <<"<h1>This is a response for POST</h1>">>,
	{ok, Req3} = cowboy_req:reply(200, [], Body, Req),
	{ok, Req3, State};

handle(Path = ?ADD, <<"GET">>, Req, State) -> 
	Body = Path,
	cowboy_req:reply(200, [], Body, Req),
    {ok, Req, State};
handle(Path = ?GET, <<"GET">>, Req, State) -> 
	Body = Path,
	cowboy_req:reply(200, [], Body, Req),
    {ok, Req, State};
handle(Path = ?SEND, <<"GET">>, Req, State) -> 
	Body = Path,
	cowboy_req:reply(200, [], Body, Req),
    {ok, Req, State};

handle(_, <<"GET">>, Req, State) -> 
	Body = <<"<h1>This is a response for GET</h1>">>,
	cowboy_req:reply(200, [], Body, Req),
    {ok, Req, State};

handle(_, _,  Req, State) ->
            Body = <<"<h1>This is a response for other methods</h1>">>,
            {ok, Req3} = cowboy_req:reply(200, [], Body, Req),
            {ok, Req3, State}.

terminate(_Reason, _Req, _State) ->
	ok.

