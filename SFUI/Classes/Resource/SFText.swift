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
        public struct Hud {
            public static var loading: String { text(name: "hud_loading") }
            public static var success: String { text(name: "hud_success") }
            public static var failure: String { text(name: "hud_failure") }
            public static var info: String { text(name: "hud_info") }
            public static var warning: String { text(name: "hud_warning") }
            public static var error: String { text(name: "hud_error") }
        }
        
    }
}

