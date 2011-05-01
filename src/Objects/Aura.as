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
		public var sprite:Spritemap = new Spritemap(Assets.AURA, 32, 32);

		public function Aura(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			sprite.add("pulse", [2, 1, 0, 1, 2], 0.2, true);
			sprite.add("surge", [1, 0], 0.2, true);
			sprite.play("pulse");
			graphic = sprite;
//			mask = new Pixelmask(Assets.AURA_MASK);
			type = "Aura";
			super(x, y, graphic, mask);
		}
		
		override public function update():void
		{
			this.moveTo(Global.player.x, Global.player.y);
			if (collide("Spirit", x, y))
			{
				trace("HIT");
			}
//			super.update();
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