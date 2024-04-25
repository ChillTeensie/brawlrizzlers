package;

import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

class BSText extends FlxSpriteGroup
{
    public var fieldWidth(default, set):Float = 0;
    public var text(default, set):String = "";
    public var size(default, set):Int = 8;
    public var textcolor(default, set):Int = 0xFFFFFFFF;
    private var t1:FlxText;
    private var t2:FlxText;

    public override function new(x:Float, y:Float, _width:Float, _text:String, _color:Int = 0xFFFFFFFF, _size:Int, alignment:String = 'left')
    {
        super(x,y);
        t2 = new FlxText(0,0,_width,_text,_size);
        t2.setFormat(Paths.font("bs.ttf"), 20, 0xFF000000, txt_to_align(alignment), OUTLINE, 0xFF000000);
        t2.borderSize = Math.ceil(t2.width/32);
        this.add(t2);

        t1 = new FlxText(0,0,_width,_text,_size);
        t1.setFormat(Paths.font("bs.ttf"), 20, _color, txt_to_align(alignment), OUTLINE, 0xFF000000);
        t1.borderSize = Math.ceil(t1.width/32);
        this.add(t1);
        t2.y = t1.y+(t1.height/8);
        
        textcolor = _color;
        width = _width;
        size = _size;
        text = _text;
    }

    function set_textcolor(text):Int
    {
        t1.color = text;
        return text;
    }
    function set_text(text):String
    {
        t1.text = text;
        t2.text = text;
        t2.y = t1.y+(t1.height/8);
        return text;
    }
    function set_size(size):Int
    {
        t1.size = size;
        t2.size = size;
        t2.y = t1.y+(t1.height/8);
        return size;
    }
    function set_fieldWidth(width):Float
    {
        t1.fieldWidth = width;
        t2.fieldWidth = width;
        t2.y = t1.y+(t1.height/8);
        return width;
    }
    
    function txt_to_align(str):FlxTextAlign
    {
        var align = LEFT;
        switch(str){
            case "left":
                align = LEFT;
            case "center":
                align = CENTER;
            case "right":
                align = RIGHT;
        }
        return align;
    }
}