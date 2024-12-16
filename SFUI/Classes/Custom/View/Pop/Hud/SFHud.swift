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
        
        public var text: String {
            switch self {
            case .loading:
                return SFText.UI.hud_loading
            case .success:
                return SFText.UI.hud_success
            case .failure:
                return SFText.UI.hud_failure
            case .info:
                return SFText.UI.hud_info
            case .warning:
                return SFText.UI.hud_warning
            case .error:
                return SFText.UI.hud_error
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
                            msg: String? = nil,
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
                     msg: String? = nil,
                     offset: CGFloat = 0,
                     stay duration: TimeInterval? = nil,
                     closeTime: TimeInterval = 5,
                     closeBlock: ((SFPopView)->())? = nil) {
        DispatchQueue.main.async {
            self.view.style = style
            self.view.msg = msg ?? style.text
            self.view.offset = offset
            self.view.closeTime = closeTime
            self.view.closeBlock = closeBlock
            self.view.show(stay: duration, showAnimationsBlock: {
                popView in
                let showAnimationOfScale = popView.animationOfScale(from: 0.8, to: 1)
                let showAnimationOfOpacity = popView.animationOfOpacity(from: 0, to: 1)
                return [showAnimationOfScale, showAnimationOfOpacity]
            }, dismissAnimationsBlock: {
                popView in
                let scale = popView.animationOfScale(from: 1, to: 0.8)
                let opacity = popView.animationOfOpacity(from: 1, to: 0)
                return [scale, opacity]
            })
        }
    }
    
    /// dismiss
    public func dismiss() {
        DispatchQueue.main.async {
            self.view.dismiss()
        }
    }
}
