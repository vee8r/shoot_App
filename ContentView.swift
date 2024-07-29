//
//  ContentView.swift
//  ShootApp
//
//  Created by Weronika Kuzio on 29/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera

    var body: some View {
        NavigationView {
            VStack {
                if let inputImage = inputImage {
                    Image(uiImage: inputImage)
                        .resizable()
                        .scaledToFit()
                }

                Button("Open Camera") {
                    self.sourceType = .camera
                    showingImagePicker = true
                }
                .padding()

                Button("Select Image from Gallery") {
                    self.sourceType = .photoLibrary
                    showingImagePicker = true
                }
                .padding()
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage, sourceType: sourceType)
            }
        }
    }

    func loadImage() {
    }
}

