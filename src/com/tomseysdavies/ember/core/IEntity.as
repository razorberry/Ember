/*
* Copyright (c) 2010 Tom Davies
*
* Permission is hereby granted to use, modify, and distribute this file
* in accordance with the terms of the license agreement accompanying it.
*/

package com.tomseysdavies.ember.core{
	import flash.utils.Dictionary;
	
	public interface IEntity extends IDisposable{
		
		function initialize():void;
		function get entityManager():IEntityManager;
		function set entityManager(manager:IEntityManager):void;
		
		/**
		 * registers a compoment with the entity
		 * 
		 * @param component to be added
		 * 
		 */		
		function addComponent(component:Object):void;
		
		/**
		 * retrieves a components instance based on class name
		 * 
		 * @param Component class name of component to be retrieved
		 * 
		 */	
		function getComponent(Component:Class):Object;
		
		
		/**
		 * retrieves the dictionary contaning all the entities components
		 * 
		 * @return a dictionary of the entites components with the component Class as the key
		 * 
		 */	
		function getComponents():Dictionary;
		
		/**
		 * unregisterers a component from the entity
		 * 
		 * @param Component class name of component to be unregistered
		 * 
		 */	
		function removeComponent(Component:Class):void;
	}
}