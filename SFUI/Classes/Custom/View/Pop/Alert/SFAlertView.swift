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
public final class SFAlertView: SFPopView {
    // MARK: block
    var actionBlockMap: [Int: ((SFAlertView) -> Bool)] = [:]
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
    }
    public override func customLayout() {
        self.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(SFApp.screenWidthPortrait() - 60)
        }
        customUI()
    }
    public override func frameDetermined() {
        self.sf.setCornerAndShadow(radius: 20, fillColor: SFColor.UI.background, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        self.sf.applyCornerAndShadow()
    }
    
    // MARK: ui
    lazy var contentView: SFView = {
        return SFView().then { view in
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.backgroundColor = SFColor.UI.content
        }
    }()
    lazy var infoStackView: UIStackView = {
        return UIStackView().then { view in
            view.axis = .vertical
            view.spacing = 15
            view.distribution = .fillEqually
        }
    }()
    lazy var actionStackView: UIStackView = {
        return UIStackView().then { view in
            view.distribution = .fillEqually
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
    lazy var tipLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 15, weight: .regular)
            view.textColor =  SFColor.UI.subtitle
            view.numberOfLines = 0
            view.textAlignment = .center
        }
    }()
}

// MARK: - Action
extension SFAlertView {
    @objc private func actionBtnAction(_ sender: SFButton) {
        let tag = sender.tag
        if let otherActionBlock = actionBlockMap[tag] {
            let shouldDismiss = otherActionBlock(self)
            if shouldDismiss {
                dismiss()
            }
        } else {
            dismiss()
        }
    }
}

// MARK: - Init
extension SFAlertView {
    func config(title: String?, msg: String? = nil, tip: String? = nil) {
        reset()
        titleLabel.text = title
        infoStackView.addArrangedSubview(titleLabel)
        if let msg = msg {
            msgLabel.text = msg
            infoStackView.addArrangedSubview(msgLabel)
        }
        if let tip = tip {
            tipLabel.text = tip
            infoStackView.addArrangedSubview(tipLabel)
        }
    }
    
    private func reset() {
        self.sf.removeAllSubviews()
        for view in infoStackView.subviews {
            infoStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        for view in actionStackView.subviews {
            infoStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        actionBlockMap.removeAll()
    }
}

// MARK: - Action
extension SFAlertView {
    func addCancelAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        let btn = createActionBtn(title: title, action: action)
        btn.setTitleColor(SFColor.UI.darkGray, for: .normal)
        appearance?(btn)
        actionStackView.addArrangedSubview(btn)
    }
    
    func addConfirmAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        let btn = createActionBtn(title: title, action: action)
        btn.setTitleColor(SFColor.UI.theme, for: .normal)
        appearance?(btn)
        actionStackView.addArrangedSubview(btn)
    }
    
    func addAction(title: String, appearance: ((SFButton)->())? = nil, action: @escaping (SFAlertView) -> Bool) {
        let btn = createActionBtn(title: title, action: action)
        appearance?(btn)
        actionStackView.addArrangedSubview(btn)
    }
    
    private func createActionBtn(title: String, action: @escaping (SFAlertView) -> Bool) -> SFButton {
        let btn = SFButton().then { view in
            view.backgroundColor = SFColor.UI.content
            view.setTitle(title, for: .normal)
            view.setTitleColor(SFColor.UI.title, for: .normal)
            view.addTarget(self, action: #selector(actionBtnAction(_:)), for: .touchUpInside)
        }
        btn.tag = actionBlockMap.count
        actionBlockMap[btn.tag] = action
        return btn
    }
}

// MARK: - UI
extension SFAlertView {
    private func customUI() {
        addSubview(contentView)
        contentView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.addSubview(infoStackView)
        contentView.addSubview(actionStackView)
        infoStackView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        actionStackView.snp.remakeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        if actionStackView.subviews.count > 2 {
            actionStackView.backgroundColor = .clear
            actionStackView.axis = .vertical
            actionStackView.spacing = 10
            actionStackView.isLayoutMarginsRelativeArrangement = true
            actionStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
            for view in actionStackView.subviews {
                view.layer.cornerRadius = 10
                view.layer.borderColor = SFColor.UI.divider?.cgColor
                view.layer.borderWidth = 1
                view.snp.makeConstraints { make in
                    make.height.equalTo(40)
                }
            }
        } else {
            actionStackView.backgroundColor = SFColor.UI.divider
            actionStackView.axis = .horizontal
            actionStackView.spacing = 1
            actionStackView.isLayoutMarginsRelativeArrangement = true
            actionStackView.layoutMargins = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
            for view in actionStackView.subviews {
                view.snp.makeConstraints { make in
                    make.height.equalTo(50)
                }
            }
        }
    }
}
