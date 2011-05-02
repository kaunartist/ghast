package Solids 
{
	import Assets;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.masks.Pixelmask;

	/**
	 * ...
	 * @author mchnzr
	 */
	public class Rock extends Obstacle
	{
		
		public var rockMask:Pixelmask;
		
		public function Rock(x:int, y:int, width:int, height:int) 
		{
			image = new Stamp(Assets.OBJECT_ROCK);
			super(x, y, width, height);
			
//			layer = 2;
/*			var rock:Class = Assets.OBJECT_ROCK;
			
			rockMask = new Pixelmask(rock, 0, 0);
			mask = rockMask;*/
			
			//hide us - we don't need to ever be updated
//			active = false;
		}
		
	}

}
