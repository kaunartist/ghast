package Objects
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import stateMachine.StateMachine;
	import stateMachine.StateMachineEvent;
	
	public class Spirit extends Entity
	{
		public var sprite:Spritemap = new Spritemap(Assets.GHAST, 48, 48);
		public var state:StateMachine;
		public var destination:Point;
		public var home:Point;
		//current spirit direction (true = right/down, false = left/up)
		public var direction:Boolean = true, direction_y:Boolean = true;
		
		public function Spirit(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			sprite.add("hover", [0, 1, 2, 3, 4, 5], 0.1, true);
			sprite.add("glide", [0, 8, 9, 10, 10, 9, 9, 8], 0.1, true);
			sprite.alpha = 0.7;
			
			setHitbox(48, 48, 0, 0);
			destination = new Point(FP.rand(FP.screen.width), FP.rand(FP.screen.height));

			graphic = sprite;
			super(x, y, graphic, mask);

			home = new Point(x, y);
			
			// set up state machine
			state = new StateMachine();
			state.addState("patrol", { enter: onPatrol, from: ["hunt", "follow", "flee"] })
			state.addState("follow", { enter: onFollow, from: "patrol" })
			state.addState("hunt", { enter: onHunt, from: ["patrol", "follow", "swoop"] })
			state.addState("swoop", { enter: onSwoop, from: "hunt" })
			state.addState("flee", { enter: onFlee, from: "*" })
			state.addState("banished", { enter: onBanished, from: "*" })
			state.initialState = "patrol";
			
			type = "Spirit";
		}
		
		override public function update():void
		{
			if (sprite.alpha <= 0) { visible = false; active = false; }
			if (state.state == "banished") { sprite.alpha -= 0.1; return; }

			switch (state.state)
			{
				case "patrol":
					
					// look for player
					if (look())
					{
						state.changeState("hunt");
					}
					
					// move
					if (FP.distance(x, y, home.x, home.y) > 150) { destination = home.clone(); }
					if (reached_destination()) { choose_destination(); return; }
					determine_direction();
					if (direction) { x += 1; }
					else { x -= 1; }
					if (direction_y) { y += 1; }
					else { y -= 1; }
					break;
				case "follow":
					if ((sprite.currentAnim == "spawn") && (sprite.complete))
					{
						state.changeState("flying");
					}
					break;
				case "hunt":
					if (Input.pressed(Key.SPACE))
					{
						if (state.canChangeStateTo("return"))
						{
							state.changeState("return");
						}
					}
					break;
				case "swoop":
					if ((sprite.currentAnim == "reform") && (sprite.complete))
					{
						state.changeState("rest");
					}
					break;
				case "flee":
					if (reached_destination())
					{
						state.changeState("patrol");
						return;
					}
					determine_direction();
					if (direction) { x += 1; }
					else { x -= 1; }
					if (direction_y) { y += 1; }
					else { y -= 1; }
					break;
				case "banished":
					if (sprite.alpha > 0) { sprite.alpha -= 0.1; }
					else { FP.world.remove(this); }
					break;
			}
		}
		
		public function flee():void
		{
			state.changeState("flee");
		}
		
		public function banish():void
		{
			state.changeState("banished");
		}
		
		private function look():Boolean
		{
			var p:Entity = Global.player;
			var c:Entity;
			// if player is behind us, we won't be able to see him
			if ((direction && (p.x < x)) || (!direction && (p.x > x))) { return false; }

			var distance:Number = FP.distance(x, y, p.centerX, p.centerY);
			
			if (distance < 200)
			{ // only do the checks if they're in vision range
				c = FP.world.collideLine("Obstacle", centerX, centerY, p.centerX, p.centerY);
				if (c)
				{
					trace("Collide with obstacle");
					return false;
					/*if (FP.distance(x, y, c.x, c.y) <= distance)
					{ // there's an obstacle in the way, can't see him
						return false;
					}*/
				}
				c = FP.world.collideLine("Solid", centerX, centerY, p.centerX, p.centerY);
				if (c)
				{
					trace("Collide with wall.");
					return false;
					/*if (FP.distance(x, y, c.x, c.y) <= distance)
					{ // there's a solid in the way, can't see him
						return false;
					}*/
				}
				// nothing in the way, ghast can see the player
				return true;
			}
			return false;
		}
		
		private function determine_direction():void
		{
			if (destination.x >= x) { direction = true; } 
			else if (destination.x < x) { direction = false; }
			if (destination.y >= y) { direction_y = true; } 
			else if (destination.y < y) { direction_y = false; }
		}
		
		private function reached_destination():Boolean
		{
			if (FP.distance(x, y, destination.x, destination.y) < 2)
			{
				return true;
			}
			return false;
		}
		
		private function choose_destination():void
		{
			if (direction) { destination.x = x + 40 + FP.rand(40); }
			else { destination.x = x - 40 - FP.rand(40); }
			if (direction_y) { destination.y = y - 20 - FP.rand(20); }
			else { destination.y = y + 20 + FP.rand(20); }
		}
		
		private function onPatrol(event:StateMachineEvent):void
		{
			sprite.play("glide");
		}
		
		private function onFollow(event:StateMachineEvent):void
		{
			trace("i hear you...");
			// go towards cry location
		}
		
		private function onHunt(event:StateMachineEvent):void
		{
			trace("hunting");
			// play the feeding cry sfx
		}
		
		private function onSwoop(event:StateMachineEvent):void
		{
			// play swooping sfx
			// tween towards player position
		}
		
		private function onFlee(event:StateMachineEvent):void
		{
			// play flee sfx
			
//			sprite.play("flee");
			// set destination away from player
			direction = !direction;
			if (direction)
			{
				destination.x = x + 100;
				destination.y = y - 80;
			}
			else
			{
				destination.x = x - 100;
				destination.y = y - 80;
			}
		}
		
		private function onBanished(event:StateMachineEvent):void
		{			
			this.collidable = false;
			// play banished sfx
		}
	}
}