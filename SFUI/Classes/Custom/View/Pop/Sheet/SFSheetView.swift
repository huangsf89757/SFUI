//
//  SFSheetView.swift
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

// MARK: - SFSheetView
final class SFSheetView: SFPopView {
    // MARK: block
    /// cancel点击回调
    var cancelActionBlock: ((SFPopView) -> Bool)?
    /// sure点击回调
    var sureActionBlock: ((SFPopView) -> Bool)?
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.sf.setCornerAndShadow(radius: 10, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], fillColor: SFColor.UI.content, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        maskConfigeration.color = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
    }
    
    override func customLayout() {
        self.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        customUI()
    }
    
    override func draw(_ rect: CGRect) {
        self.sf.applyCornerAndShadow()
    }
    
    // MARK: ui
    lazy var contentView: SFView = {
        return SFView().then { view in
            view.layer.cornerRadius = 10
        }
    }()
    lazy var indicatorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.theme
        }
    }()
    lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 20, weight: .bold)
            view.textColor = SFColor.UI.title
            view.numberOfLines = 0
        }
    }()
    lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor =  SFColor.UI.title
            view.numberOfLines = 0
        }
    }()
    lazy var dividerView: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    lazy var cancelBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = SFColor.UI.content
            view.setTitleColor(SFColor.UI.gray, for: .normal)
            view.layer.cornerRadius = 6
            view.layer.borderWidth = 1
            view.layer.borderColor = SFColor.UI.gray?.cgColor
            view.addTarget(self, action: #selector(cancelBtnAction), for: .touchUpInside)
        }
    }()
    lazy var sureBtn: SFButton = {
        return SFButton().then { view in
            view.backgroundColor = SFColor.UI.theme
            view.setTitleColor(SFColor.UI.whiteAlways, for: .normal)
            view.layer.cornerRadius = 6
            view.layer.borderWidth = 1
            view.layer.borderColor = SFColor.UI.theme?.cgColor
            view.addTarget(self, action: #selector(sureBtnAction), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(contentView)
        contentView.addSubview(indicatorView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(msgLabel)
        contentView.addSubview(dividerView)
        contentView.addSubview(cancelBtn)
        contentView.addSubview(sureBtn)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(4)
            make.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(indicatorView)
            make.leading.equalTo(indicatorView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-10)
        }
        msgLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(msgLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        cancelBtn.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-(SFApp.safeAreaInsets().bottom + 20))
        }
        sureBtn.snp.makeConstraints { make in
            make.centerY.equalTo(cancelBtn)
            make.leading.equalTo(cancelBtn.snp.trailing).offset(20)
            make.height.equalTo(cancelBtn)
            make.width.equalTo(cancelBtn)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

// MARK: - Action
extension SFSheetView {
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
