package 
{
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Assets
	{
		
		//Embed the levels
		[Embed(source = '../assets/levels/obstacletest.oel',  mimeType = "application/octet-stream")] public static const LEVEL1: Class;
//		[Embed(source = '../assets/levels/Level2.oel',  mimeType = "application/octet-stream")] public static const LEVEL2: Class;
		
		public static const LEVELS:Array = new Array(LEVEL1);
		
		//tilesets
		[Embed(source = '../assets/graphics/tileset.png')] public static const TILESET:Class;
		
		//menu
		[Embed(source = '../assets/graphics/banner.png')] public static const MENU_BANNER:Class;
		[Embed(source = '../assets/graphics/menu.png')] public static const MENU:Class;
		[Embed(source = '../assets/graphics/mchnzd.png')] public static const MCHNZD:Class;
		
		//slopes
		[Embed(source = '../assets/graphics/slope1.png')] public static const SLOPE1:Class;
		[Embed(source = '../assets/graphics/slope2.png')] public static const SLOPE2:Class;
		[Embed(source = '../assets/graphics/slope3.png')] public static const SLOPE3:Class;
		[Embed(source = '../assets/graphics/slope4.png')] public static const SLOPE4:Class;
		
		//objects
		[Embed(source = '../assets/graphics/crate.png')] public static const OBJECT_CRATE:Class;
		[Embed(source = '../assets/graphics/bush.png')] public static const OBJECT_BUSH:Class;
		[Embed(source = '../assets/graphics/rock.png')] public static const OBJECT_ROCK:Class;
		[Embed(source = '../assets/graphics/door.png')] public static const OBJECT_DOOR:Class;
		[Embed(source = '../assets/graphics/particleauratrace.png')] public static const AURA:Class;
		[Embed(source = '../assets/graphics/ghast3.png')] public static const GHAST:Class;
		
		//sounds
		[Embed(source = '../assets/audio/soundtrack.swf#soundtrack')] public static const SFX_SOUNDTRACK:Class;
		
		//player
		[Embed(source = '../assets/graphics/kvothe.png')] public static const PLAYER:Class;
		[Embed(source = '../assets/graphics/crouchleftmask.png')] public static const CROUCH_LEFT_MASK:Class;
		[Embed(source = '../assets/graphics/crouchrightmask.png')] public static const CROUCH_RIGHT_MASK:Class;
		
		
	}

}