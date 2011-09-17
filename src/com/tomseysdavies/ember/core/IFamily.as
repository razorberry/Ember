package com.tomseysdavies.ember.core
{
	import com.tomseysdavies.ember.base.Node;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;

	public interface IFamily extends IDisposable
	{
		function remove(entity:IEntity):void
		/**
		 *signal that is dispached when entity is added to family. 
		 *
		 */	
		function get entityAdded():Signal;
		/**
		 *signal that is dispached when entity is remove from family.
		 *payload is the entity added
		 */	
		function get entityRemoved():Signal;
		/**
		 *the number of entities in the family
		 *payload is families components
		 */	
		function get empty():Boolean;
		
		function add(entiy:IEntity,components:Dictionary):void;
		function get first():Node;
		function get last():Node;
		function start():void;
		function next():void;
		function get hasNext():Boolean;
		function get currentNode():*;

	}
}