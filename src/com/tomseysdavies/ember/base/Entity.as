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
				
		public function Entity(entityManger:IEntityManager){
			_entityManger = entityManger;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addComponent(component:Object):void {
			return _entityManger.addComponent(this,component);
		}

		/**
		 * @inheritDoc
		 */
		public function getComponent(Component:Class):Object {
			return _entityManger.getComponent(this,Component);						
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponents():Dictionary {
			return _entityManger.getComponents(this);	
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(Component:Class):void {
			_entityManger.removeComponent(this,Component);
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			_entityManger.removeEntity(this);
		}

	}
}