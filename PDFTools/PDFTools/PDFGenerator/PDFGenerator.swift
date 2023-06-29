//
// File: PDFGenerator.swift
// Package: Tester
// Created by: Steven Barnett on 21/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation
import PDFKit

public class PDFGenerator {

    var creator: String = "PDFGenerator"
    var author: String = "Author Name"
    var title: String = "Document Title"

    public init(creator: String, author: String, title: String) {
        self.creator = creator
        self.author = author
        self.title = title
    }

    public func render(pdfDocument pdfObjects: [PDFElement]) -> Data? {

        let pageData = PDFPageData(
            pageRect: CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
        )

        let renderer = createRenderer(pageData: pageData)

        return renderer.pdfData(actions: { context in

            context.beginPage()
            for pdf in pdfObjects {
                pdf.render(context: context, pageData: pageData)
            }
        })
    }

    private func createRenderer(pageData: PDFPageData) -> UIGraphicsPDFRenderer {

        let pdfMetaData = [
            kCGPDFContextCreator: creator,
            kCGPDFContextAuthor: author,
            kCGPDFContextTitle: title
        ]

        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        return UIGraphicsPDFRenderer(bounds: pageData.pageRect, format: format)
    }
}
