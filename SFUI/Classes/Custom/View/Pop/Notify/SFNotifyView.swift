//
//  SFNotifyView.swift
//  SFUI
//
//  Created by hsf on 2024/7/30.
//

import Foundation
import UIKit
// Basic
import SFBase
// Third
import Then
import SnapKit


// MARK: - SFNotifyView
final class SFNotifyView: SFPopView {
    // MARK: var
    /// icon
    var icon: UIImage? {
        didSet {
            iconImgView.image = icon ?? SFImage.App.icon
        }
    }
    /// title
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
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
        self.sf.setCornerAndShadow(radius: 20, fillColor: SFColor.UI.background, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        maskConfigeration.color = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
    }
    
    override func customLayout() {
        if let msg = msg {
            customUI_iconTitleMsg()
        } else {
            customUI_iconTitle()
        }
        self.snp.remakeConstraints { make in
            make.top.equalTo(superview!.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalTo(SFApp.screenWidthPortrait() - 40)
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.sf.applyCornerAndShadow()
    }
    
    
    // MARK: ui
    private lazy var iconImgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
        }
    }()
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = SFColor.UI.title
            view.textAlignment = .left
            view.numberOfLines = 1
        }
    }()
    private lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.textColor = SFColor.UI.title
            view.textAlignment = .left
            view.numberOfLines = 2
        }
    }()
}

// MARK: - custom ui
extension SFNotifyView {
    private func restUI() {
        sf.removeAllSubviews()
    }
    private func customUI_iconTitle() {
        restUI()
        addSubview(iconImgView)
        addSubview(titleLabel)
        iconImgView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(iconImgView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-20)
            make.top.greaterThanOrEqualToSuperview().offset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    private func customUI_iconTitleMsg() {
        restUI()
        addSubview(iconImgView)
        addSubview(titleLabel)
        addSubview(msgLabel)
        iconImgView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
        msgLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}

