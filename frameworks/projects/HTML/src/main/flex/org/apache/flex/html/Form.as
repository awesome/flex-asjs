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
package org.apache.flex.html
{
    import org.apache.flex.core.ContainerBase;
    
    COMPILE::JS
    {
        import org.apache.flex.core.WrappedHTMLElement;
    }
    
    [DefaultProperty("mxmlContent")]

    /**
     *  The Form class is a simple form.
     *  
     *  @toplevel
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
    public class Form extends ContainerBase
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function Form()
        {
            super();
        }
        
        /**
         * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {HTMLFormElement
            element = document.createElement('form') as WrappedHTMLElement;
             
            positioner = element;
             
            positioner.style.position = 'relative';
            element.flexjs_wrapper = this;
            return element;
        }

        
        private var _action:String = "#";

        [Bindable("actionChange")]
        /**
         *  The action to be performed when the form is submitted
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
        public function get action():String
        {
            return _action;
        }

        /**
         *  @private
         */
        public function set action(value:String):void
        {
            _action = value;

            COMPILE::JS
            {
                this.element.setAttribute('action', action);
                this.dispatchEvent('actionChange');
            }
        }
    }        
}