package Solids 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import Assets;
	/**
	 * ...
	 * @author mchnzr
	 */
	public class Bush extends Obstacle
	{
		
		public var bushMask:Pixelmask
		
		public function Bush(x:int, y:int, width:int, height:int) 
		{
			image = new Stamp(Assets.OBJECT_BUSH);
			super(x, y, width, height);
			
//			layer = 2;
/*			var bush:Class = Assets.OBJECT_BUSH;
			
			bushMask = new Pixelmask(bush, 0, 0);
			mask = bushMask;*/
			
			//hide us - we don't need to ever be updated
//			active = false;
		}
		
	}

}
