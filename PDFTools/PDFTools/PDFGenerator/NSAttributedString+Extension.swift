//
// File: NSAttributedString+Extension.swift
// Package: Tester
// Created by: Steven Barnett on 21/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation

extension NSAttributedString {
    func height(withConstraintWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect,
                                       options: .usesLineFragmentOrigin,
                                       context: nil)
        return ceil(boundingBox.height)
    }
}
