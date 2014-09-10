package {
	/**
	 * @author jennylin
	 */
	public class Timer {
		private var Current: Number;
		private var Interval: Number;
		private var SpeedUp: Number;
		public var f: Function;
		
		public function Timer(Duration : Number, Change : Number, f : Function = resetTimer, ... args) {
			Current = Duration;
			Interval = Duration;
			SpeedUp = Change;
			f = f;
		}
		
		public function Countdown(Passed : Number) {
			Current -= Passed;
			if (Current < 0) {
				f();
			}
		}
		
		private function resetTimer():void
		{
			Current = Interval;
			Interval *= 0.98;
			if (Interval < 0.1) {
				Interval = 0.1;
			}
		}
	}
}
