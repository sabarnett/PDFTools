//
// File: ParagraphStyle.swift
// Package: Tester
// Created by: Steven Barnett on 24/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation
import SwiftUI

public struct PDFParagraphStyle {
    let fontWeight: UIFont.Weight
    let fontSize: CGFloat
    let foregroundColor: UIColor
    let allignment: NSTextAlignment
    let underline: NSUnderlineStyle?
    let spaceAfter: CGFloat

    public init(fontWeight: UIFont.Weight = .regular,
                fontSize: CGFloat = 16,
                foregroundColor: UIColor = .black,
                allignment: NSTextAlignment = .left,
                underline: NSUnderlineStyle? = nil,
                spaceAfter: CGFloat = 8) {
        self.fontWeight = fontWeight
        self.fontSize = fontSize
        self.foregroundColor = foregroundColor
        self.allignment = allignment
        self.underline = underline
        self.spaceAfter = spaceAfter
    }
}

public enum ParagraphStyles {

    case title
    case subtitle
    case heading1
    case heading2
    case heading3
    case heading4
    case normal
    case footnote

    public func style() -> PDFParagraphStyle {
        switch self {
        case .title:
            return titleStyle
        case .subtitle:
            return subtitleStyle
        case .heading1:
            return heading1Style
        case .heading2:
            return heading2Style
        case .heading3:
            return heading3Style
        case .heading4:
            return heading4Style
        case .normal:
            return normalStyle
        case .footnote:
            return footnoteStyle
        }
    }

    var titleStyle: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .bold,
            fontSize: 44,
            foregroundColor: .black,
            allignment: .center)
    }

    var subtitleStyle: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .bold,
            fontSize: 38,
            foregroundColor: .black,
            allignment: .center)
    }

    var heading1Style: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .bold,
            fontSize: 30,
            foregroundColor: .blue,
            allignment: .left,
            underline: .thick,
            spaceAfter: 18)
    }

    var heading2Style: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .bold,
            fontSize: 28,
            foregroundColor: .blue,
            allignment: .left,
            underline: .thick,
            spaceAfter: 14)
    }

    var heading3Style: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .regular,
            fontSize: 24,
            foregroundColor: .blue,
            allignment: .left,
            underline: .single,
            spaceAfter: 12)
    }

    var heading4Style: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .regular,
            fontSize: 22,
            foregroundColor: .blue,
            allignment: .left,
            spaceAfter: 10)
    }

    var normalStyle: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .regular,
            fontSize: 13,
            foregroundColor: .black,
            allignment: .left)
    }

    var footnoteStyle: PDFParagraphStyle {
        return PDFParagraphStyle(
            fontWeight: .regular,
            fontSize: 10,
            foregroundColor: .black,
            allignment: .left,
            spaceAfter: 4)
    }
}
