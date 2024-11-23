//
//  SFLabel.swift
//  SFUI
//
//  Created by hsf on 2024/7/18.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Third
import Then
import SnapKit
import SnapKitExtend

public typealias SFLinkAction = () -> Void

// MARK: - SFLabel
open class SFLabel: UILabel {
    // MARK: var
    
    /// 链接Range
    public private(set) var linkRanges: [NSRange] = []
    /// 链接响应事件
    public private(set) var linkActions: [SFLinkAction?] = []
    /// 是否开启点击事件
    private var isTapEnabled = false
   
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        numberOfLines = 0
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 自定义内容缩进
    public var edgeInsert: UIEdgeInsets = .zero
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= edgeInsert.left
        rect.origin.y -= edgeInsert.top
        rect.size.width += (edgeInsert.left + edgeInsert.right)
        rect.size.height += (edgeInsert.top + edgeInsert.bottom)
        return rect
    }
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsert))
    }
}

// MARK: - func
extension SFLabel {
    /// 根据宽度自动调整字间距
    public func adjustTextSpacingToFitWidth() {
        guard let labelText = self.text else {
            return
        }
        let textWidth = (labelText as NSString).size(withAttributes: [NSAttributedString.Key.font : self.font]).width
        guard textWidth <= self.frame.width else {
            return
        }
        let kern = (self.frame.width - textWidth) / CGFloat(labelText.count - 1)
        let attributedText = NSMutableAttributedString(string: labelText)
        let newAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: self.font,
            NSAttributedString.Key.kern: kern
        ]
        if attributedText.length > 1 {
            attributedText.setAttributes(newAttributes, range: NSRange(location: 0, length: attributedText.length - 1))
            attributedText.addAttribute(NSAttributedString.Key.kern, value: 0, range: NSRange(location: attributedText.length - 1, length: 1))
        } else {
            attributedText.setAttributes(newAttributes, range: NSRange(location: 0, length: attributedText.length))
        }
        self.attributedText = attributedText
    }
}


// MARK: - link
extension SFLabel {
    
    /// 添加链接
    /// - Parameters:
    ///   - text: 文本
    ///   - attrs: 属性
    ///   - action: 响应事件
    public func addLink(text: String,
                        attrs: [NSAttributedString.Key: Any]? = nil,
                        action: SFLinkAction?) {
        guard let attributedText = attributedText else {
            return
        }
        
        if isTapEnabled == false {
            isUserInteractionEnabled = true
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
            isTapEnabled = true
        }
        
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        let range = (mutableAttributedText.string as NSString).range(of: text)
        
        mutableAttributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        mutableAttributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        
        if let attrs = attrs {
            mutableAttributedText.addAttributes(attrs, range: range)
        }
        
        self.attributedText = mutableAttributedText
        linkRanges.append(range)
        linkActions.append(action)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let attributedText = attributedText else {
            return
        }
        
        let location = gesture.location(in: self)
        
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)
        
        layoutManager.ensureLayout(for: textContainer)
        
//        let textBoundingBox = layoutManager.usedRect(for: textContainer)
//        
//        if !textBoundingBox.contains(location) {
//            return
//        }
        
        // FIXME: index 计算不正确
        let index = layoutManager.characterIndex(for: location, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        for (range, action) in zip(linkRanges, linkActions) {
            if NSLocationInRange(index, range) {
                action?()
                break
            }
        }
    }
}
