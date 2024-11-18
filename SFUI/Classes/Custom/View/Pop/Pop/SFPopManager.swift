//
//  SFPopManager.swift
//  SFUI
//
//  Created by hsf on 2024/7/25.
//

import Foundation
import UIKit


// MARK: - SFPopManager
public class SFPopManager {
    // MARK: singleton
    public static let shared = SFPopManager()
    private init() {}
    
    // MARK: var
    public private(set) var map = [String: SFPopWindow]()
    public private(set) var identifiers = [String]()
    
    // MARK: show / dismiss
    /// show
    internal func show(identifier: String, window: SFPopWindow) {
        window.windowLevel = UIWindow.Level.alert + UIWindow.Level.RawValue(identifiers.count)
        window.makeKeyAndVisible()
        SFPopManager.shared.map[identifier] = window
        identifiers.removeAll { element in
            element == identifier
        }
        identifiers.append(identifier)
    }
    
    /// dismiss
    internal func dismiss(identifier: String) {
        guard let window = SFPopManager.shared.map[identifier] else { return }
        window.isHidden = true
        window.resignKey()
        SFPopManager.shared.map[identifier] = nil
        identifiers.removeAll { element in
            element == identifier
        }
    }
    
    /// dismissAll
    public func dismissAll() {
        for identifier in identifiers {
            dismiss(identifier: identifier)
        }
    }
}

extension SFPopManager {
    /// 将某个popView移动到最前面
    public func bringToFront(identifier: String) {
        move(identifier: identifier, to: identifiers.count)
    }
    
    /// 将某个popView移动到最下面
    public func sendToBack(identifier: String) {
        move(identifier: identifier, to: 0)
    }
    
    /// 将某个popView移动到某个popView的下方
    public func move(identifier: String, below sibling: String) {
        guard let index = identifiers.firstIndex(of: sibling) else { return }
        move(identifier: identifier, to: index)
    }
    
    /// 将某个popView移动到某个popView的上方
    public func move(identifier: String, above sibling: String) {
        guard let index = identifiers.firstIndex(of: sibling) else { return }
        move(identifier: identifier, to: index + 1)
    }
    
    /// 将某个popView移动到index
    public func move(identifier: String, to index: Int) {
        var identifiers = SFPopManager.shared.identifiers
        let (success, res) = identifiers.sf.move(element: identifier, to: index)
        guard success else { return }
        SFPopManager.shared.identifiers = res
        updateWindowLevel()
    }
    
    /// 交换两个popView的位置
    public func exchange(identifier1: String, identifier2: String) {
        var identifiers = SFPopManager.shared.identifiers
        identifiers.sf.swap(identifier1, identifier2)
        SFPopManager.shared.identifiers = identifiers
        updateWindowLevel()
    }
        
    /// 更新windowLevel
    private func updateWindowLevel() {
        for (index , identifier) in identifiers.enumerated() {
            guard let window = SFPopManager.shared.map[identifier] else { continue }
            window.windowLevel = UIWindow.Level.alert + UIWindow.Level.RawValue(index)
        }
    }
}

