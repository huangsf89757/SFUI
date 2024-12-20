//
//  SFCardTableViewCell.swift
//  SFUI
//
//  Created by hsf on 2024/7/22.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Third
import Then


// MARK: - SFCardTableViewCell
open class SFCardTableViewCell: SFTableViewCell {
    
    // MARK: var
    public override var backgroundColorNor: UIColor?  {
        didSet {
            backgroundNorView.backgroundColor = .clear
            cardBackgroundNorLayer.fillColor = backgroundColorNor?.cgColor
        }
    }
    public override var backgroundColorSel: UIColor? {
        didSet {
            backgroundSelView.backgroundColor = .clear
            cardBackgroundSelLayer.fillColor = backgroundColorSel?.cgColor
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
    /// 卡片背景layer sel
    public private(set) lazy var cardBackgroundSelLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    /// 卡片缩进
    public var cardInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) {
        didSet {
            updateCardView()
        }
    }
    /// 卡片圆角
    public var cardRadius: CGFloat = 10
    /// 卡片圆角位置
    public var cardCorner: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    /// 卡片（和其他cell是否为一体）
    public var cardJoin = true
    
    
    // MARK: life cycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        customUI()
    }
    
    public override func draw(_ rect: CGRect) {
        backgroundNorView.backgroundColor = .clear
        cardBackgroundNorLayer.fillColor = backgroundColorNor?.cgColor
        backgroundSelView.backgroundColor = .clear
        cardBackgroundSelLayer.fillColor = backgroundColorSel?.cgColor
    }
    
    
    // MARK: customUI
    private func customUI() {
        contentView.addSubview(cardView)
        backgroundNorView.layer.insertSublayer(cardBackgroundNorLayer, at: 0)
        backgroundSelView.layer.insertSublayer(cardBackgroundSelLayer, at: 0)
        updateCardView()
    }
    private func updateCardView() {
        cardView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(cardInset.top)
            make.leading.equalToSuperview().offset(cardInset.left)
            make.trailing.equalToSuperview().offset(-cardInset.right)
            make.bottom.equalToSuperview().offset(-cardInset.bottom)
        }
    }
}


// MARK: - Position
public extension SFCardTableViewCell {
    /// 设置position
    public func configPosition(row: Int, count: Int) {
        var position: Position?
        if count > 1 {
            if row == 0 {
                position = .first
            } else if row == count-1 {
                position = .last
            } else {
                position = .mid
            }
        }
        else if count == 1 {
            position = .only
        }
        else {
            position = nil
        }
        self.position = position
    }
}
