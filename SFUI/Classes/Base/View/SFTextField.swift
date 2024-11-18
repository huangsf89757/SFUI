//
//  SFTextField.swift
//  SFUI
//
//  Created by hsf on 2024/7/18.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// Third
import Then
import SnapKit
import SnapKitExtend


// MARK: - SFTextField
open class SFTextField: UITextField {
    
    // MARK: 占位文本颜色
    public var placeholderColor: UIColor? {
        didSet {
            updateAttributedPlaceholder()
        }
    }
    open override var placeholder: String? {
        didSet {
            updateAttributedPlaceholder()
        }
    }
    open override var font: UIFont? {
        didSet {
            updateAttributedPlaceholder()
        }
    }
    private func updateAttributedPlaceholder() {
        var attrs = [NSAttributedString.Key: Any]()
        if let placeholderColor = placeholderColor {
            attrs[NSAttributedString.Key.foregroundColor] = placeholderColor
        }
        if let font = font {
            attrs[NSAttributedString.Key.font] = font
        }
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attrs)
    }
    
    // MARK: 内容缩进
    public var textContainerInset: UIEdgeInsets?
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        if let insets = textContainerInset {
            let newBounds = bounds.inset(by: insets)
            return super.textRect(forBounds: newBounds)
        }
        return super.textRect(forBounds: bounds)
    }
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if let insets = textContainerInset {
            let newBounds = bounds.inset(by: insets)
            return super.placeholderRect(forBounds: newBounds)
        }
        return super.placeholderRect(forBounds: bounds)
    }
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if let insets = textContainerInset {
            let newBounds = bounds.inset(by: insets)
            return super.editingRect(forBounds: newBounds)
        }
        return super.editingRect(forBounds: bounds)
    }
        
}
