//
//  SFAlert.swift
//  SFUI
//
//  Created by hsf on 2024/11/28.
//

import Foundation
import UIKit

// MARK: - SFAlert
public final class SFAlert {
    // MARK: singleton
    public static let shared = SFAlert()
    public init() {}
    
    
    // MARK: var
    /// notify view
    private lazy var view: SFAlertView = {
        return SFAlertView()
    }()
    /// 唯一标识
    public private(set) var identifier: String = UUID().uuidString {
        didSet {
            view.identifier = identifier
        }
    }
}


// MARK: - func (class)
/*
 注意⚠️
 使用类方法，同一时间只能有一个sheetView
 */
extension SFAlert {
    /// show
    public static func show(autoDismiss: Bool = false) {
        SFAlert.shared.show(autoDismiss: autoDismiss)
    }
    
    /// dismiss
    public static func dismiss() {
        SFAlert.shared.dismiss()
    }
}
extension SFAlert {
    public static func config(title: String?, msg: String? = nil, tip: String? = nil) {
        SFAlert.shared.config(title: title, msg: msg, tip: tip)
    }
    public static func addCancelAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        SFAlert.shared.addCancelAction(title: title, appearance: appearance, action: action)
    }
    
    public static func addConfirmAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        SFAlert.shared.addConfirmAction(title: title, appearance: appearance, action: action)
    }
    
    public static func addAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        SFAlert.shared.addAction(title: title, appearance: appearance, action: action)
    }
}

// MARK: - func (instance)
/*
 注意⚠️
 使用对象方法，同一时间能有多个sheetView
 */
extension SFAlert {
    /// show
    public func show(autoDismiss: Bool = false) {
        DispatchQueue.main.async {
            self.view.autoDismissWhenClickMask = autoDismiss
            self.view.show(showAnimationsBlock: {
                popView in
                let translation = popView.animationOfTranslation(from: .offset(0, 50), to: .zero)
                let opacity = popView.animationOfOpacity(from: 0, to: 1)
                return [translation, opacity]
            }, dismissAnimationsBlock: {
                popView in
                let translation = popView.animationOfTranslation(from: .zero, to: .offset(0, 50))
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
extension SFAlert {
    public func config(title: String?, msg: String? = nil, tip: String? = nil) {
        self.view.autoDismissWhenClickMask = false
        self.view.config(title: title, msg: msg, tip: tip)
    }
    public func addCancelAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        self.view.addCancelAction(title: title, appearance: appearance, action: action)
    }
    
    public func addConfirmAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        self.view.addConfirmAction(title: title, appearance: appearance, action: action)
    }
    
    public func addAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        self.view.addAction(title: title, appearance: appearance, action: action)
    }
}
