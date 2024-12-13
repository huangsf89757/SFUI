//
//  SFToastView.swift
//  SFUI
//
//  Created by hsf on 2024/7/21.
//

import Foundation
import UIKit
// Basic
import SFBase
// Third
import Then
import SnapKit


// MARK: - SFToastView
final class SFToastView: SFPopView {
    // MARK: var
    /// 位置
    var position: SFToast.Position = .center(offset: 0)
    /// msg
    var msg: String? {
        didSet {
            msgLabel.text = msg
        }
    }
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        maskConfigeration.color = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
        customUI()
    }
    override func customLayout() {
        self.snp.remakeConstraints { make in
            switch position {
            case .top(offset: let offset):
                make.top.equalToSuperview().offset(offset)
            case .center(offset: let offset):
                make.centerY.equalToSuperview().offset(offset)
            case .bottom(offset: let offset):
                make.bottom.equalToSuperview().offset(-offset)
            }
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(60)
            make.width.lessThanOrEqualTo(SFApp.screenWidthPortrait() - 60)
            make.height.greaterThanOrEqualTo(40)
            make.height.lessThanOrEqualTo(SFApp.screenHeightPortrait() - 60)
        }
    }
    override func frameDetermined() {
        self.sf.setCornerAndShadow(radius: 20, fillColor: SFColor.UI.background, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        self.sf.applyCornerAndShadow()
    }
    
    
    // MARK: ui
    private lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
            view.numberOfLines = 0
        }
    }()
    private func customUI() {
        addSubview(msgLabel)
        msgLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
