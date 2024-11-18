//
//  SFRangeSlider.swift
//  SFUI
//
//  Created by hsf on 2024/9/3.
//

// TODO: 未完成！

import Foundation
import UIKit

// MARK: - SFRangeSlider
open class SFRangeSlider: UIControl {
    
    open var minimumValue: Float = 0.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    open var maximumValue: Float = 1.0 {
        didSet {
            updateLayerFrames()
        }
    }
    
    open var lowerValue: Float = 0.0 {
        didSet {
            updateLayerFrames()
            sendActions(for: .valueChanged)
        }
    }
    
    open var upperValue: Float = 1.0 {
        didSet {
            updateLayerFrames()
            sendActions(for: .valueChanged)
        }
    }
    
    open var minimumTrackTintColor: UIColor? = UIColor.blue {
        didSet {
            minimumTrackLayer.backgroundColor = minimumTrackTintColor?.cgColor
        }
    }
    
    open var maximumTrackTintColor: UIColor? = UIColor.lightGray {
        didSet {
            maximumTrackLayer.backgroundColor = maximumTrackTintColor?.cgColor
        }
    }
    

    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    
    private lazy var minimumTrackLayer: CALayer = {
        return CALayer()
    }()
    
    private lazy var maximumTrackLayer: CALayer = {
        return CALayer()
    }()
    
    private lazy var lowerThumbLayer: CALayer = {
        return CALayer()
    }()
    
    private lazy var upperThumbLayer: CALayer = {
        return CALayer()
    }()
    
    private func customUI() {
        layer.addSublayer(maximumTrackLayer)
        layer.addSublayer(minimumTrackLayer)
        layer.addSublayer(lowerThumbLayer)
        layer.addSublayer(upperThumbLayer)
        
        minimumTrackLayer.backgroundColor = UIColor.blue.cgColor
        maximumTrackLayer.backgroundColor = UIColor.lightGray.cgColor
        
        lowerThumbLayer.backgroundColor = UIColor.white.cgColor
        upperThumbLayer.backgroundColor = UIColor.white.cgColor
        
        lowerThumbLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        upperThumbLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        lowerThumbLayer.cornerRadius = 15
        upperThumbLayer.cornerRadius = 15
        
        updateLayerFrames()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGesture)
    }
    
    private func updateLayerFrames() {
        let trackHeight: CGFloat = 4
        let trackY = (bounds.height - trackHeight) / 2
        
        maximumTrackLayer.frame = CGRect(x: 0, y: trackY, width: bounds.width, height: trackHeight)
        
        let lowerX = CGFloat(lowerValue / (maximumValue - minimumValue)) * bounds.width
        let upperX = CGFloat(upperValue / (maximumValue - minimumValue)) * bounds.width
        
        minimumTrackLayer.frame = CGRect(x: 0, y: trackY, width: upperX, height: trackHeight)
        
        lowerThumbLayer.position = CGPoint(x: lowerX, y: bounds.height / 2)
        upperThumbLayer.position = CGPoint(x: upperX, y: bounds.height / 2)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        let value = Float(location.x / bounds.width) * (maximumValue - minimumValue)
        
        switch gesture.state {
        case .changed:
            if abs(location.x - lowerThumbLayer.position.x) < abs(location.x - upperThumbLayer.position.x) {
                lowerValue = min(max(value, minimumValue), upperValue)
            } else {
                upperValue = max(min(value, maximumValue), lowerValue)
            }
        default:
            break
        }
    }
    
    open func setValue(lower: Float, upper: Float, animated: Bool) {
        lowerValue = lower
        upperValue = upper
        updateLayerFrames()
    }
    
    open func valueChanged() {
        // This function can be overridden to handle value changes
    }
}
