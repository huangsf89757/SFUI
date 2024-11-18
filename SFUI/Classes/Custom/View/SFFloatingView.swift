//
//  SFFloatingView.swift
//  SFUI
//
//  Created by hsf on 2024/7/21.
//

import Foundation
import UIKit
// Basic
import SFExtension

private let k_SFKey_stayFrame = "k_SFKey_stayFrame"
open class SFFloatingView: SFView {
    
    public struct StayEdge: OptionSet {
        public var rawValue: UInt8
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
        
        // '岸边'位置
        public static let top = StayEdge(rawValue: 1 << 0)
        public static let left = StayEdge(rawValue: 1 << 1)
        public static let right = StayEdge(rawValue: 1 << 2)
        public static let bottom = StayEdge(rawValue: 1 << 3)
        public static let all = StayEdge(rawValue: ((1 << 0) + (1 << 1) + (1 << 2) + (1 << 3)))
        
        // 任意位置
        public static let any = StayEdge(rawValue: 1 << 4)
    }
    
    
    // MARK: var
    /// 是否可移动（默认 true）
    public var movable: Bool = true
    /// 停留方式（默认 .all）
    public var edge: StayEdge = .all
    /// ‘岸边’缩进
    public var stayEdgeInsert: UIEdgeInsets = .zero
    /// 是否自动隐藏（默认 true）
    public var autoHide = true
    /// 隐藏比例（0 ~ 1，默认0.5）
    public var hidePercent = 0.5 {
        willSet {
            if newValue < 0 {
                self.hidePercent = 0
            }
            else if newValue > 1 {
                self.hidePercent = 1
            }
        }
    }
    /// 隐藏透明度（0 ~ 1，默认0.5）
    public var hideAlpha = 0.5 {
        willSet {
            if newValue < 0 {
                self.hideAlpha = 0
            }
            else if newValue > 1 {
                self.hideAlpha = 1
            }
        }
    }
    
    /// 停靠位置
    private var _stayFrame: CGRect?
    public var stayFrame: CGRect? {
        get {
            if let _stayFrame = _stayFrame { return _stayFrame }
            guard let stayFrame = UserDefaults.standard.string(forKey: k_SFKey_stayFrame) else { return nil }
            let frame = stayFrame.sf.toCGRect
            _stayFrame = frame
            return frame
        }
        set {
            _stayFrame = newValue
            guard let newValue = newValue else {
                UserDefaults.standard.set(nil, forKey: k_SFKey_stayFrame)
                return
            }
            UserDefaults.standard.set(newValue.sf.toString, forKey: k_SFKey_stayFrame)
        }
    }
    /// 停靠动画时间（默认0.24）
    public var moveDuration: TimeInterval = 0.24
    /// 停留时间（默认3.0）
    public var stayDuration: TimeInterval = 3.0
    /// 隐藏动画时间（默认0.3）
    public var hideDuration: TimeInterval = 0.24
    
    /// 是否正在移动
    public private(set) var isMoving: Bool = false
    /// 是否正在隐藏
    public private(set) var isHiding: Bool = false
    /// 单击回调
    public var clickBlock: (() -> Void)?
    
    /// 保留的停靠边
    private var savedEdge: StayEdge?
    /// 保留的透明度
    private var savedAlpha: CGFloat?
    /// 保留的停靠点
    private var savedPoint: CGPoint?
    /// 隐藏任务
    private var hideTask: DispatchWorkItem?
    
