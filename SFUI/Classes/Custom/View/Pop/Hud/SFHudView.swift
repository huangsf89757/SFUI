//
//  SFHudView.swift
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


// MARK: - SFHudView
final class SFHudView: SFPopView {
    // MARK: var
    /// 样式
    var style: SFHud.Style = .loading
    /// msg
    var msg: String? {
        didSet {
            msgLabel.text = msg
        }
    }
    /// 偏移量 (y)
    var offset: CGFloat = 0
    /// show后多长时间显示closeBtn
    var closeTime: TimeInterval = 5
    /// 点击close的回调
    var closeBlock: ((SFPopView)->())?
    
    
    // MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.sf.setCornerAndShadow(radius: 20, fillColor: SFColor.UI.background, shadowColor: SFColor.UI.black, shadowOpacity: 0.3, shadowOffset: .zero, shadowRadius: 5)
        maskConfigeration.color = .clear
        maskConfigeration.clickEnable = true
        autoDismissWhenClickMask = false
        customUI()
        statusChangedBlock = {
            [weak self] status in
            guard let self = self else { return }
            switch status {
            case .willShow:
                self.closeBtn.alpha = 0
            case .didShow:
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + self.closeTime) {
                    UIView.animate(withDuration: 1, animations: {
                        self.closeBtn.alpha = 1
                    })
                }
            default:
                break
            }
        }
    }
    
    override func customLayout() {
        imgView.image = style.image
        self.snp.remakeConstraints { make in
            make.centerY.equalToSuperview().offset(offset)
            make.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(100)
            make.width.lessThanOrEqualTo(SFApp.screenWidthPortrait() - 60)
            make.height.greaterThanOrEqualTo(100)
            make.height.lessThanOrEqualTo(SFApp.screenHeightPortrait() - 60)
            make.width.greaterThanOrEqualTo(self.snp.height)
        }
        imgView.layer.removeAllAnimations()
        if style == .loading {
            let anim = getLoadingAnimation()
            imgView.layer.add(anim, forKey: "rotation")
        }
    }
    override func draw(_ rect: CGRect) {
        self.sf.applyCornerAndShadow()
    }
    
    
    // MARK: ui
    private lazy var imgView: SFImageView = {
        return SFImageView().then { view in
            view.contentMode = .scaleAspectFit
        }
    }()
    private lazy var msgLabel: SFLabel = {
        return SFLabel().then { view in
            view.font = .systemFont(ofSize: 17, weight: .regular)
            view.textColor = SFColor.UI.title
            view.textAlignment = .center
            view.numberOfLines = 0
        }
    }()
    private lazy var closeBtn: SFButton = {
        return SFButton().then { view in
            let image = SFImage.UI.close?.sf.resize(to: CGSize(width: 15, height: 15))
            view.setImage(image, for: .normal)
            view.backgroundColor = SFColor.UI.background
            view.layer.cornerRadius = 12
            view.layer.shadowColor = SFColor.UI.black?.cgColor
            view.layer.shadowOpacity = 0.2
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 10
            view.hitInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
            view.addTarget(self, action: #selector(closeBtnClicked), for: .touchUpInside)
        }
    }()
    private func customUI() {
        addSubview(imgView)
        addSubview(msgLabel)
        addSubview(closeBtn)
        imgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.centerX.equalToSuperview()
        }
        msgLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
        }
        closeBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(8)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
    }
    
    // MARK: func
    /// 获取加载中动画
    private func getLoadingAnimation() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.fromValue = 0
        anim.toValue = Double.pi * 2
        anim.repeatCount = HUGE
        anim.duration = 2
        anim.isRemovedOnCompletion = false
        anim.fillMode = .forwards
        return anim
    }
    
}

extension SFHudView {
    /// 点击取消按钮
    @objc private func closeBtnClicked() {
        print("closeBtnClicked")
        closeBlock?(self)
    }
}
