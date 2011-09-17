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
	public class Entity implements IEntity {

		private var _entityManager:IEntityManager;
				
		public function Entity(entityManger:IEntityManager = null){
			this.entityManager = entityManger;
		}
		
		public function get entityManager():IEntityManager {
			return _entityManager;
		}

		public function set entityManager(value:IEntityManager):void {
			_entityManager = value;
		}
		
		public function initialize():void {
			
		}

		/**
		 * @inheritDoc
		 */
		public function addComponent(component:Object):void {
			return _entityManager.addComponent(this,component);
		}

		/**
		 * @inheritDoc
		 */
		public function getComponent(Component:Class):Object {
			return _entityManager.getComponent(this,Component);						
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponents():Dictionary {
			return _entityManager.getComponents(this);	
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(Component:Class):void {
			_entityManager.removeComponent(this,Component);
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			_entityManager.removeEntity(this);
		}

	}
}