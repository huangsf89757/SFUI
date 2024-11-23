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
    private static let shared = SFNotify()
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
 使用类方法进行notify，同一时间只能有一个notifyView
 */
extension SFNotify {
    /// show
    public static func show(icon: UIImage?,
                            title: String?,
                            msg: String?,
                            stay duration: TimeInterval? = 5) {
        SFNotify.shared.show(icon: icon,
                             title: title,
                             msg: msg,
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
 使用对象方法进行notify，同一时间能有多个notifyView
 */
extension SFNotify {
    /// show
    public func show(icon: UIImage?,
                     title: String?,
                     msg: String?,
                     stay duration: TimeInterval? = 5) {
        view.icon = icon
        view.title = title
        view.msg = msg
        view.show(stay: duration, showAnimationsBlock: {
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
    
    /// dismiss
    public func dismiss() {
        view.dismiss()
    }
}
