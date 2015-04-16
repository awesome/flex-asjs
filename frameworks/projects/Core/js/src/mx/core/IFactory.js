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

/**
 * @fileoverview
 * @suppress {checkTypes}
 */

goog.provide('mx_core_IFactory');



/**
 * @interface
 */
mx_core_IFactory = function() {
};


/**
 * @expose
 * @return {Object} A new instance of the itemRenderer.
 */
mx_core_IFactory.prototype.newInstance = function() {};


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
mx_core_IFactory.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'IFactory',
                qName: 'mx_core_IFactory' }] };