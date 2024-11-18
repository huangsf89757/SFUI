//
//  SFTriangleView.swift
//  SFUI
//
//  Created by hsf on 2024/9/5.
//

import Foundation
import UIKit

// MARK: - SFTriangleView
open class SFTriangleView: SFView {
    // MARK: var
    /// 旋转角度
    public var rotationAngle: Double = 0.0 {
        didSet {
            self.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
            setNeedsLayout()
        }
    }

    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.insertSublayer(shapeLayer, at: 0)
        self.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
    }
    
    open override func draw(_ rect: CGRect) {
        let sideLength = min(bounds.width, bounds.height)
        let height = (sqrt(3) / 2) * sideLength
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.midX, y: bounds.midY - height / 2))
        path.addLine(to: CGPoint(x: bounds.midX + sideLength / 2, y: bounds.midY + height / 2))
        path.addLine(to: CGPoint(x: bounds.midX - sideLength / 2, y: bounds.midY + height / 2))
        path.close()
        
        shapeLayer.frame = CGRect(origin: .zero, size: rect.size)
        shapeLayer.path = path.cgPath
    }
    
    // MARK: ui
    public private(set) lazy var shapeLayer: CAShapeLayer = {
        return CAShapeLayer().then { layer in
            layer.fillColor = SFColor.black?.cgColor
        }
    }()
   
}
