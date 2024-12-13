//
//  SFGuideView.swift
//  SFUI
//
//  Created by hsf on 2024/7/22.
//

import Foundation
import UIKit
// Basic
import SFBase
// Third
import Then
import SnapKit


// MARK: - SFGuideView
open class SFGuideView: SFPopView {
    // MARK: var
    public private(set) lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
            view.numberOfLines = 0
        }
    }()
   
    
    
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        maskConfigeration.color = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
        customUI()
    }
    public override func customLayout() {
        #warning("在子类中实现")
    }
    public override func frameDetermined() {
        self.sf.setCornerAndShadow(radius: 20, fillColor: SFColor.UI.background, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        self.sf.applyCornerAndShadow()
    }
    
    // MARK: func
    /// 自定义约束
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



