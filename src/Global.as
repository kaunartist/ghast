package
{
	import Control.View;
	
	import Objects.Aura;
	import Objects.Player;
	import Objects.Spirit;
	
	import flash.geom.Point;
	
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Key;

	/*
	 * This class contains a number of global variables to be used throughout the game
	 */
	public class Global
	{
		public static var
			time:int = 0,
			deaths:int = 0,
			energy:int = 5,
			health:int = 3,
			level:int = 0,
			
			newgame:Boolean = false,
			loadgame:Boolean = false,
			
			musicon:Boolean = true,
			soundon:Boolean = true,
			
			soundtrack:Sfx,
			
			keyUp:int = Key.UP,
			keyDown:int = Key.DOWN,
			keyLeft:int = Key.LEFT,
			keyRight:int = Key.RIGHT,
			keyA:int = Key.SPACE,
			
			player:Player,
			aura:Aura,
			spirits:Vector.<Spirit>,
			view:View,
			
			feeding:Point,
			
			paused:Boolean = false,
			restart:Boolean = false,
			finished:Boolean = false;
			
		public static const grid:int = 32;
		
	}

}
