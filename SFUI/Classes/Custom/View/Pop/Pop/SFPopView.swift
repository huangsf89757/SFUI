//
//  SFPopView.swift
//  SFUI
//
//  Created by hsf on 2024/7/21.
//

import Foundation
import UIKit
// Basic
import SFBase
// Server
import SFLogger
// Third
import SnapKit


// MARK: - SFPopView
open class SFPopView: SFView {
    // MARK: Status
    public enum Status: Int, Comparable {
        case none = 0
        case willShow
        case showing
        case didShow
        case willDismiss
        case dismissing
        case didDismiss
        
        public static func < (lhs: SFPopView.Status, rhs: SFPopView.Status) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
    
    // MARK: var
    /// 唯一标识
    public var identifier: String = UUID().uuidString
    
    /// 显示状态
    public private(set) var status: Status = .none {
        didSet {
            statusChangedBlock?(status)
        }
    }
    /// 显示状态变更回调
    public var statusChangedBlock: ((Status)->())?
    
    /// 蒙板配置
    public var maskConfigeration = SFMaskConfigeration()
    /// 点击蒙板自动dismiss
    public var autoDismissWhenClickMask = true
    /// 自定义window
    public var windowAppearanceBlock: ((SFPopWindow)->())?
    
    /// show完成回调
    public var showCompletionBlock: ((SFPopView)->())?
    /// dismiss完成回调
    public var dismissCompletionBlock: ((SFPopView)->())?
    
    /// 持续显示时间
    private var stayDuration: TimeInterval?
    /// 持续显示时间到了后执行的任务
    private var stayTask: DispatchWorkItem?
    
    
    // MARK: override
    /// 自定义约束
    open func customLayout() {
        #warning("自定义时重写")
    }
    /// frame已确定
    open func frameDetermined() {
        #warning("自定义时重写")
    }
        
    
    // MARK: show / dismiss
    /// 显示
    /// - Parameters:
    ///   - stay: 持续时间
    ///   - showAnimation: 显示动画
    ///   - dismissAnimation: 消失动画
    ///   - topLevel: window层级
    open func show(in view: UIView? = nil,
                   stay duration: TimeInterval? = nil,
                   showAnimationsBlock: ((SFPopView) -> [CAAnimation])? = nil,
                   dismissAnimationsBlock: ((SFPopView) -> [CAAnimation])? = nil,
                   topLevel: Bool = true) {
        DispatchQueue.main.async {
            let enable = self.willShow(in: view, topLevel: topLevel)
            guard enable else { return }
            if let showAnimationsBlock = showAnimationsBlock {
                self.showing(animationsBlock: showAnimationsBlock)
            } else {
                self.didShow()
            }
            // stay
            self.stayDuration = duration
            self.stayTask?.cancel()
            if let duration = duration {
                let task = DispatchWorkItem {
                    self.dismiss(animationsBlock: dismissAnimationsBlock)
                }
                self.stayTask = task
            }
        }
    }
    
    /// 消失
    /// - Parameter anim: 消失动画
    open func dismiss(animationsBlock: ((SFPopView) -> [CAAnimation])? = nil) {
        DispatchQueue.main.async {
            let enable = self.willDismiss()
            guard enable else { return }
            if let animationsBlock = animationsBlock {
                self.dismissing(animationsBlock: animationsBlock)
            } else {
                self.didDismiss()
            }
        }
    }
}


// MARK: - show
extension SFPopView {
    
    static let showAnimationKey = "showAnimationKey"
    
    private func willShow(in view: UIView? = nil, topLevel: Bool) -> Bool {
        status = .willShow
        layer.removeAllAnimations()
        let (window, isVisible) = self.getOverlayWindow(identifier: self.identifier)
        guard let window = window else { return false }
        if let view = view {
            let frame = view.convert(view.bounds, to: window)
            window.frame = frame
            window.clipsToBounds = true
        }
        self.snp.removeConstraints()
        window.sf.removeAllSubviews(except: window.maskBtn)
        window.addSubview(self)
        customLayout()
        if topLevel || !isVisible {
            SFPopManager.shared.show(identifier: self.identifier, window: window)
        }
        window.setNeedsLayout()
        window.layoutIfNeeded()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        frameDetermined()
        return true
    }
    
    private func showing(animationsBlock: ((SFPopView) -> [CAAnimation])) {
        let animations = animationsBlock(self)
        guard animations.count > 0 else { return }
        status = .showing
        var duration: TimeInterval?
        for animation in animations {
            if let d = duration {
                duration = max(animation.duration, d)
            } else {
                duration = animation.duration
            }
        }
        guard let duration = duration else { return }
        let anim_group = CAAnimationGroup()
        anim_group.delegate = self
        anim_group.animations = animations
        anim_group.duration = duration
        anim_group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        anim_group.isRemovedOnCompletion = false
        anim_group.fillMode = CAMediaTimingFillMode.forwards
        layer.add(anim_group, forKey: SFPopView.showAnimationKey)
        if maskConfigeration.animateEnable {
            let anim = animationOfOpacity(from: 0, to: 1, duration: duration)
            anim.duration = anim_group.duration
            anim.timingFunction = anim_group.timingFunction
            anim.isRemovedOnCompletion = anim_group.isRemovedOnCompletion
            anim.fillMode = anim_group.fillMode
            superview?.layer.add(anim, forKey: SFPopView.showAnimationKey + "_" + "window")
        }
    }
    
