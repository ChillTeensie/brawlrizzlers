package multiplayer;

class PlayerData{
    public var name:String = "Mingebag";
    public var sessionID:String = "";
    public var damage:Int = 0;
    public var health:Int = 0;
    public var money:Int = 0;
    public var souls:Int = 0;
    public var canPlayItems:Bool = false;
    public var buyCount:Int = 1;
    public var playableCardsCount:Int = 1;
   // public var cardsActive:Array<Card> = [];
    public function new()
    {
        sessionID = Util.generateSessionID();
    }
}