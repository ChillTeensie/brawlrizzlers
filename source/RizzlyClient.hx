package;

import flixel.FlxG;
import openfl.events.Event;

enum abstract CallbackTypes(String) from String
{
	var CONNECTED = "connected";
	var DISCONNECTED = "disconnected";
	var DATA = "data";
}

class RizzlyClient extends anette.Client {
    public var callbacks:Map<CallbackTypes,Array<Dynamic>> = [
        CONNECTED => [],
        DISCONNECTED => [],
        DATA => []
    ];

    public override function new(){
        super();
        protocol = new anette.Protocol.Prefixed();
        timeout = 300;
        onConnection = function(connection){
            trace("client connection");
            runCallback(CONNECTED,connection);
        };
        onDisconnection = function(connection){
            trace("client disconnection");
            runCallback(DISCONNECTED,connection);
        };
        onData = function(connection){
            trace("client data recived!");
            runCallback(DATA,connection);
        };
    }

    public function start(ip:String, port:Int)
    {
        connect(ip,port);
        FlxG.stage.addEventListener(Event.ENTER_FRAME, loop);
    }

    private function loop(e)
    {
        pump();
        flush();
    }

    public function stop()
    {
        disconnect();
        FlxG.stage.removeEventListener(Event.ENTER_FRAME, loop);
    }

    public function addCallback(type:CallbackTypes, callback:Dynamic)
    {
        var callbackArray = callbacks.get(type);
        callbackArray.push(callback);
        callbacks.set(type, callbackArray);
    }
    
    public function clearCallbacks(type:CallbackTypes)
    {
        callbacks.set(type, []);
    }

    public function readData(con:anette.Connection):Map<String,Dynamic>
    {
        return CoolUtil.json_to_map(con.input.readUTF());
    }
    public function sendData(data:Map<String,Dynamic>)
    {
        if(connected)
        {
            trace(CoolUtil.map_to_json(data));
            connection.output.writeUTF(CoolUtil.map_to_json(data));
        }
        else
        {
            trace("u not connected to the server my buddy chum chum");
        }
    }
    private function runCallback(type:CallbackTypes, connection:anette.Connection)
    {
        if(callbacks.get(type).length > 0)
        {
            for(func in callbacks.get(type))
            {
                func(connection);
            }
        }
    }
}