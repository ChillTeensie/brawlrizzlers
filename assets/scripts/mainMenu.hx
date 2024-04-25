var trophyTxt;
var button;
function onCreate()
{
    FlxG.mouse.visible = true;
    FlxG.mouse.useSystemCursor = true;

    var ohio = new FlxSprite().makeGraphic(1280,40,0xFF000000);
    FlxG.state.add(ohio);
    
    button = new FlxSprite(30,20,Paths.image("button"));
    button.antialiasing = ClientPrefs.globalAntialiasing;
    FlxG.state.add(button);

    var icon = new FlxSprite(67.5,34,Paths.image("playericons/icon"+FlxG.save.data.icon));
    icon.setGraphicSize(75,75);
    icon.updateHitbox();
    icon.antialiasing = ClientPrefs.globalAntialiasing;
    FlxG.state.add(icon);
    
    var text = new BSText(62,95,0,"DigBick ",0xFFFFFFFF, 25,"left");
    text.antialiasing = ClientPrefs.globalAntialiasing;
    FlxG.state.add(text);

    var trophyCounter = new FlxSprite(190,20,Paths.image("trophycounter"));
    trophyCounter.antialiasing = ClientPrefs.globalAntialiasing;
    FlxG.state.add(trophyCounter);

    trophyTxt = new BSText(275,31,0,FlxG.save.data.trophyAmount+" ",0xFFFFC023, 35,"left");
    trophyTxt.antialiasing = ClientPrefs.globalAntialiasing;
    FlxG.state.add(trophyTxt);

    var trophy = new FlxSprite(220,38,Paths.image("trophy"));
    trophy.antialiasing = ClientPrefs.globalAntialiasing;
    FlxG.state.add(trophy);
}
function randCirclePoint(center_x, center_y, radius)
{
    // gpt code cuz im ohio skibidi gyatt rizz
    var ohio = Math.PI * FlxG.random.int(0,360) / 180;
    var r = radius * Math.sqrt((FlxG.random.int(4,10))/10);
    var x = r * Math.cos(ohio)+center_x;
    var y = r * Math.sin(ohio)+center_y;
    return [x,y];
}

function addTrophies(number)
{
    var skibidiRizz = Std.int(FlxG.save.data.trophyAmount);
    FlxG.save.data.trophyAmount = Std.int(FlxG.save.data.trophyAmount + number);
    FlxG.save.flush();
    var sus = [];
    for(i in 0...Math.round(number))
    {
        sus.push(1/Math.round(number)*(i+1));
        var trophy = new FlxSprite(640,360,Paths.image("trophy_gained"));
        trophy.scale.set(0.75,0.75);
        trophy.updateHitbox();
        trophy.alpha = 0;
        trophy.antialiasing = ClientPrefs.globalAntialiasing;
        FlxG.state.add(trophy);
        new FlxTimer().start(i*0.125, function(tmr)
        {
            var ohio = randCirclePoint(640,360,75);
            FlxTween.tween(trophy, {alpha: 1}, 0.2);
            FlxTween.tween(trophy, {x: ohio[0], y: ohio[1]}, 0.3, {ease: FlxEase.quadOut});
            new FlxTimer().start(Math.round(number)*0.125, function(tmr)
            {
                FlxTween.tween(trophy, {x: 205, y: 20}, 1, {ease: FlxEase.quadInOut});
            });
        });
        new FlxTimer().start(Math.round(number)*0.125+1.75, function(t){
            new FlxTimer().start(reversearray(sus)[i], function(t3){
                FlxTween.tween(trophy.scale, {x: 0, y: 0}, 1, {ease: FlxEase.quadInOut,onComplete:function(t2){
                    trophy.destroy();
                    skibidiRizz++;
                    trophyTxt.text = skibidiRizz;
                }});
            });
        });
    }
    var newSkibidiToilet = new BSText(0,0,0,"+"+number+" ",0xFFFFFFFF, 35,"left");
    newSkibidiToilet.alpha = 0;
    newSkibidiToilet.antialiasing = ClientPrefs.globalAntialiasing;
    newSkibidiToilet.screenCenter();
    FlxG.state.add(newSkibidiToilet);
    FlxTween.tween(newSkibidiToilet, {alpha: 1}, .5);
    FlxTween.tween(newSkibidiToilet, {y: newSkibidiToilet.y-25}, 2, {ease: FlxEase.cubicOut});
    new FlxTimer().start(1.5, function(tmr)
    {
        FlxTween.tween(newSkibidiToilet, {alpha: 0}, .5, {onComplete:function(t){
            newSkibidiToilet.destroy();
        }});
    });
}

function reversearray(array){
    var ohio = [];
    var rizz = array.length;
    for(i in 0...array.length)
    {
        rizz -= 1;
        ohio.push(array[rizz]);
    }

    return ohio;
}

function onUpdate(elapsed)
{
    if(FlxG.keys.justPressed.R)
        MusicBeatState.resetState();
    if(FlxG.keys.justPressed.ESCAPE)
        MusicBeatState.switchState(new TitleState());
    if(FlxG.keys.justPressed.ALT)
        MusicBeatState.switchState(new MultiplayerMenu());
    if(FlxG.keys.justPressed.SPACE)
    {
        PlayState.SONG = Song.loadFromJson("bopeebo-hard", "bopeebo");
        PlayState.isStoryMode = false;
        PlayState.storyDifficulty = 2;
        LoadingState.loadAndSwitchState(new PlayState());
    }
    if(FlxG.keys.justPressed.S || FlxG.keys.justPressed.A)
        addTrophies(10);
    if(FlxG.mouse.justPressed)
        if(FlxG.mouse.overlaps(button))
            MusicBeatState.switchState(new IconSelection());
}