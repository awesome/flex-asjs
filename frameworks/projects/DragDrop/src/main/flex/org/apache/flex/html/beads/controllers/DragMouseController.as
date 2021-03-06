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
package org.apache.flex.html.beads.controllers
{
	
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IDragInitiator;
    import org.apache.flex.core.IPopUpHost;
	import org.apache.flex.core.IStrand;
    import org.apache.flex.core.IUIBase;
	import org.apache.flex.events.DragEvent;
	import org.apache.flex.events.EventDispatcher;
	import org.apache.flex.events.IEventDispatcher;
    import org.apache.flex.events.MouseEvent;
    import org.apache.flex.geom.Point;
	import org.apache.flex.utils.PointUtils;
    import org.apache.flex.utils.UIUtils;
	
    /**
     *  Indicates that a drag/drop operation is starting.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
    [Event(name="dragStart", type="org.apache.flex.events.DragEvent")]
    
    /**
     *  Indicates that the mouse is moving during
     *  a drag/drop operation.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
    [Event(name="dragMove", type="org.apache.flex.events.DragEvent")]
    
    /**
     *  Indicates that a drag/drop operation is ending.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
    [Event(name="dragEnd", type="org.apache.flex.events.DragEvent")]
    
	/**
	 *  The DragMouseController bead handles mouse events on the 
	 *  a component, looking for activity that constitutes the start
     *  of a drag drop operation.
	 *  
     *  @flexjsignoreimport org.apache.flex.core.IDragInitiator
     *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class DragMouseController extends EventDispatcher implements IBead
	{
        /**
         *  Whether there is a drag operation
         *  in progress.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public static var dragging:Boolean = false;
        
        /**
         *  The drag image.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public static var dragImage:IUIBase;
        
        /**
         *  The offset of the drag image.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public static var dragImageOffsetX:Number = 0;
        
        /**
         *  The offset of the drag image.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public static var dragImageOffsetY:Number = 0;
        
        /**
         *  The default movement in x and or y that
         *  means a drag should start
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public static var defaultThreshold:int = 4;
        
		/**
		 *  constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function DragMouseController()
		{
            threshold = defaultThreshold;
		}
		
        /**
         *  The movement in x and or y that
         *  means a drag should start
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public var threshold:int = 4;
        
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
			
            IEventDispatcher(_strand).addEventListener(MouseEvent.MOUSE_DOWN, dragMouseDownHandler);
		}
		
		public function get strand():IStrand
		{
			return _strand;
		}
        
        private var mouseDownX:Number;
        private var mouseDownY:Number;
        
        private var host:IPopUpHost;
        
        /**
         *  @private
         */
        private function dragMouseDownHandler(event:MouseEvent):void
        {
            trace("dragMouseDown");
            IUIBase(_strand).topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_MOVE, dragMouseMoveHandler);
            IUIBase(_strand).topMostEventDispatcher.addEventListener(MouseEvent.MOUSE_UP, dragMouseUpHandler);
            mouseDownX = event.screenX;
            mouseDownY = event.screenY;
            event.preventDefault();
        }
        
        private function dragMouseMoveHandler(event:MouseEvent):void
        {
            var pt:Point;
            var dragEvent:DragEvent;
            trace("dragMouseMove");
            
            event.preventDefault();
            
            if (!dragging)
            {
                trace("not dragging anything else");
                if (Math.abs(event.screenX - mouseDownX) > threshold ||
                    Math.abs(event.screenY - mouseDownY) > threshold)
                {
                    trace("sending dragStart");
                    dragEvent = DragEvent.createDragEvent("dragStart", event);
                    DragEvent.dispatchDragEvent(dragEvent, _strand);
                    if (DragEvent.dragSource != null)
                    {
                        dragging = true;
                        host = UIUtils.findPopUpHost(_strand as IUIBase);
                        host.addElement(dragImage);
                        pt = PointUtils.globalToLocal(new Point(event.clientX, event.clientY), host);
                        dragImage.x = pt.x + dragImageOffsetX;
                        dragImage.y = pt.y + dragImageOffsetY;
                    }
                }
            }
            else
            {
                trace("sending dragMove " + event.target.toString());
                dragEvent = DragEvent.createDragEvent("dragMove", event);
                trace("client: " + event.clientX.toString() + " " + event.clientY.toString() + " " + event.target.toString());
                pt = PointUtils.globalToLocal(new Point(event.clientX, event.clientY), host);
                trace("host: " + pt.x.toString() + " " + pt.y.toString());
                dragImage.x = pt.x + dragImageOffsetX;
                dragImage.y = pt.y + dragImageOffsetY;
                DragEvent.dispatchDragEvent(dragEvent, event.target);
            }
        }
        
        private function dragMouseUpHandler(event:MouseEvent):void
        {
            trace("dragMouseUp");
            var dragEvent:DragEvent;
            
            if (dragging)
            {
                trace("sending dragEnd");
                dragEvent = DragEvent.createDragEvent("dragEnd", event);
                DragEvent.dispatchDragEvent(dragEvent, event.target);
                event.preventDefault();
            }
            dragging = false;
            DragEvent.dragSource = null;
            DragEvent.dragInitiator = null;
            if (dragImage && host)
                host.removeElement(dragImage);
            dragImage = null;
            IUIBase(_strand).topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, dragMouseMoveHandler);
            IUIBase(_strand).topMostEventDispatcher.removeEventListener(MouseEvent.MOUSE_UP, dragMouseUpHandler);			
        }
		
	}
}
