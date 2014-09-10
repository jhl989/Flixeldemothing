package {
	import org.flixel.FlxSprite;

	/**
	 * @author jennylin
	 */
	public class Player extends FlxSprite {
		[Embed(source='com/Project3.5/paddle.png')]
		public var Paddle:Class;
		
		public function Player(X : int, Y:int) {
			super(X, Y);
			loadGraphic(Paddle);
			//makeGraphic(50, 50, 0xffffff);
			height = frameHeight;
			width = frameWidth;
			immovable = true;
			allowCollisions = ANY;
		}
		
	}
}
