//
//  SFSvgView.swift
//  SFUI
//
//  Created by hsf on 2024/12/26.
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
import Macaw

open class SFSvgView: MacawView {
    // MARK: var
    public var svg: Macaw.Node? {
        didSet {
            guard let svg = svg else { return }
            node = svg
        }
    }
    
    private var _fillColor: UIColor?
    public var fillColor: UIColor? {
        didSet {
            _fillColor = fillColor
            applyFill()
        }
    }
    
    private var _strokeColor: UIColor?
    public var strokeColor: UIColor? {
        didSet {
            _strokeColor = strokeColor
            applyStroke()
        }
    }
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    public override init?(node: Node, coder aDecoder: NSCoder) {
        super.init(node: node, coder: aDecoder)
        config()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(node: Group(), coder: aDecoder)
        config()
    }
    private func config() {
        contentMode = .scaleAspectFit
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            applyFill()
            applyStroke()
        }
    }

}

// MARK: Fill
extension SFSvgView {
    private func applyFill() {
        guard let fillColor = _fillColor, let hex = fillColor.sf.toHexInt() else { return }
        applyFill(to: node, with: Color(hex))
    }
    private func applyFill(to node: Macaw.Node?, with color: Color) {
        guard let node = node else { return }
        if let shape = node as? Shape {
            shape.fill = color
        } else if let group = node as? Group {
            group.contents.forEach { applyFill(to: $0, with: color) }
        }
    }
}

// MARK: Stroke
extension SFSvgView {
    private func applyStroke() {
        guard let strokeColor = _strokeColor, let hex = strokeColor.sf.toHexInt() else { return }
        applyFill(to: node, with: Color(hex))
    }
    private func applyStroke(to node: Macaw.Node?, with color: Color) {
        guard let node = node else { return }
        if let shape = node as? Shape {
            shape.stroke = Stroke(fill: color, width: shape.stroke?.width ?? 1)
        } else if let group = node as? Group {
            group.contents.forEach { applyStroke(to: $0, with: color) }
        }
    }
}
