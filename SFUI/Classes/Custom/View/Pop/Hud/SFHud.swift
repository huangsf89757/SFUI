//
//  SFHud.swift
//  SFUI
//
//  Created by hsf on 2024/7/27.
//

import Foundation
import UIKit
// Basic
import SFBase

// MARK: - SFHud
public final class SFHud {
    // MARK: singleton
    private static let shared = SFHud()
    public init() {}
    
    // MARK: Style
    public enum Style {
        case loading
        case success
        case failure
        case info
        case warning
        case error
        
        public var image: UIImage? {
            switch self {
            case .loading:
                return SFImage.UI.Hud.loading
            case .success:
                return SFImage.UI.Hud.success
            case .failure:
                return SFImage.UI.Hud.failure
            case .info:
                return SFImage.UI.Hud.info
            case .warning:
                return SFImage.UI.Hud.warning
            case .error:
                return SFImage.UI.Hud.error
            }
        }
    }
    
    
    // MARK: var
    /// hud view
    private lazy var view: SFHudView = {
        return SFHudView()
    }()
    /// 唯一标识
    public var identifier: String = UUID().uuidString {
        didSet {
            view.identifier = identifier
        }
    }
}


// MARK: - func (class)
/*
 注意⚠️
 使用类方法进行hud，同一时间只能有一个hudView
 */
extension SFHud {
    /// show
    public static func show(_ style: Style,
                            msg: String,
                            offset: CGFloat = 0,
                            stay duration: TimeInterval? = nil,
                            closeTime: TimeInterval = 5,
                            closeBlock: ((SFPopView)->())? = nil) {
        SFHud.shared.show(style,
                          msg: msg,
                          stay: duration,
                          closeTime: closeTime,
                          closeBlock: closeBlock)
    }
    
    /// dismiss
    public static func dismiss() {
        SFHud.shared.dismiss()
    }
}


// MARK: - func (instance)
/*
 注意⚠️
 使用对象方法进行hud，同一时间能有多个hudView
 */
extension SFHud {
    /// show
    public func show(_ style: Style,
                     msg: String,
                     offset: CGFloat = 0,
                     stay duration: TimeInterval? = nil,
                     closeTime: TimeInterval = 5,
                     closeBlock: ((SFPopView)->())? = nil) {
        view.style = style
        view.msg = msg
        view.offset = offset
        view.closeTime = closeTime
        view.closeBlock = closeBlock
        let animDuration: TimeInterval = 0.24
        let showAnimationOfScale = view.animationOfScale(from: 0.8, to: 1, duration: animDuration)
        let showAnimationOfOpacity = view.animationOfOpacity(from: 0, to: 1, duration: animDuration)
        let dismissAnimationOfScale = view.animationOfScale(from: 1, to: 0.8, duration: animDuration)
        let dismissAnimationOfOpacity = view.animationOfOpacity(from: 1, to: 0, duration: animDuration)
        let showAnimations = [showAnimationOfScale, showAnimationOfOpacity]
        let dismissAnimations = [dismissAnimationOfScale, dismissAnimationOfOpacity]
        view.show(stay: duration, showAnimations: showAnimations, dismissAnimations: dismissAnimations)
    }
    
    /// dismiss
    public func dismiss() {
        view.dismiss()
    }
}
