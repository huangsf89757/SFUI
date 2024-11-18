//
//  SFGuide.swift
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


// MARK: - SFGuide
public final class SFGuide {
    // MARK: var
    /// 引导镂空
    public var hollowPaths = [UIBezierPath]()
    /// 引导视图
    public var guideViews = [SFGuideView]()
    /// 索引
    public private(set) var index = 0
    /// 当前正在引导的视图
    public private(set) var curGuideView: SFGuideView?
    /// 唯一标识
    public var identifier: String = UUID().uuidString
    /// 完成引导回调
    public var completionBlock: (() -> ())?
    
    // MARK: func
    /// 开始引导
    public func start() {
        guard guideViews.count > 0 else { return }
        guard guideViews.count == hollowPaths.count else { return }
        index = 0
        next()
    }
    
    /// 下一步
    private func next() {
        index += 1
        if index >= guideViews.count {
            if index == guideViews.count {
                completionBlock?()
            }
            return
        }
        // dismiss old
        if let curGuideView = curGuideView {
            curGuideView.dismiss()
        }
        // show new
        let guideView = guideViews[index]
        let hollowPath = hollowPaths[index]
        guideView.identifier = identifier        
        guideView.maskConfigeration.hollowPath = hollowPath
        guideView.maskConfigeration.clickMaskBlock = {
            [weak self] in
            self?.next()
        }
        guideView.show()
        curGuideView = guideView
    }
}
