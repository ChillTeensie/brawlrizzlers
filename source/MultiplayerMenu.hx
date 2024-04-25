package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.addons.ui.FlxButtonPlus;
import flixel.addons.ui.FlxInputText;

class MultiplayerMenu extends FlxState
{
    var hosting:Bool = false;
    var connecting:Bool = false;
    public override function create()
    {
        super.create();
        
        var input = new FlxInputText(0,330,600,"ip here",36);
        add(input);
        var text = new FlxButtonPlus(875,255,function(){
            if(!hosting)
            {
                var str:Array<String> = input.text.split(":");
                if(str.length == 2)
                {
                    trace("joining ip: "+str[0]+" port: "+str[1]);
                    Main.init_client();
                    Main.client.addCallback(CONNECTED,function(){
                        trace("connected to "+input.text);
                        Main.client.sendData(["playerJoined" => ""]);
                    });
                    // Main.client.addCallback(DATA, function(connection)
                    // {
                    //     trace("data");
                    //     var data = Main.client.readData(connection);
                    //     if(data.exists("playerJoined")){
                    //         MusicBeatState.switchState(new MainMenuState());
                    //     }
                    // });
                    Main.client.start(str[0],Std.parseInt(str[1]));
                }
            }
        },"CONNECT",400,100);
        add(text);
        
        var text = new FlxButtonPlus(875,360,function(){
            if(!hosting)
            {
                hosting = true;
                trace("hosting");
                Main.init_server();
                Main.server.start();
                Main.server.addCallback(DATA, function(connection)
                {
                    var data = Main.server.readData(connection);
                    trace("server data "+data);
                    if(data.exists("playerJoined")){
                        trace("senddata");
                        // Main.server.broadcastData(["playerJoined" => ""]);
                        // MusicBeatState.switchState(new MainMenuState());
                    }
                    trace("it doesnt exist?????");
                });
    
                Main.init_client();
                Main.client.addCallback(CONNECTED,function(){
                    trace("connected to localhost");
                });
                Main.client.start("127.0.0.1",25565);
            }
        },"HOST",400,100);
        add(text);
        
    }
    public override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}