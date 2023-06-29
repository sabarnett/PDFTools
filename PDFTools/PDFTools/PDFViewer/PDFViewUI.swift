//
// File: PDFViewUI.swift
// Package: Tester
// Created by: Steven Barnett on 19/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFViewUI: UIViewRepresentable {
    typealias UIViewType = PDFView

    private var data: Data?
    private var autoScales: Bool

    init(data: Data?, autoScales: Bool) {
        self.data = data
        self.autoScales = autoScales
    }

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()

        pdfView.autoScales = autoScales

        if let data = self.data {
            pdfView.document = PDFDocument(data: data)
        }

        return pdfView
    }

    func updateUIView(_ pdfView: UIViewType, context: Context) {
        if let data {
            DispatchQueue.main.async {
                pdfView.document = PDFDocument(data: data)
            }
        }
    }
}
