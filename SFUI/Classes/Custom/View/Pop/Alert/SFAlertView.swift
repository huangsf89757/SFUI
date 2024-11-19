//
//  SFAlertView.swift
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


// MARK: - SFAlertView
final class SFAlertView: SFPopView {
    // MARK: block
    /// cancel样式回调
    var cancelAppearanceBlock: ((SFButton) -> ())?
    /// cancel点击回调
    var cancelActionBlock: ((SFPopView) -> Bool)?
    
    /// sure样式回调
    var sureAppearanceBlock: ((SFButton) -> ())?
    /// sure点击回调
    var sureActionBlock: ((SFPopView) -> Bool)?
    
    // MARK: var
    /// alertStyle
    var alertStyle: SFAlert.AlertStyle = .alert
    /// headerStyle
    var headerStyle: SFAlert.HeaderStyle = .center
    /// actionStyle
    var actionStyle: SFAlert.ActionStyle = .block
    /// footerStyle
    var footerStyle: SFAlert.FooterStyle = .spacing
    /// 偏移量 (y)
    var offset: CGFloat = 0
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
    /// cancel
    var cancel: String? {
        didSet {
            cancelBtn.setTitle(cancel, for: .normal)
        }
    }
    /// sure
    var sure: String? {
        didSet {
            sureBtn.setTitle(sure, for: .normal)
        }
    }
    
        
    /// customActions
    var customActions = [[String: Any]]()
    
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.sf.setCornerAndShadow(radius: 20, fillColor: R.color.background(), shadowColor: R.color.black(), shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        maskConfigeration.color = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
    }
    
    override func customLayout() {
        self.snp.remakeConstraints { make in
            switch alertStyle {
            case .alert:
                make.centerY.equalToSuperview().offset(offset)
                make.centerX.equalToSuperview()
                make.width.equalTo(SFApp.screenWidthPortrait() - 60)
            case .sheet:
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(offset)
            }
        }
        customUIOfAlert()
    }
    
    override func draw(_ rect: CGRect) {
        self.sf.applyCornerAndShadow()
    }
    
    
    // MARK: ui
    private lazy var contentView: SFView = {
        return SFView()
    }()
    private lazy var headerView: SFView = {
        return SFView()
    }()
    private lazy var spaceView1: SFView = {
        return SFView()
    }()
    private lazy var customActionView: SFView = {
        return SFView()
    }()
    private lazy var spaceView2: SFView = {
        return SFView()
    }()
    private lazy var footerView: SFView = {
        return SFView()
    }()
    
