//
//  SFText.swift
//  SFUI
//
//  Created by hsf on 2024/11/19.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase

// MARK: - SFText
extension SFText {
    public struct App {
        public static var name: String?
        public static var slogen: String?
    }
    
    public struct UI {
        public static var bundle = SFUILib.bundle
        private static func text(name: String) -> String {
            NSLocalizedString(name, bundle: Self.bundle ?? .main, comment: name)
        }
        
        public static var noData: String { text(name: "noData") }
    }
}

