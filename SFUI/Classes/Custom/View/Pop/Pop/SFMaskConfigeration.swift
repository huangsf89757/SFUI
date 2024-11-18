//
//  SFMaskConfigeration.swift
//  SFUI
//
//  Created by hsf on 2024/7/31.
//

import Foundation


// MARK: - SFMaskConfigeration
public class SFMaskConfigeration {
    /// 蒙板颜色
    public var color: UIColor = .black.withAlphaComponent(0.3)
    /// 蒙板颜色渐变
    public var animateEnable = true
    /// 蒙板是否可点击
    public var clickEnable = true
    /// 点击蒙板回调
    public var clickMaskBlock: (()->())?
    /// 点击镂空区域回调
    public var clickHollowBlock: (()->())?
    /// 镂空区域的路径
    public var hollowPath: UIBezierPath?
}
