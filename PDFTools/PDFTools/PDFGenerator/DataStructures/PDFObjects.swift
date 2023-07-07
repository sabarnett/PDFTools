//
// File: PDFObjects.swift
// Package: Tester
// Created by: Steven Barnett on 25/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import SwiftUI

public class PDFElement {
    public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        print("PDFElement base class render - This should never be called and will do nothing.")
    }
}

/// Creates a new page in the target document. The creaton of the new page can be made optional
/// based on the amount of remaining space on the page by specifying the **ifRemainingSpaceIsLessThan** optional
/// parameter.
public class PDFNewPage: PDFElement {

    var remainingSpaceCheck: CGFloat

    /// Initialises the New Page PDF command action.
    ///
    /// - Parameter ifRemainingSpaceIsLessThan: If specified, a check will be made to see how much
    /// remaining space there is on the page. If there is more  than the value requested, a new page will not
    /// be thrown.
    public init(ifRemainingSpaceIsLessThan: CGFloat = .infinity) {
        remainingSpaceCheck = ifRemainingSpaceIsLessThan
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        if remainingSpaceCheck != .infinity {
            let spaceLeft = pageData.pageRect.height - pageData.bottomMargin - pageData.cursor
            if spaceLeft > remainingSpaceCheck {
                return
            }
        }

        context.newPage(pageData: pageData)
    }
}

/// Sets the certical position on the page for the next element.
public class PDFSetCursor: PDFElement {
    let newCursor: CGFloat

    /// Initialise the PDFSetCursor PDF Element.
    /// - Parameter newCursor: The new cursor position (vertical position on the page) for the
    /// next page element. If the cursor position takes the page over the bottom of the page, a new page will
    /// be created and the cursor set to the top of it.
    public init(newCursor: CGFloat) {
        self.newCursor = newCursor
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        pageData.cursor = context.checkContext(pageData: pageData, newCursor: newCursor)
    }
}

/// Sets the certical position on the page for the next element.
public class PDFSpacer: PDFElement {
    let gap: CGFloat

    /// Initialise the PDFpacer PDF Element.
    /// - Parameter gap: Defines the amount of vertical space to add to the cursor.
    /// If the cursor position takes the page over the bottom of the page, a new page will
    /// be created and the cursor set to the top of it.
    public init(gap: CGFloat) {
        self.gap = gap
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        pageData.cursor = context.checkContext(pageData: pageData, newCursor: pageData.cursor + gap)
    }
}

/// Draws a line in to the output document. You can optionally set the start point and end point of the line and
/// the width of the line to be drawn. If there options are omitted, the line will be drawn from one side of the
/// page to the other with a 2 point line.
public class PDFLine: PDFElement {

    var startPoint: CGPoint?
    var endPoint: CGPoint?
    var lineWidth: CGFloat

    /// Draws a line between two points on the page. If the default start position is used, the cursor will advance by
    /// the line width. If custom values are used for the start position, the cursort will not be automatically increased.
    ///
    /// - Parameters:
    ///   - from: The start point on the page for the line. Defailts to the current cursor line and the left edge of the page.
    ///   - to: The end point on the page for the line. Defaults to the current cursor line and the right edge of the page.
    ///   - lineWidth: The width of the line to  draw.
    public init(from: CGPoint? = nil, to: CGPoint? = nil, lineWidth: CGFloat = 2) {
        self.startPoint = from
        self.endPoint = to
        self.lineWidth = lineWidth
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        if self.startPoint == nil {
            self.startPoint = CGPoint(x: pageData.leftMargin, y: pageData.cursor)
        }
        if self.endPoint == nil {
            self.endPoint = CGPoint(x: pageData.pageRect.width - pageData.rightMargin, y: pageData.cursor)
        }

        context.line(pageData: pageData, from: startPoint!, to: endPoint!)
    }
}

/// Draws a filled box on the page at any location and any size
public class PDFBox: PDFElement {

    var position: CGPoint?
    var width: CGFloat?
    var height: CGFloat
    var lineWidth: CGFloat
    var fillColor: UIColor?

