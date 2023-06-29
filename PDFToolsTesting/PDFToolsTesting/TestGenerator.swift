//
// File: TestGenerator.swift
// Package: PDFToolsTesting
// Created by: Steven Barnett on 29/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import SwiftUI
import PDFTools

struct TestGenerator: View {

    @State private var pdfData: Data?

    var body: some View {
        VStack {
            Button(action: { generatePDF() },
                   label: { Text("Generate PDF") })
            
            PDFViewer(pdfData: pdfData)
        }
    }
    
    private func generatePDF() {

        var pdfObjects: [PDFElement] = []

        pdfObjects.append(PDFSetCursor(newCursor: 200))
        pdfObjects.append(PDFBox(height: 40))
        pdfObjects.append(PDFParagraph(style: .title, text: "Joanna Masters"))
        pdfObjects.append(PDFParagraph(style: .subtitle, text: "CAA-12345-FJW"))
        pdfObjects.append(PDFImage(image: UIImage(named: "waitingInLine")!))
        pdfObjects.append(PDFLine(lineWidth: 4))

        pdfObjects.append(PDFParagraph(style: .heading1, text: "Pilot Biography"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "Brief introduction to the pilot and some of" +
                                       "their background in the flying world."))
        pdfObjects.append(PDFNewPage())
        pdfObjects.append(PDFParagraph(style: .heading1, text: "Life Story"))
        pdfObjects.append(PDFParagraph(style: .heading2, text: "The abridged version"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

        pdfObjects.append(PDFParagraph(style: .heading3, text: "Education"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

        pdfObjects.append(PDFParagraph(style: .heading4, text: "Awards"))
        pdfObjects.append(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

//        pdfObjects.append(PDFLine(lineWidth: 3))
//        pdfObjects.append(PDFNewPage(ifRemainingSpaceIsLessThan: 100))

        let generator = PDFGenerator(creator: "Test App",
                                     author: "Steve",
                                     title: "Test PDF File")
        self.pdfData = generator.render(pdfDocument: pdfObjects)
    }
}

struct TestGenerator_Previews: PreviewProvider {
    static var previews: some View {
        TestGenerator()
    }
}
