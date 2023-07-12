//
// File: PDFPageData.swift
// Package: PDFTools
// Created by: Steven Barnett on 29/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

public class PDFPageData {
    public var cursor: CGFloat
    public var pageRect: CGRect
    public var topMargin: CGFloat
    public var bottomMargin: CGFloat
    public var leftMargin: CGFloat
    public var rightMargin: CGFloat
    public var pageNumber: Int

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
        self.pageNumber = 0
    }

    public var margins: CGFloat { leftMargin + rightMargin }
}
