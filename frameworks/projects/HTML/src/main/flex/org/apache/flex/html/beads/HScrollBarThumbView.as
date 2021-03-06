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
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	
	import org.apache.flex.core.BeadViewBase;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IChild;
	import org.apache.flex.core.IStrand;
    import org.apache.flex.core.IUIBase;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.html.supportClasses.ScrollBar;
	
    /**
     *  The HScrollBarThumbView class is the view for
     *  the thumb button in a Horizontal ScrollBar.
     *  
	 *  @viewbead
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
	public class HScrollBarThumbView extends BeadViewBase implements IBeadView
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function HScrollBarThumbView()
		{
		}
		
		private function drawView(g:Graphics, bgColor:uint):void
		{
            var ww:Number = IUIBase(_strand).width;
            g.clear();
			g.lineStyle(1);
			g.beginFill(bgColor);
			g.drawRoundRect(0, 0, ww, ScrollBarView.FullSize, ScrollBarView.HalfSize);
			g.endFill();
		}
		
		private var shape:Shape;
		
        /**
         *  @copy org.apache.flex.core.IBead#strand
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
            
            upView = new Shape();
            downView = new Shape();
            overView = new Shape();
            
            drawView(upView.graphics, 0xc8c8c8);
            drawView(downView.graphics, 0xc8c8c8);
            drawView(overView.graphics, 0xb8b8b8);

            shape = new Shape();
			shape.graphics.beginFill(0xCCCCCC);
			shape.graphics.drawRect(0, 0, ScrollBarView.FullSize, ScrollBarView.FullSize);
			shape.graphics.endFill();
            var button:SimpleButton = IChild(value).$displayObject as SimpleButton;
			button.upState = upView;
			button.downState = downView;
			button.overState = overView;
			button.hitTestState = shape;
            IEventDispatcher(_strand).addEventListener("widthChanged", widthChangedHandler);
		}

        private function widthChangedHandler(event:Event):void
        {
            var button:SimpleButton = IChild(_strand).$displayObject as SimpleButton;
			button.scaleY = 1.0;
			button.scaleX = 1.0;
			
            var ww:Number = button.width;
            drawView(upView.graphics, 0xc8c8c8);
            drawView(downView.graphics, 0xc8c8c8);
            drawView(overView.graphics, 0xb8b8b8);
            
            shape.graphics.clear();
            shape.graphics.beginFill(0xCCCCCC);
            shape.graphics.drawRect(0, 0, ww, ScrollBarView.FullSize);
            shape.graphics.endFill();
        }
        
		private var upView:Shape;
		private var downView:Shape;
		private var overView:Shape;
		
	}
}
