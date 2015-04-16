/**
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.provide('org_apache_flex_html5_List');

goog.require('org_apache_flex_core_ListBase');



/**
 * @constructor
 * @extends {org_apache_flex_core_ListBase}
 */
org_apache_flex_html5_List = function() {
  org_apache_flex_html5_List.base(this, 'constructor');
};
goog.inherits(org_apache_flex_html5_List,
    org_apache_flex_core_ListBase);


/**
 * @override
 */
org_apache_flex_html5_List.prototype.createElement =
    function() {
  org_apache_flex_html5_List.base(this, 'createElement');

  this.element.size = 5;

  return this.element;
};