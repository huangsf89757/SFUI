//
//  SFMaskButton.swift
//  SFUI
//
//  Created by hsf on 2024/8/14.
//

import Foundation
import UIKit


// MARK: - SFMaskButton
open class SFMaskButton: SFButton {
    /// 镂空区域的路径
    public var hollowPath: UIBezierPath?
    /// 点击镂空区域回调
    public var clickHollowBlock: (()->())?
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hollowPath = hollowPath,
           hollowPath.contains(point),
           let block = clickHollowBlock {
            block()
            return nil
        }
        return super.hitTest(point, with: event)
    }
}
