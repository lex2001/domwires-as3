/**
 * Created by Anton Nefjodov on 26.01.2016.
 */
package com.crazyfm.core.mvc.context
{
	import com.crazyfm.core.common.Enum;
	import com.crazyfm.core.factory.IAppFactory;
	import com.crazyfm.core.mvc.hierarchy.AbstractHierarchyObject;
	import com.crazyfm.core.mvc.hierarchy.HierarchyObjectContainer;
	import com.crazyfm.core.mvc.hierarchy.ns_hierarchy;
	import com.crazyfm.core.mvc.message.IMessage;
	import com.crazyfm.core.mvc.model.*;
	import com.crazyfm.core.mvc.view.IView;
	import com.crazyfm.core.mvc.view.IViewContainer;
	import com.crazyfm.core.mvc.view.ViewContainer;

	use namespace ns_hierarchy;

	/**
	 * Context contains models, views and services. Also implements <code>ICommandMapper</code>. You can map specific messages, that came out
	 * from hierarchy, to <code>ICommand</code>s.
	 */
	public class AbstractContext extends HierarchyObjectContainer implements IContext
	{
		/**
		 * @private
		 */
		[Autowired]
		public var factory:IAppFactory;

		private var modelContainer:IModelContainer;
		private var viewContainer:IViewContainer;

		private var commandMapper:ICommandMapper;

		public function AbstractContext()
		{
			super();
		}

		[PostConstruct]
		public function init():void
		{
			factory.mapToValue(IAppFactory, factory);

			modelContainer = factory.getInstance(ModelContainer);
			add(modelContainer);

			viewContainer = factory.getInstance(ViewContainer);
			add(viewContainer);

			commandMapper = factory.getInstance(CommandMapper);
		}

		/**
		 * @inheritDoc
		 */
		public function addModel(model:IModel):IModelContainer
		{
			checkIfDisposed();

			modelContainer.addModel(model);
			(model as AbstractHierarchyObject).setParent(this);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeModel(model:IModel, dispose:Boolean = false):IModelContainer
		{
			checkIfDisposed();

			modelContainer.removeModel(model, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllModels(dispose:Boolean = false):IModelContainer
		{
			checkIfDisposed();

			modelContainer.removeAllModels(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numModels():int
		{
			checkIfDisposed();

			return modelContainer.numModels;
		}

		/**
		 * @inheritDoc
		 */
		public function containsModel(model:IModel):Boolean
		{
			checkIfDisposed();

			return modelContainer.containsModel(model);
		}

		/**
		 * @inheritDoc
		 */
		public function get modelList():Array
		{
			checkIfDisposed();

			return modelContainer.modelList;
		}

		/**
		 * @inheritDoc
		 */
		public function addView(view:IView):IViewContainer
		{
			checkIfDisposed();

			viewContainer.addView(view);
			(view as AbstractHierarchyObject).setParent(this);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeView(view:IView, dispose:Boolean = false):IViewContainer
		{
			checkIfDisposed();

			viewContainer.removeView(view, dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function removeAllViews(dispose:Boolean = false):IViewContainer
		{
			checkIfDisposed();

			viewContainer.removeAllViews(dispose);

			return this;
		}

		/**
		 * @inheritDoc
		 */
		public function get numViews():int
		{
			checkIfDisposed();

			return viewContainer.numViews;
		}

		/**
		 * @inheritDoc
		 */
		public function containsView(view:IView):Boolean
		{
			checkIfDisposed();

			return viewContainer.containsView(view);
		}

		/**
		 * @inheritDoc
		 */
		public function get viewList():Array
		{
			checkIfDisposed();

			return viewContainer.viewList;
		}

		/**
		 * Clears all children, unmaps all commands and nullifies dependencies.
		 */
		override public function dispose():void
		{
			modelContainer.dispose();
			viewContainer.dispose();

			nullifyDependencies();

			super.dispose();
		}

		private function nullifyDependencies():void
		{
			modelContainer = null;
			viewContainer = null;

			commandMapper.clear();
			commandMapper = null;
		}

		/**
		 * Disposes all children, unmaps all commands and nullifies dependencies.
		 */
		override public function disposeWithAllChildren():void
		{
			nullifyDependencies();

			super.disposeWithAllChildren();
		}

		/**
		 * @inheritDoc
		 */
		override public function onMessageBubbled(message:IMessage):Boolean
		{
			super.onMessageBubbled(message);

			handleBubbledMessage(message);

			return false;
		}

		private function handleBubbledMessage(message:IMessage):void
		{
			tryToExecuteCommand(message);

			if (message.target is IModel)
			{
				dispatchMessageToViews(message);
			}else
			if (message.target is IView)
			{
				dispatchMessageToViews(message);
				dispatchMessageToModels(message);
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function dispatchMessageToChildren(message:IMessage):void
		{
			super.dispatchMessageToChildren(message);

			tryToExecuteCommand(message);
		}

		/**
		 * @inheritDoc
		 */
		public function map(messageType:Enum, commandClass:Class):ICommandMapper
		{
			checkIfDisposed();

			return commandMapper.map(messageType, commandClass);
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(messageType:Enum, commandClass:Class):ICommandMapper
		{
			checkIfDisposed();

			return commandMapper.unmap(messageType, commandClass);
		}

		/**
		 * @inheritDoc
		 */
		public function clear():ICommandMapper
		{
			checkIfDisposed();

			return commandMapper.clear();
		}

		/**
		 * @inheritDoc
		 */
		public function unmapAll(messageType:Enum):ICommandMapper
		{
			checkIfDisposed();

			return commandMapper.unmapAll(messageType);
		}

		/**
		 * @inheritDoc
		 */
		public function hasMapping(messageType:Enum):Boolean
		{
			checkIfDisposed();

			return commandMapper.hasMapping(messageType);
		}

		/**
		 * @inheritDoc
		 */
		public function tryToExecuteCommand(message:IMessage):void
		{
			checkIfDisposed();

			commandMapper.tryToExecuteCommand(message);
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchMessageToViews(message:IMessage):void
		{
			checkIfDisposed();

			viewContainer.dispatchMessageToChildren(message);
		}

		/**
		 * @inheritDoc
		 */
		public function dispatchMessageToModels(message:IMessage):void
		{
			checkIfDisposed();

			modelContainer.dispatchMessageToChildren(message);
		}

		/**
		 * @inheritDoc
		 */
		public function executeCommand(commandClass:Class, data:Object = null):void
		{
			checkIfDisposed();

			commandMapper.executeCommand(commandClass, data);
		}

		private function checkIfDisposed():void
		{
			if (isDisposed)
			{
				throw new Error("Context already disposed!");
			}
		}
	}
}