    private lazy var indicatorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.theme()
        }
    }()
    private lazy var titleLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 20, weight: .bold)
            view.textColor = R.color.title()
            view.numberOfLines = 0
        }
    }()
    private lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor =  R.color.title()
            view.numberOfLines = 0
        }
    }()
    
    private lazy var cancelBtn: SFButton = {
        return SFButton().then { view in
            view.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        }
    }()
    private lazy var sureBtn: SFButton = {
        return SFButton().then { view in
            view.addTarget(self, action: #selector(sureBtnClicked), for: .touchUpInside)
        }
    }()
    private func customUIOfAlert() {
        headerView.sf.removeAllSubviews()
        customActionView.sf.removeAllSubviews()
        footerView.sf.removeAllSubviews()
        contentView.sf.removeAllSubviews()
        self.sf.removeAllSubviews()
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        switch alertStyle {
        case .alert:
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .sheet:
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        customUIOfHeaderView()
        customUIOfCustomActionView()
        customUIOfFooterView()
        var views = [UIView]()
        if headerView.subviews.count > 0 {
            views.append(headerView)
            headerView.backgroundColor = .clear
            if customActionView.subviews.count > 0
                || footerView.subviews.count > 0 {
                views.append(spaceView1)
                spaceView1.backgroundColor = .clear
            }
        }
        if customActionView.subviews.count > 0{
            views.append(customActionView)
            customActionView.backgroundColor = .clear
            if footerView.subviews.count > 0 {
                views.append(spaceView2)
                spaceView2.backgroundColor = .clear
            }
        }
        if footerView.subviews.count > 0{
            views.append(footerView)
            if footerStyle == .edging, customActions.count == 0 {
                footerView.backgroundColor =  R.color.divider()
            } else {
                footerView.backgroundColor = .clear
            }
        }
        var lastView: UIView? = nil
        for (index, view) in views.enumerated() {
            contentView.addSubview(view)
            view.snp.remakeConstraints { make in
                if let lastView = lastView {
                    make.top.equalTo(lastView.snp.bottom).offset(0)
                } else {
                    make.top.equalToSuperview().offset(20)
                }
                if index == views.count - 1 {
                    if view == footerView {
                        switch footerStyle {
                        case .spacing:
                            make.bottom.equalToSuperview().offset(-20)
                        case .edging:
                            make.bottom.equalToSuperview().offset(0)
                        }
                    } else {
                        make.bottom.equalToSuperview().offset(-20)
                    }
                }
                if view === spaceView1 {
                    make.height.equalTo(30)
                }
                if view === spaceView2 {
                    make.height.equalTo(20)
                }
                if view == footerView {
                    switch footerStyle {
                    case .spacing:
                        make.leading.equalToSuperview().offset(20)
                        make.trailing.equalToSuperview().offset(-20)
                    case .edging:
                        make.leading.equalToSuperview().offset(0)
                        make.trailing.equalToSuperview().offset(0)
                    }
                } else {
                    make.leading.equalToSuperview().offset(20)
                    make.trailing.equalToSuperview().offset(-20)
                }
            }
            lastView = view
        }
    }
    private func customUIOfHeaderView() {
        switch headerStyle {
        case .center:
            titleLabel.textAlignment = .center
            msgLabel.textAlignment = .center
        case .leading:
            titleLabel.textAlignment = .left
            msgLabel.textAlignment = .left
        }
        if let title = title {
            if let msg = msg {
                headerView.addSubview(indicatorView)
                headerView.addSubview(titleLabel)
                headerView.addSubview(msgLabel)
                indicatorView.snp.makeConstraints { make in
                    make.centerY.equalTo(titleLabel)
                    make.leading.equalToSuperview()
                    make.size.equalTo(CGSize(width: 4, height: 20))
                }
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.leading.equalTo(indicatorView.snp.trailing).offset(6)
                    make.trailing.equalToSuperview()
                }
                msgLabel.snp.remakeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(12)
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            } else {
                headerView.addSubview(indicatorView)
                headerView.addSubview(titleLabel)
                indicatorView.snp.makeConstraints { make in
                    make.centerY.equalTo(titleLabel)
                    make.leading.equalToSuperview()
                    make.size.equalTo(CGSize(width: 4, height: 20))
                }
                titleLabel.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.leading.equalTo(indicatorView.snp.trailing).offset(6)
                    make.trailing.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            }
        } else {
            if let msg = msg {
                headerView.addSubview(msgLabel)
                msgLabel.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            } else {
                // nothing
            }
        }
    }
    private func customUIOfCustomActionView() {
        var lastView: UIView? = nil
        for (index, customAction) in customActions.enumerated() {
            let style = customAction["style"] as? SFAlert.ActionStyle
            let title = customAction["title"] as? String
            let appearance = customAction["appearance"] as? ((SFButton) -> ())
            
            let btn = SFButton()
            btn.setTitle(title, for: .normal)
            if let style = style {
                let color = R.color.white()?.withAlphaComponent(0.8)
                switch style {
                case .block:
                    btn.backgroundColor = color
                    btn.setTitleColor(R.color.black(), for: .normal)
                    btn.layer.borderColor = color?.cgColor
                    btn.layer.borderWidth = 0
                case .border:
                    btn.backgroundColor = .clear
                    btn.setTitleColor(R.color.black(), for: .normal)
                    btn.layer.borderColor = color?.cgColor
                    btn.layer.borderWidth = 1
                }
            }
            btn.layer.cornerRadius = 8
            appearance?(btn)
            
            btn.tag = index
            btn.addTarget(self, action: #selector(customBtnClicked(_:)), for: .touchUpInside)
            
            customActionView.addSubview(btn)
            btn.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalTo(44)
                if let lastView = lastView {
                    make.top.equalTo(lastView.snp.bottom).offset(10)
                } else {
                    make.top.equalToSuperview()
                }
                if index == customActions.count - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            lastView = btn
        }
    }
    private func customUIOfFooterView() {
        let withCornerRadius = footerStyle == .spacing
        if withCornerRadius {
            cancelBtn.layer.cornerRadius = 8
            sureBtn.layer.cornerRadius = 8
        } else {
            cancelBtn.layer.cornerRadius = 0
            sureBtn.layer.cornerRadius = 0
        }
        let cancelColor = R.color.black()?.withAlphaComponent(0.3)
        let sureColor = R.color.theme()
        if actionStyle == .block {
            cancelBtn.backgroundColor = cancelColor
            cancelBtn.setTitleColor(UIColor.white, for: .normal)
            cancelBtn.layer.borderColor = UIColor.clear.cgColor
            cancelBtn.layer.borderWidth = 0
            sureBtn.backgroundColor = sureColor
            sureBtn.setTitleColor(UIColor.white, for: .normal)
            sureBtn.layer.borderColor = UIColor.clear.cgColor
            sureBtn.layer.borderWidth = 0
        } else if footerStyle == .spacing {
            cancelBtn.backgroundColor = R.color.content()
            cancelBtn.setTitleColor(cancelColor, for: .normal)
            cancelBtn.layer.borderColor = cancelColor?.cgColor
            cancelBtn.layer.borderWidth = 1
            sureBtn.backgroundColor = R.color.content()
            sureBtn.setTitleColor(sureColor, for: .normal)
            sureBtn.layer.borderColor = sureColor?.cgColor
            sureBtn.layer.borderWidth = 1
        } else {
            cancelBtn.backgroundColor = R.color.content()
            cancelBtn.setTitleColor(cancelColor, for: .normal)
            cancelBtn.layer.borderColor = UIColor.clear.cgColor
            cancelBtn.layer.borderWidth = 0
            sureBtn.backgroundColor = R.color.content()
            sureBtn.setTitleColor(sureColor, for: .normal)
            sureBtn.layer.borderColor = UIColor.clear.cgColor
            sureBtn.layer.borderWidth = 0
        }
        cancelAppearanceBlock?(cancelBtn)
        sureAppearanceBlock?(sureBtn)
    
        if let cancel = cancel {
            if let sure = sure {
                footerView.addSubview(cancelBtn)
                footerView.addSubview(sureBtn)
                if customActions.count > 0 {
                    cancelBtn.snp.remakeConstraints { make in
                        make.top.equalToSuperview()
                        make.leading.equalToSuperview()
                        make.trailing.equalToSuperview()
                        make.height.equalTo(50)
                    }
                    sureBtn.snp.remakeConstraints { make in
                        make.top.equalTo(cancelBtn.snp.bottom).offset(10)
                        make.leading.equalToSuperview()
                        make.trailing.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.height.equalTo(50)
                    }
                } else {
                    cancelBtn.snp.remakeConstraints { make in
                        make.top.equalToSuperview().offset(1)
                        make.leading.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.width.greaterThanOrEqualTo(60)
                        make.height.equalTo(50)
                    }
                    sureBtn.snp.remakeConstraints { make in
                        make.top.equalToSuperview().offset(1)
                        make.trailing.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.leading.equalTo(cancelBtn.snp.trailing).offset(footerStyle == .edging ? 1 : 10)
                        make.width.equalTo(cancelBtn)
                        make.width.greaterThanOrEqualTo(60)
                        make.height.equalTo(50)
                    }
                }
            } else {
                footerView.addSubview(cancelBtn)
                cancelBtn.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(1)
                    make.leading.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.width.greaterThanOrEqualTo(60)
                    make.height.equalTo(50)
                }
            }
        } else {
            if let sure = sure {
                footerView.addSubview(sureBtn)
                sureBtn.snp.remakeConstraints { make in
                    make.top.equalToSuperview().offset(1)
                    make.leading.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.trailing.equalToSuperview()
                    make.width.greaterThanOrEqualTo(60)
                    make.height.equalTo(50)
                }
            } else {
                // nothing
            }
        }
    }
}

// MARK: - action
extension SFAlertView {
    /// 点击custom
    @objc private func customBtnClicked(_ sender: SFButton) {
        let index = sender.tag
        let customAction = customActions[index]
        let action = customAction["action"] as? ((SFPopView) -> Bool)
        action?(self)
    }
    
    /// 点击取消
    @objc private func cancelBtnClicked() {
        if let cancelActionBlock = cancelActionBlock {
            let shouldDismiss = cancelActionBlock(self)
            if shouldDismiss {
                dismiss()
            }
        } else {
            dismiss()
        }
    }
    
    /// 点击取消
    @objc private func sureBtnClicked() {
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
