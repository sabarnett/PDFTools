//
// File: PDFGenerator.swift
// Package: Tester
// Created by: Steven Barnett on 21/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation
import PDFKit

public class PDFElementArray: Sequence, IteratorProtocol {

    private var elements: [PDFElement] = []
    private var elementIndex = 0

    public func next() -> PDFElement? {
        defer {
            elementIndex += 1
        }

        if elements.count <= elementIndex {
            elementIndex = 0
            return nil
        }
        return elements[elementIndex]
    }

    public var pageElements: [PDFElement] {
        elements
    }

    public func add(_ element: PDFElement) {
        elements.append(element)
    }

    public func clear() {
        elements.removeAll()
        elementIndex = 0
    }
}

public class PDFFile {
    var document: PDFElementArray = PDFElementArray()
    // var header: PDFElementArray
    // var footer: PDFElementArray
}

public class PDFGenerator {

    var creator: String = "PDFGenerator"
    var author: String = "Author Name"
    var title: String = "Document Title"

    var pdfDocument: PDFFile

    public init(creator: String, author: String, title: String) {
        self.creator = creator
        self.author = author
        self.title = title
        self.pdfDocument = PDFFile()
    }

    public var document: PDFElementArray {
        pdfDocument.document
    }

    public func clear() {
        pdfDocument.document.clear()
    }

    public func render() -> Data? {

        let pageData = PDFPageData(
            pageRect: CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
        )

        let renderer = createRenderer(pageData: pageData)

        return renderer.pdfData(actions: { context in

            context.beginPage()
            for pdf in pdfDocument.document {
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
