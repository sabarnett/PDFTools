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
