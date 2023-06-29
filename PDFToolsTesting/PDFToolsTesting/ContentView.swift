//
// File: ContentView.swift
// Package: PDFToolsTesting
// Created by: Steven Barnett on 29/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//
        

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink(destination: {
                        TestViewer()
                    }, label: {
                        Text("View a document")
                    })
                    
                    NavigationLink(destination: {
                        TestGenerator()
                    }, label: {
                        Text("Generate a document")
                    })
                }.listStyle(.plain)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
