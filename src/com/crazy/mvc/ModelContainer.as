/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazy.mvc
{
	import com.crazy.mvc.api.IModel;
	import com.crazy.mvc.api.IModelContainer;

	import flash.utils.Dictionary;

	import org.osflash.signals.events.IBubbleEventHandler;
	import org.osflash.signals.events.IEvent;

	public class ModelContainer extends Model implements IModelContainer, IBubbleEventHandler
	{
		private var _modelList:Dictionary;
		private var _bubbledSignalListener:Function;

		public function ModelContainer()
		{
			super();
		}

		public function addModel(model:IModel):void
		{
			if (!_modelList)
			{
				_modelList = new Dictionary();
			}

			model.parent = this;
			_modelList[model] = model;
		}

		public function removeModel(model:IModel):void
		{
			if (_modelList)
			{
				model.parent = null;
				delete _modelList[model]
			}
		}

		public function removeAllModels():void
		{
			if (_modelList)
			{
				for (var i:String in _modelList)
				{
					removeModel(_modelList[i]);
				}

				_modelList = null;
			}
		}

		override public function dispose():void
		{
			super.dispose();

			removeAllModels();
		}

		public function onEventBubbled(event:IEvent):Boolean
		{
			trace("onEventBubbled: ", event);
			if(_bubbledSignalListener != null)
			{
				_bubbledSignalListener(event);
			}
			return true;
		}

		public function set bubbledSignalListener(value:Function):void
		{
			_bubbledSignalListener = value;
		}

		public function get bubbledSignalListener():Function
		{
			return _bubbledSignalListener;
		}
	}
}
