//
//  StatisticView.swift
//  ShootApp
//
//  Created by Weronika Kuzio on 29/07/2024.
//

import SwiftUI

struct StatisticsView: View {
    var image: UIImage
    var bulletCount: Int
    var totalShots: Int
    var detectedCircles: [CGRect]

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .overlay(
                    GeometryReader { geometry in
                        ForEach(detectedCircles.indices, id: \.self) { index in
                            let circle = detectedCircles[index]
                            let xScale = geometry.size.width / image.size.width
                            let yScale = geometry.size.height / image.size.height

                            Circle()
                                .stroke(Color.green, lineWidth: 2)
                                .frame(width: 20, height: 20)
                                .offset(x: (circle.midX * xScale) - 10, y: (circle.midY * yScale) - 10)
                        }
                    }

                )
            Text("Detected shots: \(bulletCount)")
            Text("Total shots: \(totalShots)")
            Text("Accuracy: \(totalShots > 0 ? "\(Double(bulletCount) / Double(totalShots) * 100, specifier: "%.2f")%" : "N/A")")
        }
    }
}

