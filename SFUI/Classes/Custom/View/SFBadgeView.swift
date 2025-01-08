//
//  SFBadgeView.swift
//  SFUI
//
//  Created by hsf on 2024/7/21.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Third
import Then
import SnapKit


// MARK: - SFBadgeView
open class SFBadgeView: SFView {
    
    public enum Style {
        case dot(CGSize)
        case num(max: Int, cur: Int)
        case text(String)
    }
    
    public enum Position {
        case topLeading(offset: CGPoint)
        case topCenterX(offset: CGPoint)
        case topTrailing(offset: CGPoint)
        case centerYLeading(offset: CGPoint)
        case centerYCenterX(offset: CGPoint)
        case centerYTrailing(offset: CGPoint)
        case bottomLeading(offset: CGPoint)
        case bottomCenterX(offset: CGPoint)
        case bottomTrailing(offset: CGPoint)
    }
    
    var style: Style = .dot(CGSize(width: 8, height: 8))
    var position: Position = .topTrailing(offset: .zero)
    
    public private(set) lazy var dotView: SFView = {
        return SFView().then { view in
            view.backgroundColor = .red
            view.layer.cornerRadius = 4
            view.layer.masksToBounds = true
        }
    }()
    public private(set) lazy var textLabel: SFLabel = {
        return SFLabel().then { view in
            view.backgroundColor = .red
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            view.textAlignment = .center
            view.font = .systemFont(ofSize: 8, weight: .regular)
            view.textColor = .white
            view.edgeInsert = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        }
    }()
    
    
    // MARK: life cycle
    public init(style: Style, position: Position) {
        self.style = style
        self.position = position
        super.init(frame: .zero)
        
        addSubview(dotView)
        addSubview(textLabel)
        
        dotView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
        }
        textLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.width.greaterThanOrEqualTo(textLabel.snp.height)
        }
    }
    
    
    // MARK: func
    /// 显示
    public func show(inView: UIView) {
        self.isHidden = false
        dotView.isHidden = true
        textLabel.isHidden = true
        self.removeFromSuperview()
        inView.addSubview(self)
        self.snp.remakeConstraints { make in
            positionConstraint(make: make)
        }
        
        switch style {
        case .dot(let cGSize):
            dotView.isHidden = false
            dotView.snp.remakeConstraints { make in
                make.top.greaterThanOrEqualToSuperview()
                make.leading.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.trailing.lessThanOrEqualToSuperview()
                make.size.equalTo(cGSize)
            }
            dotView.layer.cornerRadius = cGSize.height / 2
        case .num(let max, let cur):
            textLabel.isHidden = false
            if cur <= max {
                textLabel.text = String(format: "%ld", cur)
            } else {
                textLabel.text = String(format: "%ld+", max)
            }
        case .text(let string):
            textLabel.isHidden = false
            textLabel.text = string
        }
        // 位置
        func positionConstraint(make: ConstraintMaker) {
            switch position {
            case .topLeading(let offset):
                make.centerY.equalTo(inView.snp.top).offset(offset.y)
                make.centerX.equalTo(inView.snp.leading).offset(offset.x)
            case .topCenterX(let offset):
                make.centerY.equalTo(inView.snp.top).offset(offset.y)
                make.centerX.equalTo(inView.snp.centerX).offset(offset.x)
            case .topTrailing(let offset):
                make.centerY.equalTo(inView.snp.top).offset(offset.y)
                make.centerX.equalTo(inView.snp.trailing).offset(offset.x)
            case .centerYLeading(let offset):
                make.centerY.equalTo(inView.snp.centerY).offset(offset.y)
                make.centerX.equalTo(inView.snp.leading).offset(offset.x)
            case .centerYCenterX(let offset):
                make.centerY.equalTo(inView.snp.centerY).offset(offset.y)
                make.centerX.equalTo(inView.snp.centerX).offset(offset.x)
            case .centerYTrailing(let offset):
                make.centerY.equalTo(inView.snp.centerY).offset(offset.y)
                make.centerX.equalTo(inView.snp.trailing).offset(offset.x)
            case .bottomLeading(let offset):
                make.centerY.equalTo(inView.snp.bottom).offset(offset.y)
                make.centerX.equalTo(inView.snp.leading).offset(offset.x)
            case .bottomCenterX(let offset):
                make.centerY.equalTo(inView.snp.bottom).offset(offset.y)
                make.centerX.equalTo(inView.snp.centerX).offset(offset.x)
            case .bottomTrailing(let offset):
                make.centerY.equalTo(inView.snp.bottom).offset(offset.y)
                make.centerX.equalTo(inView.snp.trailing).offset(offset.x)
            }
        }
    }
    
    /// 隐藏
    public func hide() {
        self.isHidden = true
    }
    
   
}



// MARK: - SFView
extension SFView {
    /// 显示badge
    public func showBadge(style: SFBadgeView.Style = .num(max: 99, cur: 1),
                          position: SFBadgeView.Position = .topTrailing(offset: .zero),
                          identifier: String? = nil) {
        var badgeView: SFBadgeView?
        if let identifier = identifier {
            badgeView = getBadgeView(identifier: identifier)
        }
        if badgeView == nil {
            badgeView = SFBadgeView(style: style, position: position)
        }
        badgeView!.sf.identifier = identifier
        badgeView!.show(inView: self)
    }
    
    /// 获取到指定的badgeView
    private func getBadgeView(identifier: String) -> SFBadgeView? {
        for view in subviews {
            if let badgeView = view as? SFBadgeView, badgeView.sf.identifier == identifier {
                return badgeView
            }
        }
        return nil
    }
}


