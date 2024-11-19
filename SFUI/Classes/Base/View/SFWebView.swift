//
//  SFWebView.swift
//  SFUI
//
//  Created by hsf on 2024/7/18.
//

import Foundation
import UIKit
import WebKit
// Basic
import SFBase
import SFExtension
// Third
import Then
import SnapKit
import SnapKitExtend


// MARK: - SFWebView
open class SFWebView: WKWebView {
    // MARK: var
    public var backBlock: (()->())?
    /// 加载进度
    private lazy var progressView: UIProgressView = {
        return UIProgressView().then { view in
            view.trackTintColor = .clear
            view.tintColor = R.color.theme()
        }
    }()
    private lazy var errorTipView: SFView = {
        return SFView().then { view in
            let label = SFLabel()
            label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            label.textColor = R.color.placeholder()
            label.text = "加载失败" // FIXME: text
            label.textAlignment = .center
            
            let btn = SFButton()
            btn.setTitle(" 返回 ", for: .normal) // FIXME: text
            btn.setTitleColor(R.color.placeholder(), for: .normal) 
            btn.layer.borderColor = R.color.placeholder()?.cgColor
            btn.layer.cornerRadius = 10
            btn.layer.borderWidth = 1
            btn.layer.masksToBounds = true
            btn.addTarget(self, action: #selector(clickTipBackBtn), for: .touchUpInside)
            
            view.addSubview(label)
            view.addSubview(btn)
            label.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
            }
            btn.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(10)
                make.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.leading.greaterThanOrEqualToSuperview()
                make.trailing.lessThanOrEqualToSuperview()
                make.height.greaterThanOrEqualTo(30)
                make.width.greaterThanOrEqualTo(60)
            }
            
            view.isHidden = true
        }
    }()
    
    // MARK: life cycle
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        allowsBackForwardNavigationGestures = true
        navigationDelegate = self
        addObserver(self, forKeyPath: "estimatedProgress", context: nil)
        customLayout()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
        
    }
    
    // MARK: layout
    private func customLayout() {
        addSubview(progressView)
        addSubview(errorTipView)
        
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        errorTipView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}


// MARK: - func
extension SFWebView {
    /// 加载网页
    public func load(url: String) {
        if let URL = URL(string: url) {
            var request = URLRequest(url: URL)
            request.cachePolicy = .useProtocolCachePolicy
            request.timeoutInterval = 15
            load(request)
            reload()
            print("[WEB]", "加载网页：\(url)") // FIXME: log 
        }
    }
    
    /// 清除缓存
    public func clear() {
        let types = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: types, modifiedSince: date) {
            print("[WEB]", "清除缓存")// FIXME: log
        }
    }
}


// MARK: - click
extension SFWebView {
    /// 点击返回按钮
    @objc
    private func clickTipBackBtn() {
        backBlock?()
    }
}


// MARK: - WKNavigationDelegate
extension SFWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        errorTipView.isHidden = true
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        progressView.setProgress(0, animated: false)
        errorTipView.isHidden = false
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.setProgress(0, animated: false)
        errorTipView.isHidden = false
    }
    
    @available(iOS 13.0, *)
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow, preferences)
            return
        }
        guard let scheme = url.scheme else {
            decisionHandler(.allow, preferences)
            return
        }
        // 拨打电话
        if scheme == "tel" || scheme == "mailto" {
            if let components = URLComponents(url: url, resolvingAgainstBaseURL: false)  {
                var jumpURL: URL?
                let resourceSpecifier = components.percentEncodedPath
                if scheme == "tel" {
                    jumpURL = URL(string: "telprompt://\(resourceSpecifier)")
                } else if scheme == "mailto" {
                    jumpURL = URL(string: "mailto://\(resourceSpecifier)")
                }
                if let jumpURL = jumpURL, UIApplication.shared.canOpenURL(jumpURL) {
                    UIApplication.shared.open(jumpURL, options: [:]) { success in
                        // completionHandler code here
                    }
                }
                decisionHandler(.cancel, preferences)
                return
            }
        }
        let urlString = url.absoluteString
        // 淘宝
        if urlString.hasPrefix("https://m.tb.cn") {
            let appUrlString = urlString.replacingOccurrences(of: "https://", with: "taobao://")
            guard let appUrl = URL(string: appUrlString) else { return }
            let can = tryOpenApp(url: appUrl)
            let policy: WKNavigationActionPolicy = can ? .cancel : .allow
            decisionHandler(policy, preferences)
            return
        }
        if urlString.hasPrefix("item.taobao.com") && urlString.sf.contains("id=") {
            let appUrlString = urlString.replacingOccurrences(of: "https://", with: "taobao://")
            guard let appUrl = URL(string: appUrlString) else { return }
            let can = tryOpenApp(url: appUrl)
            let policy: WKNavigationActionPolicy = can ? .cancel : .allow
            decisionHandler(policy, preferences)
            return
        }
        // 京东
        if scheme == "openapp.jdmobile" {
            guard let appUrl = URL(string: urlString) else { return }
            let can = tryOpenApp(url: appUrl)
            let policy: WKNavigationActionPolicy = can ? .cancel : .allow
            decisionHandler(policy, preferences)
            return
        }
        // 微信
        if scheme == "weixin" {
            guard let appUrl = URL(string: urlString) else { return }
            let can = tryOpenApp(url: appUrl)
            let policy: WKNavigationActionPolicy = can ? .cancel : .allow
            decisionHandler(policy, preferences)
            return
        }
        // 关闭
        if (scheme == "http" || scheme == "https") && urlString.hasSuffix("close") {
            decisionHandler(.cancel, preferences)
            backBlock?()
            return
        }
        decisionHandler(.allow, preferences)
    }
    
    func tryOpenApp(url: URL) -> Bool {
        let can = UIApplication.shared.canOpenURL(url)
        guard can else {
            return false
        }
        UIApplication.shared.open(url)
        return true
    }
}


// MARK: - KVO
extension SFWebView {
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress: Float = Float(estimatedProgress)
            progressView.progress = progress
            if progress >= 1.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.progressView.isHidden = true
                }
            } else {
                progressView.isHidden = false
            }
        }
       else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
