package Objects
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Spirit extends Entity
	{
		public var sprite:Spritemap = new Spritemap(Assets.GHAST, 48, 48);
		public var fleeing:Boolean, dead:Boolean;
		
		public function Spirit(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			sprite.add("hover", [0, 1, 2, 1], 0.15, true);
			sprite.play("hover");
			fleeing = false;
			dead = false;
			
			setHitbox(48, 48, 0, 0);
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