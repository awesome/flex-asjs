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
package org.apache.flex.express
{
	import org.apache.flex.events.Event;
	import org.apache.flex.html.TextButton;
	import org.apache.flex.html.beads.DisableBead;
	import org.apache.flex.html.accessories.ToolTipBead;

	/**
	 * This class extends TextButton and adds the toolTip bead
	 * as a convenience.
	 */
	public class TextButton extends org.apache.flex.html.TextButton
	{
		public function TextButton()
		{
			super();
		}
		
		private var _disableBead:DisableBead;
		private var _enabled:Boolean = true;
		private var _toolTipBead:ToolTipBead = null;
		
		[Bindable("enabledChanged")]
		/**
		 * Can enable or disable interaction with the control.
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			
			_disableBead = getBeadByType(DisableBead) as DisableBead;
			
			if (_disableBead == null) {
				_disableBead = new DisableBead();
				addBead(_disableBead);
			}
			
			_disableBead.disabled = !value;
				
			dispatchEvent(new Event("enabledChanged"));
		}
		
		[Bindable("toolTipChanged")]
		/**
		 * Displays a hint when the mouse hovers over the button
		 */
		public function get toolTip():String
		{
			if (_toolTipBead) {
				return _toolTipBead.toolTip;
			}
			else {
				return null;
			}
		}
		public function set toolTip(value:String):void
		{
			_toolTipBead = getBeadByType(ToolTipBead) as ToolTipBead;
			
			if (_toolTipBead == null) {
				_toolTipBead = new ToolTipBead();
				addBead(_toolTipBead);
			}
			_toolTipBead.toolTip = value;
			
			dispatchEvent(new Event("toolTipChanged"));
		}
	}
}