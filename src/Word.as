package {
	import org.flixel.FlxText;

	/**
	 * @author jennylin
	 */
	public class Word extends FlxText {
		public function Word(X : Number, Y : Number, Width : uint, Text : String = null, EmbeddedFont : Boolean = true) {
			super(X, Y, Width, Text, EmbeddedFont);
			velocity.y = 100;
			allowCollisions = ANY;
			width = frameWidth;
		}
	}
}
