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
package org.apache.flex.mobile.beads
{
	import org.apache.flex.core.IBeadModel;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.IUIBase;
	import org.apache.flex.core.IViewportModel;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.events.Event;
	import org.apache.flex.html.Container;
	import org.apache.flex.html.beads.layouts.HorizontalLayout;
	import org.apache.flex.mobile.IViewManagerView;
	import org.apache.flex.mobile.chrome.NavigationBar;
	import org.apache.flex.mobile.models.ViewManagerModel;
	
	/**
	 * The ViewManagerViewBase creates the visual elements of the StackedViewManager. This
	 * includes a NavigationBar, ToolBar, and contentArea.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class ViewManagerViewBase implements IBeadView
	{
		/**
		 * Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function ViewManagerViewBase()
		{
			super();
		}
		
		public function get host():IUIBase
		{
			return _strand as IUIBase;
		}
		public function set host(value:IUIBase):void
		{
			// not implemented; getter only.
		}
		
		private var _navigationBar:NavigationBar;
		public function get navigationBar():NavigationBar
		{
			return _navigationBar;
		}
		public function set navigationBar(value:NavigationBar):void
		{
			// not implemented; getter only.
		}
		
		private var _strand:IStrand;
		public function get strand():IStrand
		{
			return _strand;
		}
		public function set strand(value:IStrand):void
		{
			_strand = value;
			UIBase(_strand).addEventListener("sizeChanged", sizeChangedHandler);
			UIBase(_strand).addEventListener("widthChanged", sizeChangedHandler);
			UIBase(_strand).addEventListener("heightChanged", sizeChangedHandler);
			
			var model:ViewManagerModel = value.getBeadByType(IBeadModel) as ViewManagerModel;
			model.addEventListener("selectedIndexChanged", viewsChangedHandler);

			if (model.navigationBarItems)
			{
				_navigationBar = new NavigationBar();
				_navigationBar.controls = model.navigationBarItems;
				_navigationBar.addBead(new HorizontalLayout());
				UIBase(_strand).addElement(_navigationBar, false);
			}
		}
		
		/**
		 * @private
		 */
		protected function viewsChangedHandler(event:Event):void
		{
			layoutChromeElements();
		}
		
		/**
		 * @private
		 */
		protected function sizeChangedHandler(event:Event):void
		{
			layoutChromeElements();
		}
		
		/**
		 * @private
		 */
		protected function layoutChromeElements():void
		{
			var host:UIBase = _strand as UIBase;
			var contentAreaY:Number = 0;
			var contentAreaHeight:Number = host.height;
			
			var model:ViewManagerModel = _strand.getBeadByType(IBeadModel) as ViewManagerModel;
			
			if (_navigationBar)
			{
				_navigationBar.x = 0;
				_navigationBar.y = 0;
				_navigationBar.width = host.width;
				
				contentAreaHeight -= _navigationBar.height;
				contentAreaY = _navigationBar.height;
				
				model.navigationBar = _navigationBar;
			}
			
			model.contentX = 0;
			model.contentY = contentAreaY;
			model.contentWidth = host.width;
			model.contentHeight = contentAreaHeight;
			
			sizeViewsToFitContentArea();
		}
		
		protected function sizeViewsToFitContentArea():void
		{
			var model:ViewManagerModel = _strand.getBeadByType(IBeadModel) as ViewManagerModel;
			
			var n:int = ViewManagerModel(model).views.length;
			if (n > 0) {
				for (var i:int = 0; i < n; i++)
				{
					var view:IViewManagerView = ViewManagerModel(model).views[i] as IViewManagerView;
					UIBase(view).x = model.contentX;
					UIBase(view).y = model.contentY;
					UIBase(view).setWidthAndHeight(model.contentWidth, model.contentHeight, true);
				}
			}
		}
	}
}
