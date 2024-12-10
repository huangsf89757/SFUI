//
//  SFNotify.swift
//  SFUI
//
//  Created by hsf on 2024/8/1.
//

import Foundation
import UIKit

// MARK: - SFNotify
public final class SFNotify {
    // MARK: singleton
    public static let shared = SFNotify()
    public init() {}
    
    
    // MARK: var
    /// notify view
    private lazy var view: SFNotifyView = {
        return SFNotifyView()
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
 使用类方法，同一时间只能有一个notifyView
 */
extension SFNotify {
    /// show
    public static func show(title: String?,
                            msg: String? = nil,
                            icon: UIImage? = nil,
                            stay duration: TimeInterval? = 5) {
        SFNotify.shared.show(title: title,
                             msg: msg,
                             icon: icon,
                             stay: duration)
    }
    
    /// dismiss
    public static func dismiss() {
        SFNotify.shared.dismiss()
    }
}


// MARK: - func (instance)
/*
 注意⚠️
 使用对象方法，同一时间能有多个notifyView
 */
extension SFNotify {
    /// show
    public func show(title: String?,
                     msg: String? = nil,
                     icon: UIImage? = nil,
                     stay duration: TimeInterval? = 5) {
        DispatchQueue.main.async {
            self.view.icon = icon
            self.view.title = title
            self.view.msg = msg
            self.view.show(stay: duration, showAnimationsBlock: {
                popView in
                let showAnimationOfTranslation = popView.animationOfTranslation(from: .top, to: .zero)
                let showAnimationOfOpacity = popView.animationOfOpacity(from: 0, to: 1)
                return [showAnimationOfTranslation, showAnimationOfOpacity]
            }, dismissAnimationsBlock: {
                popView in
                let translation = popView.animationOfTranslation(from: .zero, to: .top)
                let opacity = popView.animationOfOpacity(from: 1, to: 0)
                return [translation, opacity]
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