    /// '泳池' 可移动范围
    private var movableRect: CGRect {
        guard let superview = superview else { return .zero }
        let left = (stayEdgeInsert.left >= 0) ? stayEdgeInsert.left : 0;
        let right = (stayEdgeInsert.right >= 0) ? stayEdgeInsert.right : 0;
        let top = (stayEdgeInsert.top >= 0) ? stayEdgeInsert.top : 0;
        let bottom = (stayEdgeInsert.bottom >= 0) ? stayEdgeInsert.bottom : 0;
        let width = ((superview.bounds.size.width - left - right) > 0) ? (superview.bounds.size.width - left - right) : 0;
        let height = ((superview.bounds.size.height - top - bottom) > 0) ? (superview.bounds.size.height - top - bottom) : 0;
        return CGRect(x: left,
                      y: top,
                      width: width,
                      height: height)
    }
    
    
    // MARK: - life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickedSelf))
        tap.delaysTouchesBegan = true
        addGestureRecognizer(tap)
    }
    
    // MARK: - action
    @objc private func clickedSelf() {
        self.hideTask?.cancel()
        if isHiding {
            showAnimation() { [weak self] _ in
                guard let self = self else { return }
                guard self.autoHide else { return }
                let task = DispatchWorkItem {
                    guard !self.isMoving else { return }
                    self.hideAnimation()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + self.stayDuration, execute: task)
                self.hideTask = task
            }
        } else {
            guard !isMoving else { return }
            clickBlock?()
        }
    }
    
    // MARK: - touch
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if movable && !isHiding {
            self.hideTask?.cancel()
            isMoving = true
            let touch = touches.first
            let curPoint: CGPoint = touch?.location(in: self) ?? .zero
            let prePoint: CGPoint = touch?.previousLocation(in: self) ?? .zero
            
            var newFrame = frame
            newFrame.origin.x += curPoint.x - prePoint.x
            newFrame.origin.y += curPoint.y - prePoint.y
            self.frame = newFrame
        }
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isHiding {
            moveEnd()
        }
    }
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isHiding {
            moveEnd()
        }
    }
    
    
    // MARK: - func
    /// 结束移动
    private func moveEnd() {
        if isMoving {
            isMoving = false
        }
        moveAnimation() { [weak self] _ in
            guard let self = self else { return }
            self.stayFrame = self.frame
            guard self.autoHide else { return }
            let task = DispatchWorkItem {
                guard !self.isMoving else { return }
                self.hideAnimation()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + self.stayDuration, execute: task)
            self.hideTask = task
        }
    }
    
    // MARK: animation
    /// 移动后寻找最佳停靠点动画
    private func moveAnimation(_ completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: moveDuration) { [weak self] in
            guard let self = self else { return }
            let point = self.center
            let edge = self.getOptimalStayEdge(from: point)
            self.center = self.getStayPoint(from: point, to: edge)
            self.savedEdge = edge
            self.savedAlpha = self.alpha
            self.savedPoint = self.center
        } completion: { finished in
            completion?(finished)
        }
    }
    /// 停好后，隐藏动画
    private func hideAnimation(_ completion: ((Bool) -> Void)? = nil) {
        self.isHiding = true
        UIView.animate(withDuration: hideDuration) { [weak self] in
            guard let self = self else { return }
            self.alpha = self.hideAlpha
            let point = self.center
            if let savedEdge = self.savedEdge {
                self.center = self.getHidePoint(from: point, to: savedEdge)
            }
        } completion: { finished in
            completion?(finished)
        }
    }
    /// 从隐藏中显示出来动画
    private func showAnimation(_ completion: ((Bool) -> Void)? = nil) {
        self.isHiding = false
        UIView.animate(withDuration: hideDuration) { [weak self] in
            guard let self = self else { return }
            if let savedAlpha = self.savedAlpha {
                self.alpha = savedAlpha
            }
            if let savedPoint = self.savedPoint {
                self.center = savedPoint
            }
        } completion: { finished in
            completion?(finished)
        }
    }
    
    
    // MARK: help func
    /// 获取‘停靠点’ center
    private func getStayPoint(from point: CGPoint, to edge: StayEdge) -> CGPoint {
        // ‘泳池岸边’
        let minX = CGRectGetMinX(movableRect) + frame.width / 2.0
        let maxX = CGRectGetMaxX(movableRect) - frame.width / 2.0
        let minY = CGRectGetMinY(movableRect) + frame.height / 2.0
        let maxY = CGRectGetMaxY(movableRect) - frame.height / 2.0
        
        // 停靠点位置
        var toPoint = point
        switch edge {
        case .top:
            toPoint.y = minY
        case .left:
            toPoint.x = minX
        case .bottom:
            toPoint.y = maxY
        case .right:
            toPoint.x = maxX
        default:
            break
        }
        
        // safePoint
        var safePoint = toPoint;
        if safePoint.x < minX {
            safePoint.x = minX
        }
        if safePoint.x > maxX {
            safePoint.x = maxX
        }
        if safePoint.y < minY {
            safePoint.y = minY
        }
        if safePoint.y > maxY {
            safePoint.y = maxY
        }
        
        return safePoint
    }
    
    /// 获取‘隐藏点’ center
    private func getHidePoint(from point: CGPoint, to edge: StayEdge) -> CGPoint {
        guard let superview = superview else { return point }
        // ‘泳池岸边’
        let minX = CGRectGetMinX(superview.bounds) + frame.width * (1.0 / 2.0 - hidePercent)
        let maxX = CGRectGetMaxX(superview.bounds) - frame.width * (1.0 / 2.0 - hidePercent)
        let minY = CGRectGetMinY(superview.bounds) + frame.height * (1.0 / 2.0 - hidePercent)
        let maxY = CGRectGetMaxY(superview.bounds) - frame.height * (1.0 / 2.0 - hidePercent)
        
        // 停靠点位置
        var toPoint = point
        switch edge {
        case .top:
            toPoint.y = minY
        case .left:
            toPoint.x = minX
        case .bottom:
            toPoint.y = maxY
        case .right:
            toPoint.x = maxX
        default:
            break
        }
        
        // safePoint
        var safePoint = toPoint;
        if safePoint.x < minX {
            safePoint.x = minX
        }
        if safePoint.x > maxX {
            safePoint.x = maxX
        }
        if safePoint.y < minY {
            safePoint.y = minY
        }
        if safePoint.y > maxY {
            safePoint.y = maxY
        }
        
        return safePoint
    }
    
    /// 获取最优停靠边
    func getOptimalStayEdge(from point: CGPoint) -> StayEdge {
        // ‘泳池岸边’
        let minX = CGRectGetMinX(movableRect) + frame.width / 2.0
        let maxX = CGRectGetMaxX(movableRect) - frame.width / 2.0
        let minY = CGRectGetMinY(movableRect) + frame.height / 2.0
        let maxY = CGRectGetMaxY(movableRect) - frame.height / 2.0
        
        // 最优停靠边
        if edge != .any {
            // 相较于'岸边'的偏移量
            let edgeOffsetTop = point.y - minY
            let edgeOffsetLeft = point.x - minX
            let edgeOffsetBottom = (maxY - minY) - edgeOffsetTop
            let edgeOffsetRight = (maxX - minX) - edgeOffsetLeft
            
            // 获取最优停靠边
            var edgeOffsets: [CGFloat: StayEdge] = [:]
            if edge.contains(.top) {
                edgeOffsets[edgeOffsetTop] = .top
            }
            if edge.contains(.left) {
                edgeOffsets[edgeOffsetLeft] = .left
            }
            if edge.contains(.bottom) {
                edgeOffsets[edgeOffsetBottom] = .bottom
            }
            if edge.contains(.right) {
                edgeOffsets[edgeOffsetRight] = .right
            }
            guard let minEdgeOffset = edgeOffsets.keys.min(),
                  let edge = edgeOffsets[minEdgeOffset]
            else { return .right }
            return edge
        }
        return .any
    }
}
