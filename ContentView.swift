//
//  ContentView.swift
//  ShootApp
//
//  Created by Weronika Kuzio on 29/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showingCameraPicker = false
    @State private var showingGalleryPicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            VStack {
                if let inputImage = inputImage {
                    Image(uiImage: inputImage)
                        .resizable()
                        .scaledToFit()
                }

                Button("Open Camera") {
                    self.showingCameraPicker = true
                }
                .padding()
                .sheet(isPresented: $showingCameraPicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage, sourceType: .camera)
                }

                Button("Select Image from Gallery") {
                    self.showingGalleryPicker = true
                }
                .padding()
                .sheet(isPresented: $showingGalleryPicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage, sourceType: .photoLibrary)
                }
            }
        }
    }

    func loadImage() {
    }
}


