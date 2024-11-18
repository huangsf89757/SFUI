//
//  SFWindow.swift
//  SFUI
//
//  Created by hsf on 2024/7/19.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// Third
import Then
import SnapKit
import SnapKitExtend

open class SFWindow: UIWindow {
    // MARK: 防抖
    public var minEventDuration = 1.0
    public private(set) var lastEventTime: Date?
    open override func sendEvent(_ event: UIEvent) {
        guard let touches = event.allTouches else {
            super.sendEvent(event)
            return
        }

        for touch in touches {
            if touch.phase == .began {
                let currentTime = Date()
                if let lastEventTime = lastEventTime, currentTime.timeIntervalSince(lastEventTime) < minEventDuration {
                    return
                }
                lastEventTime = currentTime
            }
        }
        super.sendEvent(event)
    }
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(iOS 13.0, *)
    public override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
