//
//  SFUILib.swift
//  SFUI
//
//  Created by hsf on 2024/11/19.
//

import Foundation
import UIKit
// Basic
import SFExtension
// Third
import IQKeyboardManagerSwift

// MARK: - SFUILib
public class SFUILib: SFLib {
    public static var bundle: Bundle? = Bundle.sf.bundle(cls: SFUILib.self, resource: nil)
}


// TODO: 换个位置
extension UIView {
    public func addToolbarPreviousNextAllowedClassIfNot() {
        var cls = IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses
        let isContains = cls.contains(where: { ele in
            ele is Self
        })
        if !isContains {
            cls.append(Self.self)
        }
    }
}
