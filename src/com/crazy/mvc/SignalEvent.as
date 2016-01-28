/**
 * Created by Anton Nefjodov on 28.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.ISignalEvent;

	import org.osflash.signals.events.GenericEvent;

	public class SignalEvent extends GenericEvent implements ISignalEvent
	{
		private var _data:Object;
		private var _type:String;

		public function SignalEvent(type:String, data:Object = null)
		{
			super(true);

			_type = type;
			_data = data;
		}

		public function get data():Object
		{
			return _data;
		}

		public function get type():String
		{
			return _type;
		}
	}
}