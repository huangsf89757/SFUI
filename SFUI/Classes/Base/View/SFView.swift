//
//  SFView.swift
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

open class SFView: UIView {
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = SFColor.UI.content
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - hitInsets
    /// 自定义可点击响应范围
    public var hitInsets: UIEdgeInsets?
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let hitInsets = hitInsets {
            let rect = bounds.inset(by: hitInsets)
            return rect.contains(point)
        }
        return super.point(inside: point, with: event)
    }
    
}
