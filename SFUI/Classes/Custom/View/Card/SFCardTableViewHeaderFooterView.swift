//
//  SFCardTableViewHeaderFooterView.swift
//  SFUI
//
//  Created by hsf on 2024/7/22.
//

import Foundation
import UIKit
// Third
import Then


// MARK: - SFCardTableViewHeaderFooterView
open class SFCardTableViewHeaderFooterView: SFTableViewHeaderFooterView {
    // MARK: var
    public override var backgroundColorNor: UIColor? {
        didSet {
            backgroundNorView.backgroundColor = .clear
            cardBackgroundNorLayer.fillColor = backgroundColorNor?.cgColor
        }
    }
    /// 卡片视图
    public private(set) lazy var cardView: SFView = {
        return SFView().then { view in
            view.backgroundColor = .clear
        }
    }()
    /// 卡片背景layer nor
    public private(set) lazy var cardBackgroundNorLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    /// 卡片缩进
    public var cardInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    /// 卡片圆角
    public var cardRadius: CGFloat = 10
    /// 卡片圆角位置
    public var cardCorner: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    
    
    // MARK: life cycle
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        contentView.addSubview(cardView)
        backgroundNorView.layer.insertSublayer(cardBackgroundNorLayer, at: 0)
    }
    
    public override func draw(_ rect: CGRect) {
        let bounds = CGRect(origin: .zero, size: rect.size)
        let cardRect = bounds.inset(by: cardInset)
        cardView.frame = cardRect
    }
}

