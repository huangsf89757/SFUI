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
        
        public static var com_cancel: String { text(name: "com_cancel") }
        public static var com_cancel_doing: String { text(name: "com_cancel_doing") }
        public static var com_cancel_failure: String { text(name: "com_cancel_failure") }
        public static var com_cancel_success: String { text(name: "com_cancel_success") }
        public static var com_delete: String { text(name: "com_delete") }
        public static var com_delete_doing: String { text(name: "com_delete_doing") }
        public static var com_delete_failure: String { text(name: "com_delete_failure") }
        public static var com_delete_success: String { text(name: "com_delete_success") }
        public static var com_commit: String { text(name: "com_commit") }
        public static var com_commit_doing: String { text(name: "com_commit_doing") }
        public static var com_commit_failure: String { text(name: "com_commit_failure") }
        public static var com_commit_success: String { text(name: "com_commit_success") }
        public static var com_edit: String { text(name: "com_edit") }
        public static var com_edit_doing: String { text(name: "com_edit_doing") }
        public static var com_edit_failure: String { text(name: "com_edit_failure") }
        public static var com_edit_success: String { text(name: "com_edit_success") }
        public static var com_failure: String { text(name: "com_failure") }
        public static var com_reset: String { text(name: "com_reset") }
        public static var com_reset_doing: String { text(name: "com_reset_doing") }
        public static var com_reset_failure: String { text(name: "com_reset_failure") }
        public static var com_reset_success: String { text(name: "com_reset_success") }
        public static var com_save: String { text(name: "com_save") }
        public static var com_save_doing: String { text(name: "com_save_doing") }
        public static var com_save_failure: String { text(name: "com_save_failure") }
        public static var com_save_success: String { text(name: "com_save_success") }
        public static var com_success: String { text(name: "com_success") }
        public static var com_sure: String { text(name: "com_sure") }
        public static var com_upload: String { text(name: "com_upload") }
        public static var com_upload_doing: String { text(name: "com_upload_doing") }
        public static var com_upload_failure: String { text(name: "com_upload_failure") }
        public static var com_upload_success: String { text(name: "com_upload_success") }
        public static var hud_error: String { text(name: "hud_error") }
        public static var hud_failure: String { text(name: "hud_failure") }
        public static var hud_info: String { text(name: "hud_info") }
        public static var hud_loading: String { text(name: "hud_loading") }
        public static var hud_success: String { text(name: "hud_success") }
        public static var hud_warning: String { text(name: "hud_warning") }
        
        public static var noData: String { text(name: "noData") }
        
        public static var select_all: String { text(name: "select_all") }
        public static var select_disable: String { text(name: "select_disable") }
        public static var select_enable: String { text(name: "select_enable") }
        
    }
}

