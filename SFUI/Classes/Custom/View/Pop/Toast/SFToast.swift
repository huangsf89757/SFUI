//
//  SFToast.swift
//  SFUI
//
//  Created by hsf on 2024/7/26.
//

import Foundation
import UIKit

// MARK: - SFToast
public final class SFToast {
    // MARK: singleton
    private static let shared = SFToast()
    public init() {}
    
    // MARK: Position
    public enum Position {
        case top(offset: CGFloat)
        case center(offset: CGFloat)
        case bottom(offset: CGFloat)
    }
    
    
    // MARK: var
    /// toast view
    private lazy var view: SFToastView = {
        return SFToastView()
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
 使用类方法，同一时间只能有一个toastView
 */
extension SFToast {
    /// show
    public static func show(_ msg: String,
                            at position: Position = .center(offset: 0),
                            stay duration: TimeInterval? = 2) {
        SFToast.shared.show(msg,
                            at: position,
                            stay: duration)
    }
    
    /// dismiss
    public static func dismiss() {
        SFToast.shared.dismiss()
    }
}


// MARK: - func (instance)
/*
 注意⚠️
 使用对象方法，同一时间能有多个toastView
 */
extension SFToast {
    /// show
    public func show(_ msg: String,
                     at position: Position = .center(offset: 0),
                     stay duration: TimeInterval? = 2) {
        view.position = position
        view.msg = msg
        view.show(stay: duration, showAnimationsBlock: {
            popView in
            let showAnimationOfTranslation = popView.animationOfTranslation(from: .bottom, to: .zero)
            let showAnimationOfOpacity = popView.animationOfOpacity(from: 0, to: 1)
            return [showAnimationOfTranslation, showAnimationOfOpacity]
        }, dismissAnimationsBlock: {
            popView in
            let translation = popView.animationOfTranslation(from: .zero, to: .bottom)
            let opacity = popView.animationOfOpacity(from: 1, to: 0)
            return [translation, opacity]
        })
    }
    
    /// dismiss
    public func dismiss() {
        view.dismiss()
    }
}


