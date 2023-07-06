//
// File: PDFPageSize.swift
// Package: PDFTools
// Created by: Steven Barnett on 06/07/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation

public enum PDFPageSize: String {
    // swiftlint:disable identifier_name
    case A3         // 842x1191
    case A4         // 595x842
    case A5         // 420x595
    case Letter     // 612x791
    case Legal      // 612x1008
    // swiftlint:enable identifier_name

    public func size() -> (width: CGFloat, height: CGFloat) {
        switch self {
        case .A3:
            return (width: 842, height: 1191)
        case .A4:
            return (width: 595, height: 842)
        case .A5:
            return (width: 420, height: 595)
        case .Letter:
            return (width: 612, height: 791)
        case .Legal:
            return (width: 612, height: 1008)
        }
    }
}
