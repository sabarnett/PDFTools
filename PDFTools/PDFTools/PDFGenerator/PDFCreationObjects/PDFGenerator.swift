//
// File: PDFGenerator.swift
// Package: Tester
// Created by: Steven Barnett on 21/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation
import PDFKit

public class PageData {
    var cursor: CGFloat
    var pageRect: CGRect
    var topMargin: CGFloat
    var bottomMargin: CGFloat
    var leftMargin: CGFloat
    var rightMargin: CGFloat

    public init(pageRect: CGRect,
                topMargin: CGFloat = 32,
                bottomMargin: CGFloat = 100,
                leftMargin: CGFloat = 20,
                rightMargin: CGFloat = 20) {
        self.cursor = topMargin
        self.pageRect = pageRect
        self.topMargin = topMargin
        self.bottomMargin = bottomMargin
        self.leftMargin = leftMargin
        self.rightMargin = rightMargin
    }

    var margins: CGFloat { leftMargin + rightMargin }
}

class PDFGenerator {

    var creator: String = "PDFGenerator"
    var author: String = "Author Name"
    var title: String = "Document Title"

    init(creator: String, author: String, title: String) {
        self.creator = creator
        self.author = author
        self.title = title
    }

    func render() -> Data? {

        let pageData = PageData(
            pageRect: CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
        )

        var pdfObjects: [PDFElement] = []

//        pdfObjects.append(PDFLine(from: CGPoint(x: pageData.leftMargin - 3, y: 0),
//                                  to: CGPoint(x: pageData.leftMargin - 3, y: pageData.pageRect.height),
//                                  lineWidth: 1))
        pdfObjects.append(PDFSetCursor(newCursor: 200))
        pdfObjects.append(PDFBox(height: 40))
        pdfObjects.append(PDFParagraph(style: .title, text: "Joanna Masters"))
        pdfObjects.append(PDFParagraph(style: .subtitle, text: "CAA-12345-FJW"))
        pdfObjects.append(PDFImage(image: UIImage(named: "waitingInLine")!))
        pdfObjects.append(PDFLine(lineWidth: 4))

        pdfObjects.append(PDFParagraph(style: .heading1, text: "Pilot Biography"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "Brief introduction to the pilot and some of" +
                                       "their background in the flying world."))
        pdfObjects.append(PDFNewPage())
        pdfObjects.append(PDFParagraph(style: .heading1, text: "Life Story"))
        pdfObjects.append(PDFParagraph(style: .heading2, text: "The abridged version"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

        pdfObjects.append(PDFParagraph(style: .heading3, text: "Education"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

        pdfObjects.append(PDFParagraph(style: .heading4, text: "Awards"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

//        pdfObjects.append(PDFLine(lineWidth: 3))
//        pdfObjects.append(PDFNewPage(ifRemainingSpaceIsLessThan: 100))

        let renderer = createRenderer(pageData: pageData)

        return renderer.pdfData(actions: { context in

            context.beginPage()
            for pdf in pdfObjects {
                pdf.render(context: context, pageData: pageData)
            }
        })
    }

    private func createRenderer(pageData: PageData) -> UIGraphicsPDFRenderer {

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
