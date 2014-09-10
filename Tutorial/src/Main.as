package
{
    import flash.display.Sprite;
    import flash.events.Event;
	[SWF(width="640", height="480", backgroundColor="#000000")]

    public class Main extends Sprite
    {
        public function Main():void
        {
            if (stage)
            {
                init();
            } else {
                addEventListener(Event.ADDED_TO_STAGE, init);
            }
        }
 
        private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
 
            var game:FirstGame = new FirstGame;
 
            addChild(game);
        }
    }
}


