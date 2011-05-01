package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import Control.Menu;
	
	public class ld20 extends Engine
	{
		public function ld20()
		{
			super(640, 480, 60, true);
		}
		
		override public function init():void
		{
			//load up the new world
			FP.world = new Menu();
			FP.screen.color = 0x584d44;
		}
	}
}