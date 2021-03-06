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

/* $Id: PDFFactoryTestCase.java 1233854 2012-01-20 10:39:42Z cbowditch $ */

package org.apache.fop.pdf;

import static org.junit.Assert.assertEquals;

import org.apache.fop.fonts.CIDSubset;
import org.apache.fop.fonts.MultiByteFont;
import org.junit.Test;

/**
 * Test case for {@link PDFFactory}.
 */
public class PDFFactoryTestCase {

    /**
     * This tests that when a font is subset embedded in a PDF, the font name is prefixed with a
     * pseudo-random tag as per the PDF spec.
     */
    @Test
    public void testSubsetFontNamePrefix() {
        class MockedFont extends MultiByteFont {
            @Override
            public int[] getWidths() {
                return new int[] { 0 };
            }

            @Override
            public CIDSubset getCIDSubset() {
                return new CIDSubset();
            }
        }
        PDFDocument doc = new PDFDocument("Test");
        PDFFactory pdfFactory = new PDFFactory(doc);
        MockedFont font = new MockedFont();

        PDFFont pdfDejaVu = pdfFactory.makeFont("DejaVu", "DejaVu", "TTF", font, font);
        assertEquals("/EAAAAA+DejaVu", pdfDejaVu.getBaseFont().toString());

        PDFFont pdfArial = pdfFactory.makeFont("Arial", "Arial", "TTF", font, font);
        assertEquals("/EAAAAB+Arial", pdfArial.getBaseFont().toString());
    }
}
