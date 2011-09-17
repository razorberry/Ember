/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.base {
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * manages the relations between components and entites and keeps entity families upto date.
	 * @author Tom Davies
	 */
	public class EntityManager implements IEntityManager {
		
		private var _entityMap:Dictionary;
		private var _families:Dictionary;
		private var _componentFamilyMap:Dictionary;
		
		public function EntityManager() {
			_entityMap = new Dictionary(false);
			_families = new Dictionary(true);
			_componentFamilyMap = new Dictionary(true);
		}
		
		//---------------------------------------------------------------------
		// API
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function createEntity():IEntity{
			// TODO: Entities don't really need a reference to their manager.
			var entity:IEntity = new Entity(this);
			_entityMap[entity] = new Dictionary(true);
			return entity;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasEntity(entity:IEntity):Boolean
		{
			return (_entityMap[entity]);
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEntity(entity:IEntity):void {
			
			if(!hasEntity(entity)){
				throw new Error("Entity not found in Entity Manager");
			}
			for each(var component:Object in _entityMap[entity]){				
				removeEntityFromFamilies(entity,getClass(component));
			}
			delete _entityMap[entity];
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll():void {
			for(var o:Object in _entityMap){
				removeEntity(o as IEntity);
			}
		}
				
		
		/**
		 * @inheritDoc
		 */
		public function addComponent(entity:IEntity,component:Object):void{
			if(!hasEntity(entity)){
				throw new Error("Entity not found in Entity Manager");
			}
			var Component:Class = getClass(component);			
			_entityMap[entity][Component] = component;
			addEntityToFamilies(entity,Component);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponent(entity:IEntity,Component:Class):Object {
			var component:Object = _entityMap[entity][Component] as Object;
			if(!component){
				if(!hasEntity(entity)){
					throw new Error("Entity not found in Entity Manager");
				}else{
					throw new Error("Component " + Component + " not found on entity ");
				}				
			}else{
				return component;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getComponents(entity:IEntity):Dictionary{
			return _entityMap[entity];
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeComponent(entity:IEntity,Component:Class):void{
			removeEntityFromFamilies(entity,Component);
			delete _entityMap[entity][Component];
		}
		
		/**
		 * @inheritDoc
		 */
		public function getEntityFamily(Node:Class):IFamily{
			return getFamily(Node);
		}
			
		/**
		 * @inheritDoc
		 */
		public function dispose():void {
			_entityMap = null;	
			for each(var family:IFamily in _families){
				family.dispose();
			}
			_families = null;
			_componentFamilyMap = null;
		}
		
		//---------------------------------------------------------------------
		// Internal
		//---------------------------------------------------------------------

		/**
		 * gets all Entities with specifed Components
		 */ 
		private function populateFamily(family:IFamily,Components:Array):void{
			for(var o:Object in _entityMap){
				var entity:IEntity = o as IEntity;
				if(hasAllComponents(entity,Components)){
					family.add(entity,_entityMap[entity]);
				}
			}
		}
		
		/**
		 * checks if a entity has a set of Components
		 */ 
		private function hasAllComponents(entity:IEntity,Components:Array):Boolean{
			for each(var Component:Class in Components){
				if(!_entityMap[entity][Component]){
					return false;
				}	
			}
			return true;
		}
		
		/**
		 * updates families when a component is added to an entity
		 */ 
		private function addEntityToFamilies(entity:IEntity,Component:Class):void{
			var families:Vector.<Array> = getFamiliesWithComponent(Component);				
			for each(var Components:Array in families){
				if(hasAllComponents(entity,Components)){
					_families[Components].add(entity,_entityMap[entity]);
				}
			}
		}		
		
		/**
		 * updates families when a component is removed from an entity
		 */ 
		private function removeEntityFromFamilies(entity:IEntity,Component:Class):void{		
			for each(var Components:Array in getFamiliesWithComponent(Component)){
				_families[Components].remove(entity);
			}
		}
		
		private function removeFamily(Components:Array):void{
			_families[Components].dispose();
			delete _families[Components];
			
			for each(var familyRefList:Vector.<Array> in _componentFamilyMap){
				var i:int = familyRefList.length;
				while (--i >= 0) {
					if (familyRefList[i] == Components) {
						familyRefList.splice(i, 1);
					}
				}
			}
		}
		
		/**
		 * gets class name from instance
		 */
		private function getClass(obj:Object):Class{
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}
			
		/**
		 * retrieves a list of Families with Component or creates a new one
		 */
		private function getFamiliesWithComponent(Component:Class):Vector.<Array>{
			return _componentFamilyMap[Component] ||= new Vector.<Array>();
		}
		
		/**
		 * retrieves an existing Family with set of Components or creates a new one
		 */
		private function getFamily(Node:Class):IFamily{
			return _families[Node.componentClasses] ||= newFamily(Node,Node.componentClasses);
		}
		
		/**
		 * creates a new family and updates references
		 */
		private function newFamily(Node:Class,components:Array):IFamily{
			for each(var Component:Class in components){
				getFamiliesWithComponent(Component).push(components);
			}
			var family:Family = new Family(Node);
			populateFamily(family,components)
			return family;
		}

	}
	
}