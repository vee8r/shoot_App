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

    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .overlay(
                    Circle() 
                        .stroke(Color.green, lineWidth: 4)
                        .padding()
                )
            
            Text("Detected shots: \(bulletCount)")
            Text("Total shots: \(totalShots)")
            Text("Accuracy: \(Double(bulletCount) / Double(totalShots) * 100, specifier: "%.2f")%")
        }
    }
}

