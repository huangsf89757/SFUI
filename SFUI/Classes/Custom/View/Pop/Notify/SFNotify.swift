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

extension SFNotify {
    /// config
    public func config(title: String?,
                     msg: String? = nil,
                     icon: UIImage? = nil) {
        view.icon = icon
        view.title = title
        view.msg = msg
    }
    /// show
    public func show(stay duration: TimeInterval? = 5) {
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
