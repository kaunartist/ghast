package Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import Assets;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Spikes extends Entity
	{
		public var sprite:Image = new Image(Assets.OBJECT_SPIKE);
		
		public function Spikes(x:int, y:int) 
		{
			//set position
			super(x, y);
			
			//set graphic and mask
			graphic = sprite;
			mask = new Pixelmask(Assets.OBJECT_SPIKE);
			
			//set type
			type = "Spikes";
		}
		
	}

}
