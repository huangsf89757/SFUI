//
//  SFButton.swift
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

// MARK: - SFButton
open class SFButton: UIButton {
    
    // MARK: life cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let style = style {
            buildStyle()
        }
    }
    
    // MARK: Style
    public enum Style {
        case top(CGFloat)
        case left(CGFloat)
        case bottom(CGFloat)
        case right(CGFloat)
    }
    public var style: Style?
    private func buildStyle() {
        guard let style = style else { return }
        let imageView_Width = self.imageView?.frame.size.width
        let imageView_Height = self.imageView?.frame.size.height
        let titleLabel_iCSWidth = self.titleLabel?.intrinsicContentSize.width
        let titleLabel_iCSHeight = self.titleLabel?.intrinsicContentSize.height
        switch style {
        case .top(let space):
            self.imageEdgeInsets = UIEdgeInsets.init(top: -(titleLabel_iCSHeight! + space), left: 0, bottom: 0, right: -titleLabel_iCSWidth!)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageView_Width!, bottom: -(imageView_Height! + space), right: 0)
        case .left(let space):
            if self.contentHorizontalAlignment == .left {
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: space, bottom: 0, right: 0)
            } else if self.contentHorizontalAlignment == .right {
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: space)
            } else {
                let spacing_half = 0.5 * space;
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -spacing_half, bottom: 0, right: spacing_half)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing_half, bottom: 0, right: -spacing_half)
            }
        case .bottom(let space):
            self.imageEdgeInsets = UIEdgeInsets.init(top: titleLabel_iCSHeight! + space, left: 0, bottom: 0, right: -titleLabel_iCSWidth!)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageView_Width!, bottom: imageView_Height! + space, right: 0)
        case .right(let space):
            let titleLabelWidth = self.titleLabel?.frame.size.width
            if self.contentHorizontalAlignment == .left {
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleLabelWidth! + space, bottom: 0, right: 0)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageView_Width!, bottom: 0, right: 0)
            } else if self.contentHorizontalAlignment == .right {
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -titleLabelWidth!)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: imageView_Width! + space)
            } else {
                let imageOffset = titleLabelWidth! + 0.5 * space
                let titleOffset = imageView_Width! + 0.5 * space
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
            }
        }
    }
    
    // MARK: hitInsets
    /// 自定义可点击响应范围
    public var hitInsets: UIEdgeInsets?
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let hitInsets = hitInsets {
            let rect = bounds.inset(by: hitInsets)
            return rect.contains(point)
        }
        return super.point(inside: point, with: event)
    }
    
    // MARK: toggle
    public func toggleSelected() {
        let isSelected = self.isSelected
        self.isSelected = !isSelected
    }
}
