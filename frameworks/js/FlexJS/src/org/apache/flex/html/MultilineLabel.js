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

goog.provide('org.apache.flex.html.MultilineLabel');

goog.require('org.apache.flex.core.UIBase');



/**
 * @constructor
 * @extends {org.apache.flex.core.UIBase}
 */
org.apache.flex.html.MultilineLabel = function() {
  org.apache.flex.html.MultilineLabel.base(this, 'constructor');

  this.element = document.createElement('div');
  this.positioner = this.element;
  this.element.flexjs_wrapper = this;
};
goog.inherits(org.apache.flex.html.MultilineLabel,
    org.apache.flex.core.UIBase);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.html.MultilineLabel.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'MultilineLabel',
                qName: 'org.apache.flex.html.MultilineLabel' }] };


/**
 * @expose
 * @return {string} The text getter.
 */
org.apache.flex.html.MultilineLabel.prototype.get_text = function() {
  return this.element.innerHTML;
};


/**
 * @expose
 * @param {string} value The text setter.
 */
org.apache.flex.html.MultilineLabel.prototype.set_text = function(value) {
  this.element.innerHTML = value;
};


/**
 * @expose
 * @return {string} The html getter.
 */
org.apache.flex.html.MultilineLabel.prototype.get_html = function() {
  return this.element.innerHTML;
};


/**
 * @expose
 * @param {string} value The html setter.
 */
org.apache.flex.html.MultilineLabel.prototype.set_html = function(value) {
  this.element.innerHTML = value;
};