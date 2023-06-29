//
// File: ShareView.swift
// Package: Tester
// Created by: Steven Barnett on 19/06/2023
// 
// Copyright © 2023 Steven Barnett. All rights reserved.
//

import UIKit
import SwiftUI

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareView>) ->
        UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
               applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ShareView>) {
        // empty
    }
}
