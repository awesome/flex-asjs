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
	import org.apache.flex.core.IImage;
	import org.apache.flex.core.IImageModel;
	import org.apache.flex.core.UIBase;
	
	/**
	 *  The ImageBase class serves as a base class for components that displays a bitmap. The Image uses
	 *  the following beads:
	 * 
	 *  org.apache.flex.core.IBeadModel: the data model for the Image, including the url/binary property.
	 *  org.apache.flex.core.IBeadView: constructs the visual elements of the component.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class ImageBase extends UIBase implements IImage
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function ImageBase()
		{
			super();
		}
		
		/**
		 *  The location of the bitmap, usually a URL.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
         *  @flexjsignorecoercion org.apache.flex.core.IImageModel
		 */
		public function get src():String
		{
			return (model as IImageModel).url;
		}
		public function set src(value:String):void
		{
			(model as IImageModel).url = value;
		}
		
		COMPILE::JS
		public function get imageElement():Element
		{
			return null;
			// override this
		}
		
		COMPILE::JS
		public function applyImageData(binaryDataAsString:String):void
		{
			// override this
		}
		
	}
}
