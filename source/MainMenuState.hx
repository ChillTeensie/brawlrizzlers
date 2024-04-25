 package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxBackdrop;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC

	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	var magenta:FlxSprite;
	var debugKeys:Array<FlxKey>;
	var rizz:Bool;
	private var scripts:Script;

	override public function new(?clearUnusedMemory:Bool = false)
	{
		super();
		rizz = clearUnusedMemory;
	}

	override function create()
	{
		if(FlxG.save.data.trophyAmount == null)
			FlxG.save.data.trophyAmount = Std.int(0);
		if(FlxG.save.data.icon == null)
			FlxG.save.data.icon = 0;
		FlxG.save.flush();
		scripts = new Script();
		scripts.addScript("assets/scripts/mainMenu.hx");
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();
		if(rizz)
			Paths.clearUnusedMemory();
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite().makeGraphic(1280,720, 0xFFFDE871);
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		magenta = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		var backdrop = new FlxBackdrop(Paths.image("loop ohio"));
		backdrop.color = 0xFFFFEF97;
		backdrop.antialiasing = ClientPrefs.globalAntialiasing;
		backdrop.velocity.set(50,-25);
 		add(backdrop);
		
		var left = new FlxSprite(-70,205);
		left.frames = Paths.getSparrowAtlas("left light");
		left.animation.addByPrefix("anim",'skibidi',24,true);
		left.animation.play('anim');
		left.antialiasing = ClientPrefs.globalAntialiasing;
		add(left);
		
		var right = new FlxSprite(860,215);
		right.frames = Paths.getSparrowAtlas("right light");
		right.animation.addByPrefix("anim",'Symbol 2',24,true);
		right.animation.play('anim');
		right.antialiasing = ClientPrefs.globalAntialiasing;
		add(right);
		
		var light = new FlxSprite(Paths.image("light"));
		light.scrollFactor.set();
		light.antialiasing = ClientPrefs.globalAntialiasing;
		light.screenCenter();
		light.alpha = 0.35;
		light.blend = ADD;
 		add(light);

		scripts.call("onCreate",[]);

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		scripts.call("onUpdate",[elapsed]);
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		#if desktop
		if(!selectedSomethin){
			if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
		}
		#end

		super.update(elapsed);
	}
}
