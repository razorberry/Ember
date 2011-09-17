package com.tomseysdavies.ember.base
{
	import com.tomseysdavies.ember.core.IEntity;
	
	import flash.utils.Dictionary;

	public class Node
	{
		
		public var next:Node;
		public var previous:Node;
		public var entity:IEntity;
		
		public function Node(entity:IEntity,components:Dictionary)
		{
			this.entity = entity;
		}
		
		public function dispose():void{
			
		}

	}
}