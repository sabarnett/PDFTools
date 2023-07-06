# PDFTools

A recent app I was working on called for a simplistic level of reporting and to be able to save those reports
to disk or print them. I searched around for a reporting library that I could use with Swift on iOS and
failed to find anything. Not just anything I could afford (ideally open source) but anything at all.

So, PDFTools was my next step. It needed to fill two aspects;

* To be able to view PDF files and export/print them.
* To be able to generate PDF files in the simplest way possible without needing to understand
the complexities of the PDF file format.

**This is a work in progress - it is being developed along side a somewhat larger project** - I will be
evolving the functionality of the library over time as my larger apps requirements change. I have a number
of requirements that I know I will need to fulfil in future versions. The state of this app as I first publish it
is that it does display/print/export PDF files and it does generate a reasonably good looking PDF file. 

I have included a test app in the repo that illustrates the use of the basic page components. It needs a lot
more testing than I have done to date, but that will come from usage. 

## Overview

I took a declarative approach to creating PDF files. So, my caller creates an instance of the generator
then adds components to the page. The final step is to then generate the document. For example...

```
        let generator = PDFGenerator(creator: "Test App",
                                     author: "Steve",
                                     title: "Test PDF File")

```

Having created the generator, we add the page components.

```
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

```

Finally, we generate the PDF.

```
        var pdfData = generator.render()
```

The data returned contains the PDF file contents. You can save it to a file or push it into the viewer component:

```
    @State private var pdfData: Data?

    var body: some View {
        VStack {
            PDFViewer(pdfData: pdfData)
        }
    }
```