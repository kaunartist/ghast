package
{
	import Control.View;
	
	import Objects.Aura;
	import Objects.Player;
	import Objects.Spirit;
	
	import net.flashpunk.utils.Key;

	/*
	 * This class contains a number of global variables to be used throughout the game
	 */
	public class Global
	{
		public static var
			time:int = 0,
			deaths:int = 0,
			gems:int = 0,
			level:int = 0,
			
			newgame:Boolean = false,
			loadgame:Boolean = false,
			
			musicon:Boolean = true,
			soundon:Boolean = true,
			
			keyUp:int = Key.UP,
			keyDown:int = Key.DOWN,
			keyLeft:int = Key.LEFT,
			keyRight:int = Key.RIGHT,
			keyA:int = Key.SPACE,
			
			player:Player,
			aura:Aura,
			spirits:Vector.<Spirit>,
			view:View,
			
			paused:Boolean = false,
			restart:Boolean = false,
			finished:Boolean = false;
			
		public static const grid:int = 32;
		
	}

}
