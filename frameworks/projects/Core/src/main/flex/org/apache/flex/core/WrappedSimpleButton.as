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
package org.apache.flex.core
{
    COMPILE::SWF
    {
        import flash.display.DisplayObject;
        import flash.display.SimpleButton;            
    }

	COMPILE::SWF
	public class WrappedSimpleButton extends SimpleButton implements IFlexJSElement, IRenderedObject
	{
        public function WrappedSimpleButton(upState:DisplayObject = null, overState:DisplayObject = null, downState:DisplayObject = null, hitTestState:DisplayObject = null)
        {
            super(upState, overState, downState, hitTestState)

        }

        private var _flexjs_wrapper:Object;
        
        //--------------------------------------
        //   Property
        //--------------------------------------
        
        /**
         *  A pointer back to the instance that wrapped this element.
         * 
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function get flexjs_wrapper():Object
        {
            return _flexjs_wrapper;
        }
        public function set flexjs_wrapper(value:Object):void
        {
            _flexjs_wrapper = value;
        }
		
		public function get $displayObject():DisplayObject
		{
			return this;
		}
		
	}
}
