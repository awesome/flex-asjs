/*
 *
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

package org.apache.flex.flexjs.examples.helloworld;

import org.apache.flex.flexjs.examples.AbstractIT;
import org.junit.Assert;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

public class HelloWorldIT extends AbstractIT {

    @Override
    protected String getContext() {
        return "HelloWorld";
    }

    @Test
    public void testApplication() {
        initTest();
        WebElement element = driver.findElement(By.xpath(".//span[@class='Label']"));
        Assert.assertNotNull(element);
        String content = element.getText();
        Assert.assertEquals("Hello World!", content);
    }

}
