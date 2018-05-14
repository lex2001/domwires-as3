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
   public var sexBool:Boolean = true;
   public var maleString:String = "Male";
   public var femaleString:String = "Female";

    override public function execute():void {
        super.execute();
    if (sexBool) {
            sexBool = false;
            model.setSex(maleString);
        }
        else {
        sexBool = true;
        model.setSex(femaleString);
        }
    }
}
}

