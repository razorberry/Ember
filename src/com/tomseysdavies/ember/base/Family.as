package com.tomseysdavies.ember.base
{
	import com.tomseysdavies.ember.core.IEntity;
	import com.tomseysdavies.ember.core.IEntityManager;
	import com.tomseysdavies.ember.core.IFamily;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	final public class Family implements IFamily
	{

		private const ENTITY_ADDED:Signal = new Signal(String);
		private const ENTITY_REMOVED:Signal = new Signal(String);
		private var _last:Node;
		private var _first:Node;
		private var _nodeMap:Dictionary;
		private var _currentNode:Node;
		private var _Node:Class;
		private var _hasNext:Boolean
		
		public function Family(Node:Class)
		{
			_Node = Node;
			_nodeMap = new Dictionary(true);
		}
				
		/**
		 * @inheritDoc
		 */
		public function get entityAdded():Signal{
			return ENTITY_ADDED;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get entityRemoved():Signal{
			return ENTITY_REMOVED;
		}
				
		/**
		 * @inheritDoc
		 */
		public function add(entity:IEntity,components:Dictionary):void{
			var node:Node = new _Node(entity,components);
			if(_first){
				_last.next = node;
				node.previous = _last;
			}else{				
				_first = node;
			}
			_last = node;
			_nodeMap[entity] = node;
			entityAdded.dispatch(entity);
		}
		
		public function remove(entity:IEntity):void{
			entityRemoved.dispatch(entity);
			var node:Node = _nodeMap[entity];
			if(!node) return;
			
			if(node.previous){
				node.previous.next = node.next;
			}else{
				_first = node.next;			
			}
			if(node.next){
				node.next.previous = node.previous;	
			}else{
				_last = node.previous;		
			}
			updateNode(node.next);
			node.next = node.previous = null;
			node.entity = null;
			node.dispose();
			delete _nodeMap[entity];
			
		}
		
		public function start():void{
			updateNode(_first);
		}
		
		public function next():IEntity {
			return updateNode(_currentNode ? _currentNode.next : null);
		}
		
		public function get hasNext():Boolean{
			return _hasNext;
		}
		
		private function updateNode(node:Node):IEntity {
			_currentNode = node;
			_hasNext = (_currentNode != null);
			return currentEntity;
		}
				
		public function get empty():Boolean{
			return (!_first);
		}
		
		public function get currentEntity():IEntity{
			return _currentNode.entity;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose():void{
			ENTITY_ADDED.removeAll();
			ENTITY_REMOVED.removeAll();
		}
	}
}