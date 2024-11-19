//
//  SFWebViewController.swift
//  SFUI
//
//  Created by hsf on 2024/7/19.
//

import Foundation
import UIKit
import WebKit
// Basic
import SFBase

// MARK: - SFWebViewController
open class SFWebViewController: SFViewController {
    // MARK: var
    public private(set) lazy var webView: SFWebView = {
        let config = WKWebViewConfiguration()
        config.selectionGranularity = .character
        let preferences = WKPreferences()
        preferences.minimumFontSize = 0
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences = preferences
        let view = SFWebView(frame: .zero, configuration: config)
        view.backgroundColor = SFColor.UI.content
        view.allowsBackForwardNavigationGestures = true
        view.addObserver(self, forKeyPath: "estimatedProgress", context: nil)
        view.addObserver(self, forKeyPath: "title", context: nil)
        return view
    }()
   
    
}
