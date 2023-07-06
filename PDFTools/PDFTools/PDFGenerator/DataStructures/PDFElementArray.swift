//
// File: PDFElementArray.swift
// Package: PDFTools
// Created by: Steven Barnett on 06/07/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import Foundation

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
