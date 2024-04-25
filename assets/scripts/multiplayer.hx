function onCreate()
    {
        trace("skibid");
    
        FlxG.mouse.visible = true;
        FlxG.mouse.useSystemCursor = true;
        
        var bg = new FlxSprite(30,20,Paths.image("button"));
        ohio.add(bg);
    
        var icon = new FlxSprite(67.5,34,Paths.image("playericons/iconbf_alt"));
        ohio.add(icon);
        
        var text = new BSText(62,95,0,"DigBick ",0xFFFFFFFF, 25,"left");
        ohio.add(text);
    
        var trophyCounter = new FlxSprite(190,20,Paths.image("trophycounter"));
        ohio.add(trophyCounter);
    
        var trophyTxt = new BSText(275,31,0,"0 ",0xFFFFC023, 35,"left");
        ohio.add(trophyTxt);
    
        var trophy = new FlxSprite(220,38,Paths.image("trophy"));
        ohio.add(trophy);
    }
    function addTrophies(number)
    {
        var group = new FlxSpriteGroup();
        
    
        for(i in 0...number)
        {
            trace(i);
        }
    }
    
    function onUpdate(elapsed)
    {
        if(FlxG.keys.justPressed.R)
            MusicBeatState.resetState();
        if(FlxG.keys.justPressed.ESCAPE)
            MusicBeatState.switchState(new TitleState());
    
        if(FlxG.keys.justPressed.SPACE)
        {
            PlayState.SONG = Song.loadFromJson("bopeebo-hard", "bopeebo");
            PlayState.isStoryMode = false;
            PlayState.storyDifficulty = 2;
            LoadingState.loadAndSwitchState(new PlayState());
        }
        if(FlxG.keys.justPressed.S)
            addTrophies(10);
    }