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
	import org.apache.flex.core.ITextModel;
	import org.apache.flex.core.UIBase;
    COMPILE::JS
    {
        import org.apache.flex.core.WrappedHTMLElement;            
    }
	
    /**
     *  The TextArea class implements the basic control for
     *  multi-line text input.
     *  
     *  @toplevel
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */    
	public class TextArea extends UIBase
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function TextArea()
		{
			super();
		}
		
        /**
         *  @copy org.apache.flex.html.Label#text
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         *  @flexjsignorecoercion HTMLInputElement
         */
		public function get text():String
		{
            COMPILE::SWF
            {
                return ITextModel(model).text;                    
            }
            COMPILE::JS
            {
                return (element as HTMLInputElement).value;
            }
		}

        /**
         *  @private
         *  @flexjsignorecoercion HTMLInputElement
         */
		public function set text(value:String):void
		{
            COMPILE::SWF
            {
                ITextModel(model).text = value;                    
            }
            COMPILE::JS
            {
                (element as HTMLInputElement).value = value;
            }
		}
		
        /**
         *  @copy org.apache.flex.html.Label#html
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		public function get html():String
		{
			return ITextModel(model).html;
		}

        /**
         *  @private
         */
		public function set html(value:String):void
		{
			ITextModel(model).html = value;
		}
		
        /**
         * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            element = document.createElement('textarea') as WrappedHTMLElement;
            positioner = element;
            positioner.style.position = 'relative';
            element.flexjs_wrapper = this;
            element.className = 'TextArea';
            typeNames = 'TextArea';
            
            return element;
        }        
	}
}
