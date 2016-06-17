/**
 * Created by Anton Nefjodov on 14.04.2016.
 */
package com.crazyfm.devkit.gearSys.mechanisms
{
	import com.crazyfm.extension.gearSys.AbstractGearSysMechanism;

	import flash.utils.getTimer;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;

	public class StarlingEnterFrameMechanism extends AbstractGearSysMechanism
	{
		private var time:Number;

		private var sprite:Sprite;

		public function StarlingEnterFrameMechanism()
		{
			super();

			init();
		}

		[Autowired]
		public function init():void
		{
			sprite = new Sprite();
			sprite.addEventListener(Event.ENTER_FRAME, enterFrame);
			Starling.current.stage.addChild(sprite);

			time = getTimer();
		}

		private function enterFrame():void
		{
			var currentTime:Number = getTimer();
			var passedTime:Number = currentTime - time;
			time = currentTime;

			interact(passedTime / 1000);
		}

		override public function dispose():void
		{
			sprite.removeEventListener(Event.ENTER_FRAME, enterFrame);

			sprite.removeFromParent(true);

			sprite = null;

			super.dispose();
		}
	}
}