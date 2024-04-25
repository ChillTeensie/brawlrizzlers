function onCreate()
{

    var ohio_bg = new FlxSprite().makeGraphic(1280,720,0xFFFD719B);
    FlxG.state.add(ohio_bg);

    var text = new BSText(62,95,0,"OHio ",0xFFFFFFFF, 25,"left");
    FlxG.state.add(text);
}

function addIcon(img)
{
    var icon
}

function onUpdate(elapsed)
{
}