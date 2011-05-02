package Solids 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Stamp;
	/**
	 * ...
	 * @author mchnzr
	 */
	public class Obstacle extends Entity
	{
		public var image:Stamp;
		public function Obstacle(x:int,y:int,w:int = 32,h:int = 32) 
		{
			
			this.x = x;
			this.y = y;
			this.width = 32;
			this.height = 32;
			
			super(x, y, image);
			
			type = "Obstacle";
			setHitbox(w, h);
			//hide us - we don't need to ever be updated
//			active = false; // this might mess up collision detection
		}
		
	}

}
