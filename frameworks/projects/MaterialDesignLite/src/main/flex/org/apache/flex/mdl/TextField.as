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
package org.apache.flex.mdl
{
	import org.apache.flex.events.Event;

    import org.apache.flex.mdl.supportClasses.TextFieldBase;

    COMPILE::JS
    {
        import goog.events;
        import org.apache.flex.core.WrappedHTMLElement;            
    }
    
    /**
     *  The TextField is a input components.
     *
     *  The Material Design Lite (MDL) text field component is an enhanced version
     *  of the standard HTML <input type="text"> elements.
     *  A text field consists of a horizontal line indicating where keyboard input can
     *  occur and, typically, text that clearly communicates the intended contents of
     *  the text field. The MDL text field component provides various types of text fields,
     *  and allows you to add both display and click effects.
     *
     *  To get more functionaluty in TextFields you can use beads to make the expandable,
     *  or have a prompt for example.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */    
	public class TextField extends TextFieldBase
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
		public function TextField()
		{
			super();

            className = ""; //set to empty string avoid 'undefined' output when no class selector is assigned by user;
		}

        /**
         * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         * @flexjsignorecoercion HTMLDivElement
         * @flexjsignorecoercion HTMLInputElement
         * @flexjsignorecoercion HTMLLabelElement
         * @flexjsignorecoercion Text
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            typeNames = "mdl-textfield mdl-js-textfield";

            var div:HTMLDivElement = document.createElement('div') as HTMLDivElement;
            div.className = typeNames;

            input = document.createElement('input') as HTMLInputElement;
            input.setAttribute('type', 'text');
            input.className = "mdl-textfield__input";
            
            //attach input handler to dispatch flexjs change event when user write in textinput
            //goog.events.listen(element, 'change', killChangeHandler);
            goog.events.listen(input, 'input', textChangeHandler);
            
            label = document.createElement('label') as HTMLLabelElement;
            label.className = "mdl-textfield__label";

            textNode = document.createTextNode('') as Text;
            label.appendChild(textNode);
            
            div.appendChild(input);
            div.appendChild(label);

            element = input as WrappedHTMLElement;

            positioner = div as WrappedHTMLElement;
            (input as WrappedHTMLElement).flexjs_wrapper = this;
            (label as WrappedHTMLElement).flexjs_wrapper = this;
            element.flexjs_wrapper = this;
            
            return element;
        }
	}
}
