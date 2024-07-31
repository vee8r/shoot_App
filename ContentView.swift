//
//  ContentView.swift
//  ShootApp
//


import SwiftUI

struct ContentView: View {
    @State private var showingCameraPicker = false
    @State private var showingGalleryPicker = false
    @State private var inputImage: UIImage?
    @State private var showStatistics = false
    @State private var totalShots = 0
    @State private var detectedShots = 0
    @State private var detectedCircles: [CGRect] = []

    var body: some View {
        NavigationView {
            VStack {
                if showStatistics, let inputImage = inputImage {
                    let imageWithCircles = ShotDetector().drawCircles(on: inputImage, circles: detectedCircles)
                    Image(uiImage: imageWithCircles ?? inputImage)
                        .resizable()
                        .scaledToFit()
                    StatisticsView(image: inputImage, bulletCount: detectedShots, totalShots: totalShots, detectedCircles: detectedCircles)
                } else {
                    if let inputImage = inputImage {
                        Image(uiImage: inputImage)
                            .resizable()
                            .scaledToFit()
                            .onAppear {
                                self.detectedCircles = ShotDetector().detectShots(in: inputImage)
                            }
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
            self.detectedCircles = ShotDetector().detectShots(in: image)
            detectedShots = detectedCircles.count
            showStatistics = true
        }
    }

    func detectShots(in image: UIImage) -> Int {
        return ShotDetector().detectShots(in: image).count
    }
}




