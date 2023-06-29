//
// File: TestViewer.swift
// Package: PDFToolsTesting
// Created by: Steven Barnett on 29/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//
        

import SwiftUI
import PDFTools

struct TestViewer: View {
    
    @State var pdfData: Data?
    
    var body: some View {
        VStack {
            PDFViewer(pdfData: pdfData)
                .onAppear {
                    if let pdfUrl = Bundle.main.url(forResource: "RandomActs", withExtension: "pdf") {
                        self.pdfData = try? Data.init(contentsOf: pdfUrl)
                    }
                }
        }
    }
}

struct TestViewer_Previews: PreviewProvider {
    static var previews: some View {
        TestViewer()
    }
}
