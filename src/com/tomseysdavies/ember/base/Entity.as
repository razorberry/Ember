/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.base{
		
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import flash.utils.Dictionary;
	
	
	/**
	 * this is just class that holds helper functions for convenience.
	 * @author Tom Davies
	 */
	internal class Entity implements IEntity{

		private var _entityManger:IEntityManager;
		private var _id:String;
				
		public function Entity(entityManger:IEntityManager,id:String){
			_entityManger = entityManger;
			_id = id;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addComponent(component:Object):void {
			return _entityManger.addComponent(_id,component);
		}

		/**
		 * @inheritDoc
		 */
		public function getComponent(Component:Class):* {
			return _entityManger.getComponent(_id,Component);						
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponents():Dictionary {
			return _entityManger.getComponents(_id);	
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(Component:Class):void {
			_entityManger.removeComponent(_id,Component);
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			_entityManger.removeEntity(_id);
		}
		
		/**
		 * @inheritDoc
		 */
		public function get id():String{
			return _id;
		}


	}
}