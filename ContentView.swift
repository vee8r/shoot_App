//
//  ContentView.swift
//  ShootApp
//
//  Created by Weronika Kuzio on 29/07/2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var showingCameraPicker = false
    @State private var showingGalleryPicker = false
    @State private var inputImage: UIImage?
    @State private var showStatistics = false
    @State private var totalShots = 0
    @State private var detectedShots = 0
    
    var body: some View {
        NavigationView {
            VStack {
                if showStatistics, let inputImage = inputImage {
                    StatisticsView(image: inputImage, bulletCount: detectedShots, totalShots: totalShots)
                } else {
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
                    
                    if !showStatistics {
                        TextField("Enter total shots fired", value: $totalShots, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .padding()
                    }

                }
            }
        }
    }
    
    func loadImage() {
        if let image = inputImage {
            detectedShots = detectShots(in: image)
            showStatistics = true
        }
    }

    func detectShots(in image: UIImage) -> Int {
        // Logika do wykrywania strzałów
        return 0 // Tymczasowe
    }
}



