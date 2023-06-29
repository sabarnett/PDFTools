//
// File: PDFViewPlaying.swift
// Package: Tester
// Created by: Steven Barnett on 19/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import SwiftUI

struct PDFViewPlaying: View {

    @Environment(\.colorScheme) private var colorScheme
    @State private var pdfData: Data?
    @State private var showShareSheet: Bool = false

    var body: some View {
        VStack {
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
        .onAppear {
            if let pdfUrl = Bundle.main.url(forResource: "RandomActs", withExtension: "pdf") {
                self.pdfData = try? Data.init(contentsOf: pdfUrl)
            }
        }
        .navigationTitle(Text("PDF View"))
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showShareSheet) {
            if let pdfData {
                ShareView(activityItems: [pdfData])
            }
        }
    }
}

struct PDFViewPlaying_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewPlaying()
    }
}
