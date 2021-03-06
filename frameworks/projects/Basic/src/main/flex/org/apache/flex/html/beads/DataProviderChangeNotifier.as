////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.html.beads
{
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IBeadModel;
	import org.apache.flex.core.IDocument;
	import org.apache.flex.core.ISelectionModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.events.Event;
	import org.apache.flex.collections.ArrayList;
	
	/**
	 *  The DataProviderChangeNotifier notifies listeners when a selection model's
	 *  ArrayList dataProvider has changed.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class DataProviderChangeNotifier implements IBead, IDocument
	{
		/**
		 *  constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function DataProviderChangeNotifier()
		{
		}
		
		protected var _dataProvider:ArrayList;
		
		private var _strand:IStrand;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			if (_strand[destinationPropertyName] == null) {
				var model:IBeadModel = UIBase(_strand).model as IBeadModel;
				IEventDispatcher(model).addEventListener(changeEventName, destinationChangedHandler);
			}
			else {
				destinationChangedHandler(null);
			}
		}
		
		private function destinationChangedHandler(event:Event):void
		{
			if (_dataProvider == null) {
				var object:Object = document[sourceID];
				_dataProvider = object[propertyName] as ArrayList;
			}
			else {
				_dataProvider.removeEventListener("itemAdded", handleItemAdded);
				_dataProvider.removeEventListener("itemRemoved", handleItemRemoved);
				_dataProvider.removeEventListener("itemUpdated", handleItemUpdated);
			}
			
			_dataProvider.addEventListener("itemAdded", handleItemAdded);
			_dataProvider.addEventListener("itemRemoved", handleItemRemoved);
			_dataProvider.addEventListener("itemUpdated", handleItemUpdated);
		}
		
		protected var document:Object;
		
		/**
		 * @private
		 */
		public function setDocument(document:Object, id:String = null):void
		{
			this.document = document;
		}
		
		private var _destinationPropertyName:String;
		
		public function get destinationPropertyName():String
		{
			return _destinationPropertyName;
		}
		public function set destinationPropertyName(value:String):void
		{
			_destinationPropertyName = value;
		}
		
		private var _changeEventName:String;
		
		public function get changeEventName():String
		{
			return _changeEventName;
		}
		public function set changeEventName(value:String):void
		{
			_changeEventName = value;
		}
		
		private var _sourceID:String;
		
		/**
		 *  The ID of the object holding the ArrayList, usually a model.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function get sourceID():String
		{
			return _sourceID;
		}
		public function set sourceID(value:String):void
		{
			_sourceID = value;
		}
		
		private var _propertyName:String;
		
		/**
		 *  The property in the sourceID that is the ArrayList.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function get propertyName():String
		{
			return _propertyName;
		}
		
		public function set propertyName(value:String):void
		{
			_propertyName = value;
		}
		
		/**
		 * @private
		 */
		private function handleItemAdded(event:Event):void
		{
			var selectionModel:ISelectionModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			selectionModel.dispatchEvent(new Event("dataProviderChanged"));
		}
		
		/**
		 * @private
		 */
		private function handleItemRemoved(event:Event):void
		{
			var selectionModel:ISelectionModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			selectionModel.dispatchEvent(new Event("dataProviderChanged"));
		}
		
		/**
		 * @private
		 */
		private function handleItemUpdated(event:Event):void
		{
			var selectionModel:ISelectionModel = _strand.getBeadByType(ISelectionModel) as ISelectionModel;
			selectionModel.dispatchEvent(new Event("dataProviderChanged"));
		}
	}
}
