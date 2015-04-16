/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.provide('org_apache_flex_geom_Point');



/**
 * @constructor
 * @param {number} x
 * @param {number} y
 */
org_apache_flex_geom_Point = function(x, y) {

  this.x = x;

  this.y = y;

};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org_apache_flex_geom_Point.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'Point',
                qName: 'org_apache_flex_geom_Point'}] };


/**
 * @expose
 * The x coordinate.
 * @type {number} value The x coordinate.
 */
org_apache_flex_geom_Point.prototype.x = 0;


/**
 * @expose
 * The y coordinate.
 * @type {number} value The y coordinate.
 */
org_apache_flex_geom_Point.prototype.y = 0;