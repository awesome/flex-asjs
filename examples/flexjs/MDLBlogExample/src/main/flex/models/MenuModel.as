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
package models
{
    import org.apache.flex.events.EventDispatcher;
    import org.apache.flex.events.IEventDispatcher;

    import vos.MenuItemVO;

    public class MenuModel extends EventDispatcher
    {
        private var _menuItems:Array = [
            new MenuItemVO("Some Action"),
            new MenuItemVO("Another Action", true),
            new MenuItemVO("More Action"),
            new MenuItemVO("Item Disabled", false, true)
        ];

        public function get menuItems():Array
        {
            return _menuItems;
        }
    }
}
