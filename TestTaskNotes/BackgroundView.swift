//
//  BackgroundView.swift
//  TestTaskNotes
//
//  Created by Роман Сенкевич on 4.12.22.
//

import UIKit
import CoreGraphics

class BackgroundView: UIView {
    
    var heightVariance: CGFloat = 60
    var fillColor: UIColor = UIColor.blue
    
    override func draw(_ rect: CGRect) {
        
        // create path by points
        let path = UIBezierPath()
        let startPoint = CGPoint(x: 0, y: rect.height)
        let topLeftPoint = CGPoint(x: 0, y: 0)
        let topRightPoint = CGPoint(x: rect.width, y: 0)
        let bottomRightPoint = CGPoint(x: rect.width, y: rect.height - heightVariance)

        path.move(to: startPoint)
        path.addLine(to: topLeftPoint)
        path.addLine(to: topRightPoint)
        path.addLine(to: bottomRightPoint)
        
        
        let controlPoint1 = CGPoint(x: bottomRightPoint.x - rect.width / 2.7, y: bottomRightPoint.y)
        let controlPoint2 = CGPoint(x: startPoint.x + rect.width / 2.7, y: startPoint.y)
        
        path.addCurve(to: startPoint,
                      controlPoint1: controlPoint1,
                      controlPoint2: controlPoint2)
        
        fillColor.setFill()
        path.fill()
    }
}
