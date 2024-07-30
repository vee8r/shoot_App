//
//  ShotDetector.swift
//  ShootApp
//
//  Created by Weronika Kuzio on 29/07/2024.
//

import UIKit
import Vision

class ShotDetector {
    func detectShots(in image: UIImage) -> [CGRect] {
        guard let ciImage = CIImage(image: image) else { return [] }

        var detectedRectangles = [CGRect]()

        let request = VNDetectRectanglesRequest { (request, error) in
            guard let results = request.results as? [VNRectangleObservation] else { return }
            detectedRectangles = results.map { $0.boundingBox }
        }

        request.minimumAspectRatio = 0.9
        request.maximumAspectRatio = 1.1
        request.minimumSize = 0.02
        request.maximumObservations = 50

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        try? handler.perform([request])

        return detectedRectangles
    }
    
    func convertToImageCoordinates(normalizedRects: [CGRect], imageViewSize: CGSize) -> [CGRect] {
        return normalizedRects.map { rect in
            CGRect(
                x: rect.minX * imageViewSize.width,
                y: rect.minY * imageViewSize.height,
                width: rect.width * imageViewSize.width,
                height: rect.height * imageViewSize.height
            )
        }
    }
    
    func drawCircles(on imageView: UIImageView, shotRects: [CGRect]) {
        shotRects.forEach { rect in
            let circleView = UIView(frame: rect)
            circleView.layer.borderColor = UIColor.green.cgColor
            circleView.layer.borderWidth = 2
            circleView.layer.cornerRadius = rect.width / 2
            imageView.addSubview(circleView)
        }
    }
}
