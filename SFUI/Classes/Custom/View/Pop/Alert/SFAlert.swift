//
//  SFAlert.swift
//  SFUI
//
//  Created by hsf on 2024/7/27.
//

import Foundation
import UIKit

// MARK: - SFAlert
public final class SFAlert {
    // MARK: singleton
    private static let shared = SFAlert()
    public init() {}
    
    // MARK: AlertStyle
    public enum AlertStyle {
        case alert
        case sheet
    }
    // MARK: HeaderStyle
    public enum HeaderStyle {
        case center
        case leading
    }
    // MARK: ActionStyle
    public enum ActionStyle {
        case block
        case border
    }
    // MARK: FooterStyle
    public enum FooterStyle {
        case spacing    // 跟边框有间距20
        case edging     // 紧贴着边框
    }
    
    // MARK: var
    /// alert view
    private lazy var view: SFAlertView = {
        return SFAlertView()
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
 使用类方法进行alert，同一时间只能有一个alertView
 */
extension SFAlert {
    /// show
    public static func show(alertStyle: AlertStyle = .alert,
                            headerStyle: HeaderStyle = .center,
                            actionStyle: ActionStyle = .block,
                            footerStyle: FooterStyle = .spacing,
                            title: String? = nil,
                            msg: String? = nil,
                            offset: CGFloat = 0,
                            stay duration: TimeInterval? = nil) {
        SFAlert.shared.show(alertStyle: alertStyle,
                            headerStyle: headerStyle,
                            actionStyle: actionStyle,
                            footerStyle: footerStyle,
                            title: title,
                            msg: msg,
                            offset: offset,
                            stay: duration)
    }
    
    /// dismiss
    public static func dismiss() {
        SFAlert.shared.dismiss()
    }
    
    /// 添加cancel事件
    public static func addCancelAction(title: String, appearance: ((SFButton) -> ())? = nil, action: ((SFPopView) -> Bool)? = nil) {
        SFAlert.shared.addCancelAction(title: title, appearance: appearance, action: action)
    }
    
    /// 添加sure事件
    public static func addSureAction(title: String, appearance: ((SFButton) -> ())? = nil, action: ((SFPopView) -> Bool)? = nil) {
        SFAlert.shared.addSureAction(title: title, appearance: appearance, action: action)
    }
    
    /// 添加custom事件
    public static func addCustomAction(style: ActionStyle, title: String, appearance: ((SFButton) -> ())? = nil, action: ((SFPopView) -> Bool)? = nil) {
        SFAlert.shared.addCustomAction(style: style, title: title, appearance: appearance, action: action)
    }
}


// MARK: - func (instance)
/*
 注意⚠️
 使用对象方法进行alert，同一时间能有多个alertView
 */
extension SFAlert {
    /// show
    public func show(alertStyle: AlertStyle = .alert,
                     headerStyle: HeaderStyle = .center,
                     actionStyle: ActionStyle = .block,
                     footerStyle: FooterStyle = .spacing,
                     title: String? = nil,
                     msg: String? = nil,
                     offset: CGFloat = 0,
                     stay duration: TimeInterval? = nil) {
        view.alertStyle = alertStyle
        view.headerStyle = headerStyle
        view.actionStyle = actionStyle
        view.footerStyle = footerStyle
        view.title = title
        view.msg = msg
        view.offset = offset
        var from_show: SFPopView.Position = .zero
        var to_show: SFPopView.Position = .zero
        var from_dismiss: SFPopView.Position = .zero
        var to_dismiss: SFPopView.Position = .zero
        switch alertStyle {
        case .alert:
            from_show = .offset(0, 50)
            to_show = .zero
            from_dismiss = .zero
            to_dismiss = .offset(0, 50)
        case .sheet:
            from_show = .bottom
            to_show = .zero
            from_dismiss = .zero
            to_dismiss = .bottom
        }
        view.show(stay: duration, showAnimationsBlock: {
            popView in
            let showAnimationOfTranslation = popView.animationOfTranslation(from: from_show, to: to_show)
            let showAnimationOfOpacity = popView.animationOfOpacity(from: 0, to: 1)
            return [showAnimationOfTranslation, showAnimationOfOpacity]
        }, dismissAnimationsBlock: {
            popView in
            let translation = popView.animationOfTranslation(from: from_dismiss, to: to_dismiss)
            let opacity = popView.animationOfOpacity(from: 1, to: 0)
            return [translation, opacity]
        })
    }
    
    /// dismiss
    public func dismiss() {
        view.dismiss()
    }
    
    /// 添加cancel事件
    public func addCancelAction(title: String, appearance: ((SFButton) -> ())? = nil, action: ((SFPopView) -> Bool)? = nil) {
        view.cancel = title
        view.cancelAppearanceBlock = appearance
        view.cancelActionBlock = action
    }
    
    /// 添加sure事件
    public func addSureAction(title: String, appearance: ((SFButton) -> ())? = nil, action: ((SFPopView) -> Bool)? = nil) {
        view.sure = title
        view.sureAppearanceBlock = appearance
        view.sureActionBlock = action
    }
    
    /// 添加custom事件
    public func addCustomAction(style: ActionStyle, title: String, appearance: ((SFButton) -> ())? = nil, action: ((SFPopView) -> Bool)? = nil) {
        var dict = [String: Any]()
        dict["style"] = style
        dict["title"] = title
        dict["appearance"] = appearance
        dict["action"] = action
        view.customActions.append(dict)
    }
}
