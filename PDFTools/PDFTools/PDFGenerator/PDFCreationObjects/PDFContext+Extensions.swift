//
// File: PDFContext+Extensions.swift
// Package: Tester
// Created by: Steven Barnett on 21/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation
import PDFKit

extension UIGraphicsPDFRendererContext {

    func line(pageData: PageData, from startPoint: CGPoint, to endPoint: CGPoint, lineWidth: CGFloat = 2) {

        let context = self.cgContext

        context.saveGState()
        context.setLineWidth(lineWidth)
        context.move(to: startPoint)
        context.addLine(to: endPoint)
        context.strokePath()
        context.restoreGState()

        if startPoint.y == pageData.cursor {
            // Need to add some space below the line
            pageData.cursor = checkContext(pageData: pageData, newCursor: pageData.cursor + lineWidth)
        }
    }

    func box(pageData: PageData, startPoint: CGPoint, width: CGFloat, height: CGFloat,
             lineWidth: CGFloat, fillColor: UIColor) {

        let context = self.cgContext
        let rectangle = CGRect(x: startPoint.x,
                               y: startPoint.y,
                               width: width,
                               height: height)

        context.saveGState()
        context.setFillColor(fillColor.cgColor)
        context.setStrokeColor(fillColor.cgColor)
        context.setLineWidth(lineWidth)
        context.addRect(rectangle)
        context.drawPath(using: .fillStroke)
        context.restoreGState()

        if startPoint.y == pageData.cursor {
            // Need to add some space below the line
            pageData.cursor = checkContext(pageData: pageData, newCursor: pageData.cursor + height)
        }
    }

    func image(pageData: PageData, image: UIImage, at position: CGPoint, size dimensions: CGSize) {

        let imageRect = CGRect(x: position.x, y: position.y,
                               width: dimensions.width, height: dimensions.height)
        image.draw(in: imageRect)

        if position.y == pageData.cursor {
            // Need to add some space below the line
            pageData.cursor = checkContext(pageData: pageData, newCursor: pageData.cursor + dimensions.height)
        }
    }

    func newPage(pageData: PageData) {
        beginPage()
        pageData.cursor = pageData.topMargin
    }

    func text(pageData: PageData, text: String, inStyle style: PDFParagraphStyle) {
        let textFont = UIFont.systemFont(ofSize: style.fontSize, weight: style.fontWeight)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = style.allignment
        paragraphStyle.lineBreakMode = .byWordWrapping

        let pdfText = NSMutableAttributedString(string: text, attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: style.foregroundColor
        ])

        if let underline = style.underline {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: underline.rawValue]
            pdfText.addAttributes(underlineAttribute, range: NSRange(location: 0, length: text.count))
        }

        let textHeight = pdfText.height(withConstraintWidth: pageData.pageRect.width - pageData.margins)

        let rect = CGRect(x: pageData.leftMargin,
                          y: pageData.cursor,
                          width: pageData.pageRect.width - pageData.margins,
                          height: textHeight)

        pdfText.draw(in: rect)
        pageData.cursor = self.checkContext(pageData: pageData,
                                            newCursor: rect.origin.y + textHeight + style.spaceAfter)
    }

    func checkContext(pageData: PageData, newCursor: CGFloat) -> CGFloat {
        if newCursor > pageData.pageRect.height - pageData.bottomMargin {
            beginPage()
            return pageData.topMargin
        }
        return newCursor
    }
}
