package Objects
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Spirit extends Entity
	{
		public var sprite:Spritemap = new Spritemap(Assets.GHAST, 32, 32);
		public var fleeing:Boolean, dead:Boolean;
		
		public function Spirit(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			sprite.add("hover", [0, 1, 2], 0.1, true);
			sprite.play("hover");
			fleeing = false;
			dead = false;
			
			setHitbox(32, 32, 0, 0);
			graphic = sprite;
			super(x, y, graphic, mask);
			
			type = "Spirit";
		}
		
		override public function update():void
		{
			if (sprite.alpha <= 0) { visible = false; active = false; }
			if (dead) { sprite.alpha -= 0.1; return; }
		}
		
		public function flee():void
		{
			fleeing = true;
			trace("Run!");
		}
		
		public function banish():void
		{
			dead = true;
			this.collidable = false;
			trace("Spirit banished!");
		}
	}
}