    private func didShow() {
        status = .didShow
        showCompletionBlock?(self)
        if let stayDuration = stayDuration, let stayTask = stayTask {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + stayDuration, execute: stayTask)
        }
    }
}


// MARK: - dismiss
extension SFPopView {
    
    static let dismissAnimationKey = "dismissAnimationKey"
    
    private func willDismiss() -> Bool {
        guard status == .didShow else { return false }
        status = .willDismiss
        layer.removeAllAnimations()
        return true
    }
    
    private func dismissing(animationsBlock: ((SFPopView) -> [CAAnimation])) {
        let animations = animationsBlock(self)
        guard animations.count > 0 else { return }
        status = .dismissing
        var duration: TimeInterval?
        for animation in animations {
            if let d = duration {
                duration = max(animation.duration, d)
            } else {
                duration = animation.duration
            }
        }
        guard let duration = duration else { return }
        let anim_group = CAAnimationGroup()
        anim_group.delegate = self
        anim_group.animations = animations
        anim_group.duration = duration
        anim_group.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        anim_group.isRemovedOnCompletion = false
        anim_group.fillMode = CAMediaTimingFillMode.forwards
        layer.add(anim_group, forKey: SFPopView.dismissAnimationKey)
        if maskConfigeration.animateEnable {
            let anim = animationOfOpacity(from: 1, to: 0, duration: duration)
            anim.duration = anim_group.duration
            anim.timingFunction = anim_group.timingFunction
            anim.isRemovedOnCompletion = anim_group.isRemovedOnCompletion
            anim.fillMode = anim_group.fillMode
            superview?.layer.add(anim, forKey: SFPopView.dismissAnimationKey + "_" + "window")
        }
    }
    
    private func didDismiss() {
        removeFromSuperview()
        SFPopManager.shared.dismiss(identifier: self.identifier)
        status = .didDismiss
        dismissCompletionBlock?(self)
    }
}


// MARK: - window
extension SFPopView {
    /// 获取window
    private func getOverlayWindow(identifier: String) -> (SFPopWindow?, Bool) {
        if let window = SFPopManager.shared.map[identifier] {
            windowAppearanceBlock?(window)
            return (window, true)
        }
        var window: SFPopWindow?
        if #available(iOS 13, *), let keyWindowScene = SFApp.keyWindowScene() {
            window = SFPopWindow(windowScene: keyWindowScene)
        } else {
            window = SFPopWindow(frame: UIScreen.main.bounds)
        }
        guard let window = window else { return (nil, false) }
        let savedClickMaskBlock = maskConfigeration.clickMaskBlock
        var clickBlock: (()->())?
        if autoDismissWhenClickMask {
            clickBlock = { [weak self] in
                savedClickMaskBlock?()
                self?.dismiss()
            }
        } else {
            clickBlock = savedClickMaskBlock
        }
        maskConfigeration.clickMaskBlock = clickBlock
        window.configeration = maskConfigeration
        windowAppearanceBlock?(window)
        return (window, false)
    }
}


// MARK: - CAAnimation
extension SFPopView {
    // MARK: Position
    public enum Position {
        case zero
        case top
        case bottom
        case left
        case right
        case width(Bool)
        case height(Bool)
        case offset(CGFloat, CGFloat)
    }
    
    public func animationOfTranslation(from: Position, to: Position, duration: TimeInterval = 0.24) -> CAAnimation {
        let anim = CABasicAnimation(keyPath: "transform.translation")
        anim.fromValue = getValue(position: from)
        anim.toValue = getValue(position: to)
        return anim
        
        func getValue(position: Position) -> CGPoint {
            let superViewRect = UIScreen.main.bounds
            var value = CGPoint.zero
            switch position {
            case .zero:
                value = .zero
            case .top:
                print("frame=\(frame)")
                print("superViewRect=\(superViewRect)")
                value = CGPoint(x: 0, y: -frame.size.height)
//                value = CGPoint(x: 0, y: -superViewRect.height)
            case .bottom:
//                value = CGPoint(x: 0, y: abs(superViewRect.maxY - frame.minY))
                value = CGPoint(x: 0, y: superViewRect.height)
            case .left:
                value = CGPoint(x: -frame.maxX, y: 0)
            case .right:
                value = CGPoint(x: abs(superViewRect.maxX - frame.minX), y: 0)
            case let .width(bool):
                var x: CGFloat = 0
                if bool {
                    x = frame.size.width
                } else {
                    x = -frame.size.width
                }
                value = CGPoint(x: x, y: 0)
            case let .height(bool):
                var y: CGFloat = 0
                if bool {
                    y = frame.size.height
                } else {
                    y = -frame.size.height
                }
                value = CGPoint(x: 0, y: y)
            case let .offset(x, y):
                value = CGPoint(x: x, y: y)
            }
            return value
        }
    }
    
    public func animationOfScale(from: CGFloat, to: CGFloat, duration: TimeInterval = 0.24) -> CAAnimation {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
        return anim
    }
    
    public func animationOfOpacity(from: CGFloat, to: CGFloat, duration: TimeInterval = 0.24) -> CAAnimation {
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = from
        anim.toValue = to
        anim.duration = duration
        return anim
    }
}


// MARK: - CAAnimationDelegate
extension SFPopView: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let showAnimation = self.layer.animation(forKey: SFPopView.showAnimationKey), anim == showAnimation {
            didShow()
        }
        if let dismissAnimation = self.layer.animation(forKey: SFPopView.dismissAnimationKey), anim == dismissAnimation {
            didDismiss()
        }
    }
}
