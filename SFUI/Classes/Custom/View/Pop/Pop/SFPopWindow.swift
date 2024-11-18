//
//  SFPopWindow.swift
//  SFUI
//
//  Created by hsf on 2024/7/31.
//

import Foundation
import UIKit


// MARK: - SFPopWindow
open class SFPopWindow: SFWindow {
    // MARK: var
    /// 蒙板配置
    public var configeration = SFMaskConfigeration() {
        didSet {
            if configeration.clickEnable {
                maskBtn.isUserInteractionEnabled = true
            } else {
                maskBtn.isUserInteractionEnabled = false
            }
            maskBtn.hollowPath = configeration.hollowPath
            maskBtn.clickHollowBlock = configeration.clickHollowBlock
            if let _ = configeration.hollowPath {
                backgroundColor = .clear
            } else {
                backgroundColor = configeration.color
            }
        }
    }
    
    public private(set) lazy var maskBtn: SFMaskButton = {
        return SFMaskButton().then { view in
            view.backgroundColor = .clear
            view.addTarget(self, action: #selector(maskBtnClicked), for: .touchUpInside)
        }
    }()
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        customUI()
    }
    
    @available(iOS 13.0, *)
    public override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        isUserInteractionEnabled = true
        customUI()
    }
    
    // MARK: ui
    private func customUI() {
        addSubview(maskBtn)
        maskBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: override
    public override func draw(_ rect: CGRect) {
        let maskColor = configeration.color
        if let hollowPath = configeration.hollowPath {
            guard let context = UIGraphicsGetCurrentContext() else { return }
            context.setFillColor(maskColor.cgColor)
            context.fill(rect)
            context.addPath(hollowPath.cgPath)
            context.setBlendMode(.clear)
            context.fillPath()
        } 
    }
}
extension SFPopWindow {
    /// 点击事件
    @objc private func maskBtnClicked() {
        configeration.clickMaskBlock?()
    }
}
