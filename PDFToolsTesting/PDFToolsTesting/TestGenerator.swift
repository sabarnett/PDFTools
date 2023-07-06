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

        let generator = PDFGenerator(creator: "Test App",
                                     author: "Steve",
                                     title: "Test PDF File")
        generator.setPageSize(.Letter)
        generator.setMargins(vertical: 40, horizontal: 40)

        generator.document.add(PDFSetCursor(newCursor: 200))
        generator.document.add(PDFBox(height: 40))
        generator.document.add(PDFParagraph(style: .title, text: "Joanna Masters"))
        generator.document.add(PDFParagraph(style: .subtitle, text: "CAA-12345-FJW"))
        generator.document.add(PDFImage(image: UIImage(named: "waitingInLine")!))
        generator.document.add(PDFLine(lineWidth: 4))
        generator.document.add(PDFSpacer(gap: 10))

        generator.document.add(PDFParagraph(style: .heading1, text: "Pilot Biography"))
        generator.document.add(PDFParagraph(style: .normal, text: "Brief introduction to the pilot and some of" +
                                       "their background in the flying world."))
        generator.document.add(PDFNewPage())
        generator.document.add(PDFParagraph(style: .heading1, text: "Life Story"))
        generator.document.add(PDFParagraph(style: .heading2, text: "The abridged version"))
        generator.document.add(PDFLabelledText(label: "Address", content: "Line 1\nLine 2\nLine 3", labelWidth: 110))
        generator.document.add(PDFLabelledText(label: "Phone (Home)", content: "0121 733 1212", labelWidth: 110))
        generator.document.add(PDFLabelledText(label: "Phone (mobile)", content: "07811 221 991", labelWidth: 110))
        generator.document.add(PDFLabelledText(label: "Email", content: "test@example.com", labelWidth: 110))
        generator.document.add(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))
        generator.document.add(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

        generator.document.add(PDFParagraph(style: .heading3, text: "Education"))
        generator.document.add(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "gf eiuh euihfyoeihfio ueioufioeu iouoeiueioy oioihihfiueiour eio" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

        generator.document.add(PDFParagraph(style: .heading4, text: "Awards"))
        generator.document.add(PDFParagraph(style: .normal, text: "yegr gyigeiuyi uy iyiueyiey iueiuyreiuyriyr iuey riueyiur y" +
                                       "iufge iehueyhoi eu ir ueriuepiuue ieuoifeoiueiour ueiur irue i uiu.\n\n" +
                                       "Second para in the para as a whole."))

        self.pdfData = generator.render()
    }
}

struct TestGenerator_Previews: PreviewProvider {
    static var previews: some View {
        TestGenerator()
    }
}
