//
//  SFAlertView.swift
//  SFUI
//
//  Created by hsf on 2024/11/28.
//

import Foundation
import UIKit
// Basic
import SFBase
// Third
import Then
import SnapKit

// MARK: - SFAlertView
final class SFAlertView: SFPopView {
    // MARK: block
    /// cancel点击回调
    var cancelActionBlock: ((SFPopView) -> Bool)?
    /// sure点击回调
    var sureActionBlock: ((SFPopView) -> Bool)?
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
    }
    override func customLayout() {
        self.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(SFApp.screenWidthPortrait() - 60)
        }
        customUI()
    }
    override func frameDetermined() {
        self.sf.setCornerAndShadow(radius: 20, fillColor: SFColor.UI.background, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        self.sf.applyCornerAndShadow()
    }
    
    // MARK: ui
    lazy var contentView: SFView = {
        return SFView().then { view in
            view.layer.cornerRadius = 10
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 20, weight: .bold)
            view.textColor = SFColor.UI.title
            view.numberOfLines = 0
            view.textAlignment = .center
        }
    }()
    lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor =  SFColor.UI.title
            view.numberOfLines = 0
            view.textAlignment = .center
        }
    }()
    lazy var dividerView1: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    lazy var dividerView2: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    lazy var cancelBtn: SFButton = {
        return SFButton().then { view in
            view.setTitleColor(SFColor.UI.darkGray, for: .normal)
            view.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        }
    }()
    lazy var sureBtn: SFButton = {
        return SFButton().then { view in
            view.setTitleColor(SFColor.UI.theme, for: .normal)
            view.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(msgLabel)
        contentView.addSubview(dividerView1)
        contentView.addSubview(dividerView2)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(sureBtn)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        msgLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
        }
        dividerView1.snp.makeConstraints { make in
            make.top.equalTo(msgLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        dividerView2.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.bottom.equalToSuperview()
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(dividerView2.snp.leading)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
        sureBtn.snp.makeConstraints { make in
            make.top.equalTo(dividerView1.snp.bottom)
            make.leading.equalTo(dividerView2.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Action
extension SFAlertView {
    @objc private func cancelBtnAction() {
        if let cancelActionBlock = cancelActionBlock {
            let shouldDismiss = cancelActionBlock(self)
            if shouldDismiss {
                dismiss()
            }
        } else {
            dismiss()
        }
    }
    
    @objc private func sureBtnAction() {
        if let sureActionBlock = sureActionBlock {
            let shouldDismiss = sureActionBlock(self)
            if shouldDismiss {
                dismiss()
            }
        } else {
            dismiss()
        }
    }
}