    /// Initialise the PDFBox class specifying the options that define the box.
    ///
    /// - Parameters:
    ///   - position: Defines the position of the top left corner of the box. If not specified, the start position will default to
    ///   the current cursor position and the left margin.
    ///   - width: Defines the width of the box. This must be specified.
    ///   - height: Defines the height of the box. If not specified, the box will be 10 points high.
    ///   - fillColor: Defines the colour to use to draw and fill the box. If not specified, the box will be fille din black.
    public init(at position: CGPoint? = nil,
                width: CGFloat? = nil,
                height: CGFloat = 10,
                fillColor: UIColor? = nil) {
        self.position = position
        self.width = width
        self.height = height
        self.lineWidth = 1
        self.fillColor = fillColor
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {

        if self.position == nil { self.position = CGPoint(x: pageData.leftMargin, y: pageData.cursor) }
        if self.width == nil { self.width = pageData.pageRect.width - pageData.margins }
        if fillColor == nil { self.fillColor = UIColor.black }

        context.box(pageData: pageData,
                    startPoint: position!,
                    width: width!, height: height, lineWidth: lineWidth,
                    fillColor: fillColor!)
    }
}

/// Defines a paragraph of text of a specific style. The style options are pre-defined and define such parameters as the
/// text size, colour and paragraph spacing.
public class PDFParagraph: PDFElement {

    var style: PDFParagraphStyle
    var text: String

    /// Creates a paragraph of text. Note, blocks of text that contain newline characters will be treated
    /// as separate paragraphs and will be split automatically.
    /// - Parameters:
    ///   - style: The PDFParagraphStyle to apply to the text
    ///   - text: The block of text to be formatted.
    public init(style: ParagraphStyles, text: String) {
        self.style = style.style()
        self.text = text
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        let textItems = text.split(separator: "\n", omittingEmptySubsequences: true)
        for text in textItems {
            let paraText = String(text)
            context.text(pageData: pageData, text: paraText, inStyle: style)
        }
    }
}

public class PDFLabelledText: PDFElement {
    var label: String
    var content: String
    var labelWidth: CGFloat
    var labelSpace: CGFloat
    var style: PDFParagraphStyle

    public init(label: String, content: String, labelWidth: CGFloat = 80, labelSpace: CGFloat = 10) {
        self.label = label
        self.content = content
        self.labelWidth = labelWidth
        self.labelSpace = labelSpace
        self.style = ParagraphStyles.normal.style()
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        let textItems = content.split(separator: "\n", omittingEmptySubsequences: true)
        guard textItems.count > 0 else { return }

        checkAvailableSpace(context: context, pageData: pageData, firstItem: String(textItems[0]))

        let savedCursor = pageData.cursor
        let savedLeftMargin = pageData.leftMargin

        context.text(pageData: pageData, text: label, inStyle: style)
        pageData.cursor = savedCursor
        pageData.leftMargin += labelWidth + labelSpace

        for text in textItems {
            let paraText = String(text)
            context.text(pageData: pageData, text: paraText, inStyle: style)
        }

        pageData.leftMargin = savedLeftMargin
    }

    // Make sure the first part of the content will fir on the current page. If it won't, then we need to
    // start onm a new page so the label and the first line of the content will always appear on the
    // same page.
    private func checkAvailableSpace(context: UIGraphicsPDFRendererContext, pageData: PDFPageData, firstItem itemText: String) {
        let savedLeftMargin = pageData.leftMargin
        pageData.leftMargin += labelWidth + labelSpace

        let firstItemHeight = context.textHeight(pageData: pageData, text: itemText, inStyle: ParagraphStyles.normal.style())
        let spaceLeft = pageData.pageRect.height - pageData.bottomMargin - pageData.cursor
        if spaceLeft < firstItemHeight {
            context.newPage(pageData: pageData)
        }

        pageData.leftMargin = savedLeftMargin
    }
}

/// Defines an image to be added to the PDF.
public class PDFImage: PDFElement {

    var image: UIImage
    var location: CGPoint?
    var size: CGSize?

    /// Define the image to be output, where to output it and how large a space to render the image into. Note; it is
    /// the callers responsibility to ensure that the image will fit.
    /// - Parameters:
    ///   - image: An instance of a UIImage containing the picture to be rendered.
    ///   - at: The locaton on the page to position the image. If this is omitted, the image will be cenetered
    ///   on the page at the current cursor position.
    ///   - size: The size of the area into which the image is to be rendered. If not specified, this will
    ///   detault to a width of 200 and a height of 200.
    public init(image: UIImage, at: CGPoint? = nil, size: CGSize? = nil) {
        self.image = image
        self.location = at
        self.size = size
    }

    override public func render(context: UIGraphicsPDFRendererContext, pageData: PDFPageData) {
        if size == nil { size = CGSize(width: 200, height: 200)}
        if location == nil { location = CGPoint(x: (pageData.pageRect.width - size!.width) / 2, y: pageData.cursor) }

        context.image(pageData: pageData, image: image, at: location!, size: size!)
    }
}
