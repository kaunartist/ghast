package Control
{
	import Assets;
	
	import Global;
	
	import Objects.*;
	
	import Solids.*;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Tilemap;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Game extends World
	{
		
		public var tileset:Tilemap;
		
		//timer so that reset level doesn't happen right away...
		public var reset:int = 60;
		
		override public function begin():void
		{
			//enable the console
			FP.console.enable();
			
			//set the level to 0
			Global.level = 0;
			
			//load next level
			nextlevel();
		}
		
		override public function update():void 
		{
			//only update if the game is not paused
			if (!Global.paused) { super.update(); }
			
			//if we should restart
			if (Global.restart) { 
				
				//make a timer so it isn't instant
				reset -= 1;
				if (reset == 0) {
					//restart level
					restartlevel();
					//set restart to false
					Global.restart = false;
					//reset our timer
					reset = 60;
				}
			}
			
			//load next level on level completion
			if (Global.finished) {
				nextlevel();
			}
		}
		
		public function loadlevel():void 
		{	
			//get the XML
			var file:ByteArray = new Assets.LEVELS[Global.level-1];
			var str:String = file.readUTFBytes( file.length );
			var xml:XML = new XML(str);
			
			//define some variables that we will use later on
			var e:Entity;
			var o:XML;
			var n:XML;
			
			//set the level size
			FP.width = xml.width;
			FP.height = xml.height;
			
			//add the tileset to the world
			add(new Entity(0, 0, tileset = new Tilemap(Assets.TILESET, FP.width, FP.height, Global.grid, Global.grid)));
			
			//add the view, and the player
			add(Global.player = new Player(xml.objects[0].player.@x, xml.objects[0].player.@y));
			add(Global.aura = new Aura(xml.objects[0].player.@x, xml.objects[0].player.@y));
			
			//add the spirits
			Global.spirits = new Vector.<Spirit>();
			var s:Spirit;
			if(str.search("<spirits>") > 0) {
				for each (o in xml.spirits[0].ghast) {
					s = new Spirit(o.@x, o.@y);
					Global.spirits.push(s);
					add(s);
				}
			}
			
			//set the view to follow the player, within no restraints, and let it "stray" from the player a bit.
			//for example, if the last parameter was 1, the view would be static with the player. If it was 10, then
			//it would trail behind the player a bit. Higher the number, slower it follows.
			add(Global.view = new View(Global.player as Entity, new Rectangle(0,0,FP.width,FP.height), 10));
			
			//add tiles
			for each (o in xml.tilesAbove[0].tile) {
				//place the tiles in the correct position
				//NOTE that you should replace the "5" with the amount of columns in your tileset!
				tileset.setTile(o.@x / Global.grid, o.@y / Global.grid, (5 * (o.@ty/Global.grid)) + (o.@tx/Global.grid));
			}
			
			//place the solids
			for each (o in xml.floors[0].rect) {
				//place flat solids, setting their position & width/height
				add(new Solid(o.@x, o.@y, o.@w, o.@h));
			}
			if(str.search("<slopes>") > 0) {
				for each (o in xml.slopes[0].slope) {
					//place a slope
					add(new Slope(o.@x, o.@y, o.@type));
				}
			}
			//place a crate
			for each (o in xml.objects[0].crate) { add(new Crate(o.@x, o.@y)); }
			
			//add the door!
			for each (o in xml.objects[0].door) { add(new Door(o.@x, o.@y)); }
		}
		
		
		/**
		 * Loads up the next level (removes all entities of the current world, increases Global.level, calls loadlevel)
		 * @return	void
		 */
		public function nextlevel():void
		{
			removeAll();
			
			if(Global.level < Assets.LEVELS.length) { Global.level ++; }
			Global.finished = false;
			
			loadlevel();
		}
		
		
		/**
		 * Reloads the current level
		 * @return	void
		 */
		public function restartlevel():void
		{
			removeAll();
			loadlevel();
			
			//increase deaths
			Global.deaths ++;
		}
		
	}

}
