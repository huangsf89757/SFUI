//
//  SFSheet.swift
//  SFUI
//
//  Created by hsf on 2024/11/28.
//

import Foundation
import UIKit

// MARK: - SFSheet
public final class SFSheet {
    // MARK: singleton
    public static let shared = SFSheet()
    public init() {}
    
    
    // MARK: var
    /// notify view
    private lazy var view: SFSheetView = {
        return SFSheetView()
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
 使用类方法，同一时间只能有一个sheetView
 */
extension SFSheet {
    /// show
    public static func show(title: String?,
                            msg: String? = nil,
                            cancel: String?,
                            cancelActionBlock: ((SFPopView) -> Bool)? = nil,
                            sure: String?,
                            sureActionBlock: ((SFPopView) -> Bool)? = nil) {
        SFSheet.shared.show(title: title,
                            msg: msg,
                            cancel: cancel,
                            cancelActionBlock: cancelActionBlock,
                            sure: sure,
                            sureActionBlock: sureActionBlock)
    }
    
    /// dismiss
    public static func dismiss() {
        SFSheet.shared.dismiss()
    }
}


// MARK: - func (instance)
/*
 注意⚠️
 使用对象方法，同一时间能有多个sheetView
 */
extension SFSheet {
    /// show
    public func show(title: String?,
                     msg: String? = nil, 
                     cancel: String?,
                     cancelActionBlock: ((SFPopView) -> Bool)? = nil,
                     sure: String?,
                     sureActionBlock: ((SFPopView) -> Bool)? = nil) {
        DispatchQueue.main.async {
            self.view.titleLabel.text = title
            self.view.msgLabel.text = msg
            self.view.cancelBtn.setTitle(cancel, for: .normal)
            self.view.cancelActionBlock = cancelActionBlock
            self.view.sureBtn.setTitle(sure, for: .normal)
            self.view.sureActionBlock = sureActionBlock
            self.view.show(showAnimationsBlock: {
                popView in
                let translation = popView.animationOfTranslation(from: .bottom, to: .zero)
                let opacity = popView.animationOfOpacity(from: 0, to: 1)
                return [translation, opacity]
            }, dismissAnimationsBlock: {
                popView in
                let translation = popView.animationOfTranslation(from: .zero, to: .bottom)
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
