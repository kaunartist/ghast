package Objects
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	
	public class Aura extends Entity
	{
		public var sprite:Spritemap = new Spritemap(Assets.AURA, 48, 48);

		public function Aura(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			sprite.add("pulse", [2, 1, 0, 1], 0.2, true);
			sprite.add("surge", [1, 0], 0.2, true);
			sprite.play("pulse");
			
			setHitbox(48, 48, 0, 0);
			graphic = sprite;
			super(x, y, graphic, mask);
			
			type = "Aura";
		}
		
		override public function update():void
		{
			this.moveTo(Global.player.x - 8, Global.player.y - 4);
			var e:Spirit;
			if (e = Spirit(collide("Spirit", x, y)))
			{
				if (!e.fleeing)
				{
					e.flee();
				}
			}
			super.update();
		}
		
		public function surge():void
		{
			sprite.play("surge");
		}
		
		public function surge_end():void
		{
			sprite.play("pulse");
		}
	}
}