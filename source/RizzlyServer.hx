package;

import flixel.FlxG;
import openfl.events.Event;
import RizzlyClient.CallbackTypes;

class RizzlyServer extends anette.Server {
    public var started:Bool = false;
    public var callbacks:Map<CallbackTypes,Array<Dynamic>> = [
        CONNECTED => [],
        DISCONNECTED => [],
        DATA => []
    ];
    public var maxPlayers:Int = 1;

    public override function new(){
        super("0.0.0.0",25565);
        protocol = new anette.Protocol.Prefixed();
        timeout = 300;
        onConnection = function(connection){
            trace("server connection");
            runCallback(CONNECTED,connection);
        };
        onDisconnection = function(connection){
            trace("server disconnection");
            runCallback(DISCONNECTED,connection);
        };
        onData = function(connection){
            trace("server data recived!");
            runCallback(DATA,connection);
        };
    }

    public function start()
    {
        started = true;
        FlxG.stage.addEventListener(Event.ENTER_FRAME, loop);
    }
    private function loop(e)
    { 
        pump();
        flush();
    }

    public function stop()
    {
        started = false;
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
        trace(CoolUtil.json_to_map(con.input.readUTF()));
        return CoolUtil.json_to_map(con.input.readUTF());
    }
    
    public function broadcastData(data:Map<String,Dynamic>)
    {
        for (client in connections.iterator())
        {
            trace(data);
            client.output.writeUTF(CoolUtil.map_to_json(data));
        }
    }
    public function sendData(data:Map<String,Dynamic>,connection:anette.Connection)
    {
        connection.output.writeUTF(CoolUtil.map_to_json(data));
        trace(CoolUtil.map_to_json(data));
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