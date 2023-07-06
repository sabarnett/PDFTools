//
// File: PDFPageData.swift
// Package: PDFTools
// Created by: Steven Barnett on 29/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

public class PDFPageData {
    var cursor: CGFloat
    var pageRect: CGRect
    var topMargin: CGFloat
    var bottomMargin: CGFloat
    var leftMargin: CGFloat
    var rightMargin: CGFloat
    var pageNumber: Int

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

    var margins: CGFloat { leftMargin + rightMargin }
}
