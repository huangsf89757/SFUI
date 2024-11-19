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
            iconImgView.image = icon
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
        self.sf.setCornerAndShadow(radius: 20, fillColor: R.color.background(), shadowColor: R.color.black(), shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        maskConfigeration.color = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
        customUI()
    }
    
    override func customLayout() {
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
            view.backgroundColor = R.color.placeholder()
        }
    }()
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .bold)
            view.textColor = R.color.title()
            view.textAlignment = .left
            view.numberOfLines = 1
        }
    }()
    private lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.textColor = R.color.title()
            view.textAlignment = .left
            view.numberOfLines = 2
        }
    }()
    private func customUI() {
        addSubview(iconImgView)
        addSubview(titleLabel)
        addSubview(msgLabel)
        iconImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-20)
        }
        msgLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}

