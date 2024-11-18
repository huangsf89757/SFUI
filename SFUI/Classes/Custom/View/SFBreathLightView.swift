//
//  SFBreathLightView.swift
//  SFUI
//
//  Created by hsf on 2024/7/21.
//

import Foundation
import UIKit


// MARK: - SFBreathLightView
open class SFBreathLightView: SFView {
    // MARK: var
    /// 是否正在呼吸
    public private(set) var isBreathing = false

    // MARK: animation
    /// 开始呼吸
    public func startBreath(duration: TimeInterval) {
        guard !isBreathing else { return }
        let anim = CABasicAnimation(keyPath: "opacity")
        anim.fromValue = 0.2
        anim.toValue = 1.0
        anim.autoreverses = true
        anim.duration = duration
        anim.repeatCount = .infinity
        layer.add(anim, forKey: "breathingAnimation")
        isBreathing = true
    }

    /// 停止呼吸
    public func stopBreath() {
        guard isBreathing else { return }
        layer.removeAnimation(forKey: "breathingAnimation")
        isBreathing = false
    }
}
