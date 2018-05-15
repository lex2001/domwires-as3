/**
 * Created by Lex on 14.05.2018.
 */
package com.domwires.example.simplemvc.commands
{
	import com.domwires.core.mvc.command.AbstractCommand;
	import com.domwires.example.simplemvc.model.IAppModel;

	public class GenerateSexCommand extends AbstractCommand
	{
		[Autowired]
		public var model:IAppModel;

		private var isMale:Boolean = true;

		private const MALE:String = "Male";
		private const FEMALE:String = "Female";

		override public function execute():void
		{
			super.execute();

			if (isMale)
			{
				isMale = false;
				model.setSex(MALE);
			} else
			{
				isMale = true;
				model.setSex(FEMALE);
			}
		}
	}
}

