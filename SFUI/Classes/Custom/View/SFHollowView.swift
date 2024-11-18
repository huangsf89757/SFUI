//
//  SFHollowView.swift
//  SFUI
//
//  Created by hsf on 2024/7/21.
//

import Foundation
import UIKit
// Third
import Then
import SnapKit

// MARK: - SFHollowView
open class SFHollowView: SFView {
    
    // MARK: var
    /// 镂空区域的路径
    public var hollowPath: UIBezierPath? {
        didSet {
            setNeedsDisplay()
        }
    }
    /// 遮罩颜色
    public var maskColor: UIColor? = .black.withAlphaComponent(0.5)
    public var maskClickBlock: (() -> ())?
    /// 仅仅镂空的部分可响应事件
    public var onlyHollowEnable = true
    
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }
    
    // MARK: override
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // 填充整个视图
        let color = maskColor ?? .black.withAlphaComponent(0.5)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        // 如果有镂空路径，进行镂空处理
        if let hollowPath = hollowPath {
            context.addPath(hollowPath.cgPath)
            context.setBlendMode(.clear)
            context.fillPath()
        }
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard onlyHollowEnable, let hollowPath = hollowPath else {
            return super.hitTest(point, with: event)
        }
        // 如果点在镂空区域内，返回 nil，允许事件穿透
        if hollowPath.contains(point) {
            return nil
        }
        // 对于非镂空区域，返回自身，拦截事件
        return self
    }
    
    
    // MARK: func
    @objc
    private func tapAction() {
        maskClickBlock?()
    }
   
}


