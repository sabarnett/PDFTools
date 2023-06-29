//
// File: PDFGeneratorUI.swift
// Package: Tester
// Created by: Steven Barnett on 21/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import SwiftUI

struct PDFGeneratorUI: View {

    @State private var pdfData: Data?
    @State private var showShareSheet: Bool = false

    var body: some View {
        VStack {
            Button(action: { generatePDF() },
                   label: { Text("Generate PDF") })

            PDFViewUI(data: pdfData, autoScales: true)
                .overlay(
                    Button(action: {
                        showShareSheet = true
                        //self.reportItems = ActivityItem(items: pdfData as Any)
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                            .scaleEffect(1)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black)
                            .background(.white)
                            .clipShape(Circle())
                    })
                    .offset(x: -10, y: 10),
                    alignment: .topTrailing)
        }
        .sheet(isPresented: $showShareSheet) {
            if let pdfData {
                ShareView(activityItems: [pdfData])
            }
        }
    }

    private func generatePDF() {
        let generator = PDFGenerator(creator: "Test App",
                                     author: "Steve",
                                     title: "Test PDF File")
        self.pdfData = generator.render()
    }
}

struct PDFGeneratorUI_Previews: PreviewProvider {
    static var previews: some View {
        PDFGeneratorUI()
    }
}
