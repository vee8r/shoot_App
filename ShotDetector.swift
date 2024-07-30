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
        
        var detectedCircles = [CGRect]()
        
        let request = VNDetectRectanglesRequest { (request, error) in
            guard let results = request.results as? [VNRectangleObservation] else { return }
            
            for observation in results {
                // Filtrujemy tylko te, które mają kształt okręgu
                let aspectRatio = observation.boundingBox.width / observation.boundingBox.height
                if aspectRatio > 0.9 && aspectRatio < 1.1 {
                    detectedCircles.append(observation.boundingBox)
                }
            }
        }
        
        request.minimumAspectRatio = 0.9
        request.maximumAspectRatio = 1.1
        request.minimumSize = 0.01
        request.maximumObservations = 50
        request.minimumConfidence = 0.6
        request.quadratureTolerance = 45.0 // Dodanie tolerancji dla kątów
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        try? handler.perform([request])
        
        return detectedCircles
    }
    
    
    func convertToImageCoordinates(normalizedRects: [CGRect], imageViewSize: CGSize) -> [CGRect] {
        return normalizedRects.map { rect in
            CGRect(
                x: rect.minX * imageViewSize.width,
                y: (1 - rect.minY - rect.height) * imageViewSize.height,
                width: rect.width * imageViewSize.width,
                height: rect.height * imageViewSize.height
            )
        }
    }

    
    func drawCircles(on image: UIImage, circles: [CGRect]) -> UIImage? {
        UIGraphicsBeginImageContext(image.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Failed to get graphics context")
            return nil
        }
        
        image.draw(at: .zero)
        
        context.setStrokeColor(UIColor.green.cgColor)
        context.setLineWidth(2)
        
        for rect in circles {
            // Przeskalowanie współrzędnych do rozmiaru obrazu, jeśli są one normalizowane
            let scaledX = rect.origin.x * image.size.width
            let scaledY = (1 - rect.origin.y - rect.height) * image.size.height
            let scaledWidth = rect.size.width * image.size.width
            let scaledHeight = rect.size.height * image.size.height
            
            // Debugowanie współrzędnych
            print("Drawing circle at: x = \(scaledX), y = \(scaledY), width = \(scaledWidth), height = \(scaledHeight)")
            
            let ellipseRect = CGRect(x: scaledX, y: scaledY, width: scaledWidth, height: scaledHeight)
            context.strokeEllipse(in: ellipseRect)
        }
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }



}
