package;

import flixel.FlxState;

class IconSelection extends MusicBeatState
{
	private var scripts:Script;
    public override function create()
    {
        super.create();
        
		scripts = new Script();
		scripts.addScript("assets/scripts/iconSelection.hx");
		scripts.call("onCreate");
    }
    public override function update(elapsed:Float)
    {
        super.update(elapsed);
		scripts.call("onUpdate",[elapsed]);
    }
}