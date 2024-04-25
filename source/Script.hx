package;

import sys.FileSystem;
import sys.io.File;
import flixel.FlxBasic;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;

//extends flxobject so it doesnt become a singleton
class Script extends FlxBasic {
    var scripts:Array<Dynamic>;
    var stateInstance:Dynamic;
    //init so i can not bother with static bullshjit!!!!
    public override function new()
    {
        super();
        scripts = [];
        trace("sscript init");
    }

    function setClassString(cl:String, script:Dynamic)
    {
        var cls:Class<Dynamic> = Type.resolveClass(cl);
        if (cls != null)
        {
            if (cl.split('.').length > 1)
            {
                cl = cl.split('.')[cl.split('.').length - 1];
            }
            script.variables.set(cl, cls);
        }
    }

    public function addScript(path:String)
    {
        if(!FileSystem.exists(path)){
            lime.app.Application.current.window.alert("No script found at "+path,"Hscript Error!");
            return;
        }
        var rizzler = new hscript.Parser().parseString(File.getContent(path));
        var script = new hscript.Interp();
        
        setClassString("flixel.FlxG", script);
        setClassString("flixel.FlxGame", script);
        setClassString("flixel.FlxState", script);
        setClassString("flixel.FlxSprite", script);
        setClassString("flixel.FlxCamera", script);
        setClassString("flixel.FlxObject", script);
        setClassString("flixel.FlxBasic", script);
        setClassString("flixel.text.FlxText", script);
        setClassString("flixel.util.FlxTimer", script);
        script.variables.set("FlxGroup", FlxGroup);
        script.variables.set("FlxTypedGroup", FlxTypedGroup);
        script.variables.set("FlxSpriteGroup", FlxSpriteGroup);
        setClassString("flixel.util.FlxCollision", script);
        setClassString("flixel.util.FlxColor", script);
        setClassString("flixel.util.FlxGradient", script);
        setClassString("flixel.util.FlxSpriteUtil", script);
        setClassString("flixel.ui.FlxBar", script);
        setClassString("flixel.ui.FlxButton", script);
        setClassString("flixel.addons.ui.FlxUIButton", script);
        setClassString("flixel.addons.ui.FlxButtonPlus", script);
        setClassString("flixel.tweens.FlxTween", script);
        setClassString("flixel.tweens.FlxEase", script);
        setClassString("flixel.addons.display.FlxBackdrop", script);
        setClassString("flixel.addons.ui.FlxInputText", script);
        setClassString("flixel.math.FlxRect", script);
        
        script.variables.set("Alphabet", Alphabet);
        script.variables.set("AttachedSprite", AttachedSprite);
        script.variables.set("AttachedText", AttachedText);
        script.variables.set("BSText", BSText);
        script.variables.set("BGSprite", BGSprite);
        script.variables.set("CheckboxThingie", CheckboxThingie);
        script.variables.set("ClientPrefs", ClientPrefs);
        script.variables.set("Controls", Controls);
        script.variables.set("MultiplayerMenu", MultiplayerMenu);
        script.variables.set("CoolUtil", CoolUtil);
        script.variables.set("DiscordClient", Discord.DiscordClient);
        script.variables.set("LoadingState", LoadingState);
        script.variables.set("MusicBeatState", MusicBeatState);
        script.variables.set("IconSelection", IconSelection);
        script.variables.set("Note", Note);
        script.variables.set("Paths", Paths);
        script.variables.set("Popup", Popup);
        script.variables.set("PlayState", PlayState);
        script.variables.set("MainMenuState", MainMenuState);
        script.variables.set("Song", Song);
        script.variables.set("WeekData", WeekData);
        script.variables.set("Math", Math);
        script.variables.set("Std", Std);

        script.execute(rizzler);
        scripts.push(script);
    }
    public function call(functionName:String,?args:Array<Dynamic>){
        for (script in scripts){
            if(script.variables.exists(functionName))
                Reflect.callMethod(script.variables,script.variables.get(functionName),args);
        }
    }
}