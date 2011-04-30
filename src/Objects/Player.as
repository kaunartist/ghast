package Objects 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.graphics.Emitter;
	import Assets;
	import Global;
	
	public class Player extends Physics
	{
		
		
		public var sprite:Spritemap = new Spritemap(Assets.PLAYER, 32, 32, animEnd);
		
		//how fast we accelerate
		public var movement:Number = 1;
		public var jump:Number = 8;
		
		//current player direction (true = right, false = left)
		public var direction:Boolean = true;
		
		//are we on the ground?
		public var onground:Boolean = false;
		
		public var dead:Boolean = false;
		public var start:Point;
		public var aura:Emitter;
		protected const AURA_MAX:uint = 50;
		public var aura_count:uint;
		
		public function Player(x:int, y:int) 
		{
			//set position
			super(x, y);
			start = new Point(x, y);
			
			//set different speeds and such
			mGravity = 0.4;
			mMaxspeed = new Point(2, 5);
			mFriction = new Point(0.6, 0.8);
			
			//set up animations
			sprite.add("standLeft", [0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 19, 18, 0, 0, 0], 0.2, true);
			sprite.add("standRight", [8, 8, 8, 8, 8, 8, 8, 8, 8, 20, 21, 20, 8, 8, 8], 0.2, true);
			sprite.add("walkLeft", [0, 1, 2, 3, 4, 5, 6, 7], 0.2, true);
			sprite.add("walkRight", [8, 9, 10, 11, 12, 13, 14, 15], 0.2, true);
			sprite.add("crouchLeft", [22], 0, false);
			sprite.add("crouchRight", [23], 0, false);
			
			sprite.add("jumpLeft", [2], 0, false);
			sprite.add("jumpRight", [10], 0, false);
			
			sprite.add("slideRight", [16], 0, false);
			sprite.add("slideLeft", [17], 0, false);
			
			sprite.play("standRight");
			
			//set hitbox & graphic
			setHitbox(12, 24, -10, -8);
			initialize_aura();
			graphic = new Graphiclist(aura, sprite);
			type = "Player";
		}
		
		override public function update():void 
		{
			//did we... die?
			if (dead) { sprite.alpha -= 0.1; return; } else if ( sprite.alpha < 1 ) { sprite.alpha += 0.1 }
			else
			{
				emit_aura();
			}
			
			//are we on the ground?
			onground = false;
			if (collide(solid, x, y + 1)) 
			{ 
				onground = true;
			}
			
			//set acceleration to nothing
			acceleration.x = 0;
			
			//friction (apply if we're not moving, or if our speed.x is larger than maxspeed)
			if ( (! Input.check(Global.keyLeft) && ! Input.check(Global.keyRight)) || Math.abs(speed.x) > mMaxspeed.x ) { friction(true, false); }
			
			//jump
			if ( Input.pressed(Global.keyUp) ) 
			{
				var jumped:Boolean = false;
				
				//increase acceeration, if we're not going too fast
//				if (Input.check(Global.keyLeft) && speed.x > -mMaxspeed.x) { acceleration.x = - movement; direction = false; }
//				if (Input.check(Global.keyRight) && speed.x < mMaxspeed.x) { acceleration.x = movement; direction = true; }
				
				//normal jump
				if (onground) { 
					speed.y = -jump; 
					jumped = true; 
				}
			}
			
			if (!Input.check(Global.keyDown))
			{ // only move if not crouching
				if (onground || Input.pressed(Global.keyUp))
				{
					// only allow horizontal movement if we are on the ground - you can't randomly change direction in mid-air!
					if (Input.check(Global.keyLeft) && speed.x > -mMaxspeed.x) { acceleration.x = - movement; direction = false; }
					if (Input.check(Global.keyRight) && speed.x < mMaxspeed.x) { acceleration.x = movement; direction = true; }
				}
				else
				{
					// only allow horizontal movement if we are on the ground - you can't randomly change direction in mid-air!
					if (Input.check(Global.keyLeft) && speed.x >= 0) { acceleration.x = - movement/10; direction = false; }
					if (Input.check(Global.keyRight) && speed.x <= 0) { acceleration.x = movement/10; direction = true; }
				}
			}
			else
			{
				acceleration.x = 0;
			}
			//set the gravity
			gravity();
			
			//make sure we're not going too fast vertically
			//the reason we don't stop the player from moving too fast left/right is because
			//that would (partially) destroy the walljumping. Instead, we just make sure the player,
			//using the arrow keys, can't go faster than the max speed, and if we are going faster
			//than the max speed, descrease it with friction slowly.
			maxspeed(false, true);
			
			//variable jumping (triple gravity)
			if (speed.y < 0 && !Input.check(Global.keyUp)) { gravity(); gravity(); }
			
			
			//set the sprites according to if we're on the ground, and if we are moving or not
			if (onground)
			{
				if (Input.check(Global.keyDown))
				{
					if (direction) { sprite.play("crouchRight"); } else { sprite.play("crouchLeft"); }
				}
				else
				{
					if (speed.x < 0) { sprite.play("walkLeft"); }
					if (speed.x > 0) { sprite.play("walkRight"); }
					
					if (speed.x == 0) {
						if (direction) { sprite.play("standRight"); } else { sprite.play("standLeft"); }
					}
				}
			} else {
				if (direction) { sprite.play("jumpRight"); } else { sprite.play("jumpLeft"); }
				
				//are we sliding on a wall?
				if (collide(solid, x - 1, y)) { sprite.play("slideRight"); }
				if (collide(solid, x + 1, y)) { sprite.play("slideLeft"); }
			}
			
			
			//set the motion. We set this later so it stops all movement if we should be stopped
			if (Input.check(Global.keyDown))
			{
				motion(false);
			}
			else
			{
				motion();
			}
			//did we just get.. KILLED? D:
			if (collide("Spikes", x, y) && speed.y > 0)
			{
				//killme!
				killme();
			}
			
		}
		
		public function killme():void
		{
			dead = true;
			Global.restart = true;
		}
		
		public function animEnd():void { }
		
		private function initialize_aura():void
		{
			aura_count = AURA_MAX;
			aura = new Emitter(new BitmapData(2,2), 2, 2);
			aura.relative = false;
			aura.newType("exhaust",[0]);
			aura.setAlpha("exhaust",1,0);
			aura.setMotion("exhaust", 0, 35, 40, 360, 0, 0);
			aura.setColor("exhaust", 0x66EEFF, 0x9922FF);
		}
		
		private function emit_aura():void
		{
			for (var i:uint = 0; i < aura.particleCount; i++)
			{
				
			}
			for (i = aura.particleCount; i < aura_count; i++)
			{
				aura.emit("exhaust", x + width/2 + 12, y + height/2 + 4);
			}
		}
	}

}
