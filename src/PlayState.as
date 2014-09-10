package
{

	import org.flixel.*; //Allows you to refer to flixel objects in your code
	import flash.net.*;
	import flash.events.*;
	[SWF(width="800", height="600", backgroundColor="#000000")] //Set the size and color of the Flash file
 
	public class PlayState extends FlxState
	{
		public var player:Player;
		public var story:Array;
		public var words:FlxGroup;
		public var effectors:FlxGroup;
		public var spawnTimer: Number;
		public var spawnInterval: Number = 1.2;
		public var background: FlxText;
		public var backtwo : FlxText;
		private var linecount: int = 0;
		private var fontsize: int = 8;
		private var tint: uint = 0xffffffff;
		private var pup : Array = ["#", "+", "-", ".", ",", "!", "?", "\"", ";"];
		private var store : Array = [];
		
		override public function create():void
		{
			add(new FlxText(0,0,100,"Project 3.5")); //adds a 100px wide text field at position 0,0 (upper left)
			background = new FlxText(10, 10, 500, "");
			background.setFormat(null, fontsize, 0xcccccc);
			background.height = 500;
			backtwo = new FlxText(10, FlxG.height-40, FlxG.width-10, "[]");
			backtwo.color = 0xcccccccc;
			add(background);
			add(backtwo);
			add(player = new Player(FlxG.width/2, FlxG.height-50));
			add(words = new FlxGroup());
			add(effectors = new FlxGroup());
			story = ['Alice', 'was', 'beginning', 'to', 'get', 'very', 'tired', 'of', 'sitting', 'by', 'her', 'sister', 'on', 'the', 'bank,', 'and', 'of', 'having', 'nothing', 'to', 'do', 'once', 'or', 'twice', 'she', 'had', 'peeped', 'into', 'the', 'book', 'her', 'sister', 'was', 'reading,', 'but', 'it', 'had', 'no', 'pictures', 'or', 'conversations', 'in', 'it', "'and", 'what', 'is', 'the', 'use', 'of', 'a', "book", 'thought', 'Alice', "without", 'pictures', 'or', "conversations", "So", 'she', 'was', 'considering', 'in', 'her', 'own', 'mind', 'as', 'well', 'as', 'she', 'could,', 'for', 'the', 'hot', 'day', 'made', 'her', 'feel', 'very', 'sleepy', 'and', 'stupid,', 'whether', 'the', 'pleasure', 'of', 'making', 'a', 'daisy-chain', 'would', 'be', 'worth', 'the', 'trouble', 'of', 'getting', 'up', 'and', 'picking', 'the', 'daisies,', 'when', 'suddenly', 'a', 'White', 'Rabbit', 'with', 'pink', 'eyes', 'ran', 'close', 'by', 'her', 'There', 'was', 'nothing', 'so', 'VERY', 'remarkable', 'in', 'that;', 'nor', 'did', 'Alice', 'think', 'it', 'so', 'VERY', 'much', 'out', 'of', 'the', 'way', 'to', 'hear', 'the', 'Rabbit', 'say', 'to', 'itself,', "'Oh", 'dear', 'Oh', 'dear', 'I', 'shall', 'be', "late", 'when', 'she', 'thought', 'it', 'over', 'afterwards', 'it', 'occurred', 'to', 'her', 'that', 'she', 'ought', 'to', 'have', 'wondered', 'at', 'this,', 'but', 'at', 'the', 'time', 'it', 'all', 'seemed', 'quite', 'natural', 'but', 'when', 'the', 'Rabbit', 'actually', 'TOOK', 'A', 'WATCH', 'OUT', 'OF', 'ITS', 'WAISTCOAT-POCKET,', 'and', 'looked', 'at', 'it,', 'and', 'then', 'hurried', 'on,', 'Alice', 'started', 'to', 'her', 'feet,', 'for', 'it', 'flashed', 'across', 'her', 'mind', 'that', 'she', 'had', 'never', 'before', 'seen', 'a', 'rabbit', 'with', 'either', 'a', 'waistcoat-pocket,', 'or', 'a', 'watch', 'to', 'take', 'out', 'of', 'it,', 'and', 'burning', 'with', 'curiosity,', 'she', 'ran', 'across', 'the', 'field', 'after', 'it,', 'and', 'fortunately', 'was', 'just', 'in', 'time', 'to', 'see', 'it', 'pop', 'down', 'a', 'large', 'rabbit-hole', 'under', 'the', 'hedge', 'In', 'another', 'moment', 'down', 'went', 'Alice', 'after', 'it', 'never', 'once', 'considering', 'how', 'in', 'the', 'world', 'she', 'was', 'to', 'get', 'out', 'again.'];
			spawnTimer = 0;
			var myTextLoader:URLLoader = new URLLoader();

			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);

			function onLoaded(e:Event):void {
    			story = e.target.data.split(/\s/);
				
			}

			myTextLoader.load(new URLRequest("com/Project3.5/text.txt"));


		}
		
		override public function update():void
		{
			FlxG.collide(player, words, wordGet);
			FlxG.overlap(player, effectors, effect);
			// If left arrow key is pressed.
			if (FlxG.keys.LEFT && player.x > 0)
				{
				// Move left.
				player.x-=2;
				}
			// If right arrow key is pressed.
			if (FlxG.keys.RIGHT && player.x + player.width < FlxG.width)
				{
				// Move right.
				player.x+=2;
				}
				
			// Press Z to use
			if (FlxG.keys.justPressed("Z") && store.length > 0)
			{
				background.text = background.text + store.shift();
				updateStore();
			}
			
			//Press X to discard
			if (FlxG.keys.justPressed("X") && store.length > 0)
			{
				store.shift();
				updateStore();
			}
			
			if (story.length != 0)
			{
				spawnTimer -= FlxG.elapsed;
				if (spawnTimer < 0)
				{
					spawnWord(story.shift());
					if (Math.random() < 0.4) 
					{
						var char:String = pup[Math.floor(Math.random()*pup.length)];
						var effectGet:PowerUp = new PowerUp(FlxG.width*Math.random(), FlxG.height-55, 10, 0x88ffff00, char);
						if (true)
						{
							effectGet.color=0x788888ff;
						}
						effectors.add(effectGet);
					}
					resetTimer();
				}
			}
			
			super.update();
		}
		
		private function wordGet(p: Player, w: Word):void
		{
			updateBack(w.text);
			w.kill();
		}
		
		private function spawnWord(w : String):void
		{
			var x: Number = (FlxG.width-50) * Math.random()+25;
			var y: Number = -100;
			words.add(new Word(x, y, 10, w));
		}
		
		private function effect(p: Player, u: PowerUp):void
		{
			var newText: String = u.text;
			if (newText == "#") 
			{
				
			}
			store.push(newText);
			updateStore();
			u.kill();
		}
		
		private function updateStore():void
		{
			backtwo.text = "[" + store.join(" ") + "]";
		}
		
		private function updateBack(newText : String):void
		{
			linecount += fontsize * newText.length;
			if (linecount > FlxG.width)
			{
				background.text = background.text + "\n" + newText;
				linecount = 0;
			}
			else if (newText in pup)
			{
				background.text = background.text + newText;
			}
			else
			{
				background.text = background.text + " " + newText;
			}
		}
		
		private function resetTimer():void
		{
			spawnTimer = spawnInterval;
			spawnInterval *= 0.99;
			if (spawnInterval < 0.1) {
				spawnInterval = 0.1;
			}
		}
	}
}