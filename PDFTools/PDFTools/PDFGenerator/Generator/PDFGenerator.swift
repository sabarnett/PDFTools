//
// File: PDFGenerator.swift
// Package: Tester
// Created by: Steven Barnett on 21/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation
import PDFKit

public struct PageMargins {
    public var left: CGFloat
    public var right: CGFloat
    public var top: CGFloat
    public var bottom: CGFloat
}

public class PDFGenerator {

    var creator: String = "PDFGenerator"
    var author: String = "Author Name"
    var title: String = "Document Title"

    private var pageWidth: CGFloat = 595.2
    private var pageHeight: CGFloat = 841.8
    private var topMargin: CGFloat = 32
    private var bottomMargin: CGFloat = 100
    private var leftMargin: CGFloat = 20
    private var rightMargin: CGFloat = 20

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

    public var pageLayout: PDFPageData {
        return PDFPageData(
            pageRect: CGRect(x: 0, y: 0,
                             width: pageWidth, height: pageHeight),
            topMargin: self.topMargin,
            bottomMargin: self.bottomMargin,
            leftMargin: self.leftMargin,
            rightMargin: self.rightMargin
        )
    }

    public func clear() {
        pdfDocument.document.clear()
    }

    public func render() -> Data? {

        let pageData = PDFPageData(
            pageRect: CGRect(x: 0, y: 0,
                             width: pageWidth, height: pageHeight),
            topMargin: self.topMargin,
            bottomMargin: self.bottomMargin,
            leftMargin: self.leftMargin,
            rightMargin: self.rightMargin
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

extension PDFGenerator {
    public func setPageSize(width: CGFloat, height: CGFloat) {
        // TODO: Some validation to make sure we get sensible numbers
        self.pageWidth = width
        self.pageHeight = height
    }

    public func setPageSize(_ pageSize: PDFPageSize) {
        let size = pageSize.size()
        self.pageWidth = size.width
        self.pageHeight = size.height
    }

    public func setMargins(vertical verticalMargin: CGFloat, horizontal horizontalMargin: CGFloat) {
        // TODO: Some validation to ensure sensible values.
        self.topMargin = verticalMargin
        self.bottomMargin = verticalMargin

        self.leftMargin = horizontalMargin
        self.rightMargin = horizontalMargin
    }

    public func setMargins(top topMargin: CGFloat, bottom bottomMargin: CGFloat,
                           left leftMargin: CGFloat, right rightMargin: CGFloat) {
        self.topMargin = topMargin
        self.bottomMargin = bottomMargin
        self.leftMargin = leftMargin
        self.rightMargin = rightMargin
    }
}
