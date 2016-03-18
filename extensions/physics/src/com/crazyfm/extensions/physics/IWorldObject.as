/**
 * Created by Anton Nefjodov on 11.03.2016.
 */
package com.crazyfm.extensions.physics
{
	import com.crazyfm.extensions.physics.vo.WorldDataVo;

	import nape.space.Space;

	public interface IWorldObject
	{
		function set data(value:WorldDataVo):void;
		function get data():WorldDataVo;
		function get bodyObjectList():Vector.<IBodyObject>;
		function get jointObjectList():Vector.<IJointObject>;
		function bodyObjectById(id:String):IBodyObject;
		function jointObjectById(id:String):IJointObject;
		function get space():Space;
	}
}
