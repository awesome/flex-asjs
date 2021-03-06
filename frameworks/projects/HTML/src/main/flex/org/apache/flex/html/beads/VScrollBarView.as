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
	
    import org.apache.flex.core.IBead;
	import org.apache.flex.core.IBeadLayout;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IScrollBarModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.IUIBase;
	import org.apache.flex.core.Strand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.core.ValuesManager;
    import org.apache.flex.events.IEventDispatcher;
    import org.apache.flex.events.Event;
	import org.apache.flex.html.Button;
	import org.apache.flex.html.beads.controllers.ButtonAutoRepeatController;

    /**
     *  The ScrollBarView class is the default view for
     *  the org.apache.flex.html.supportClasses.VScrollBar class.
     *  It implements the classic desktop-like VScrollBar.
     *  A different view would implement more modern scrollbars that hide themselves
     *  until hovered over with the mouse.
     *  
	 *  @viewbead
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
	public class VScrollBarView extends ScrollBarView implements IBeadView, IStrand, IScrollBarView
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function VScrollBarView()
		{
		}

        /**
         *  The default step size for up and down arrows as a divisor
         *  to the height of the scroll bar.  In other words, if
         *  STEP_RATE is set to 20, then it will take 20 clicks on
         *  the thumb to move the bottom of the screen to the top.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public static var STEP_RATE:int = 20;
        
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
			
            var v:UIBase = UIBase(value);
			v.setWidth(ScrollBarView.FullSize, true);
            
            // TODO: (aharui) put in values impl
			_increment = new Button();

			_increment.addBead(new DownArrowButtonView());
            _increment.addBead(new ButtonAutoRepeatController());
			_decrement = new Button();
			_decrement.addBead(new UpArrowButtonView());
            _decrement.addBead(new ButtonAutoRepeatController());
			_track = new Button();				
			_track.addBead(new VScrollBarTrackView());
			_thumb = new Button();				
			_thumb.addBead(new VScrollBarThumbView());
            
            v.$sprite.addChild(_decrement.$button);
            v.$sprite.addChild(_increment.$button);
            v.$sprite.addChild(_track.$button);
            v.$sprite.addChild(_thumb.$button);
            
            IEventDispatcher(_strand).addEventListener("heightChanged", changeHandler);
            
            layout.layout();
		}
        
        override protected function changeHandler(event:Event):void
        {
            layout.layout();
            sbModel = host.getBeadByType(IScrollBarModel) as IScrollBarModel;
            sbModel.stepSize = Math.max(Math.round(host.height / STEP_RATE), 1);
        }

	}
}
