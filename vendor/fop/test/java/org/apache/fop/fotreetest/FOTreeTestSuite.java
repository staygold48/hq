/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* $Id: FOTreeTestSuite.java 1296104 2012-03-02 09:50:50Z phancock $ */

package org.apache.fop.fotreetest;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

/**
 * JUnit test suit for running layout engine test under JUnit control.
 */
@RunWith(Suite.class)
@Suite.SuiteClasses({
        org.apache.fop.fo.flow.table.AllTests.class,
        org.apache.fop.fo.pagination.AllTests.class,
        org.apache.fop.fotreetest.FOTreeTestCase.class,
        org.apache.fop.fo.properties.CommonAccessibilityHolderTestCase.class,
        org.apache.fop.fo.DelegatingFOEventHandlerTestCase.class
})
public final class FOTreeTestSuite {

}
