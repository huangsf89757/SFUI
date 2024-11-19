//
//  SFSegmentIndicatorView.swift
//  SFUI
//
//  Created by hsf on 2024/9/3.
//

import Foundation
import UIKit
// Basic
import SFBase

// MARK: - SFSegmentIndicatorView
open class SFSegmentIndicatorView: SFView {
    // MARK: var
    /// 颜色
    public var color = SFColor.UI.theme
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
}

// MARK: - SFSegmentIndicatorPositionView
open class SFSegmentIndicatorPositionView: SFSegmentIndicatorView {
    // MARK: Position
    public enum Position {
        case top(CGFloat)
        case leading(CGFloat)
        case trailing(CGFloat)
        case bottom(CGFloat)
    }
    
    // MARK: var
    /// 位置
    public private(set) var position: Position
    
    
    // MARK: life cycle
    public init(position: Position = .bottom(0)) {
        self.position = position
        super.init(frame: .zero)
    }
}
