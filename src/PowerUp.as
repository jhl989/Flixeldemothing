package {
	import org.flixel.FlxText;

	/**
	 * @author jennylin
	 */
	public class PowerUp extends FlxText {
		public function PowerUp(X : Number, Y : Number, Width : uint, Color : uint, Text : String = null) {
			super(X, Y, Width, Text);
			//color = Color;
			allowCollisions = ANY;
			width = frameWidth;
			solid = true;
		}
	}
}
