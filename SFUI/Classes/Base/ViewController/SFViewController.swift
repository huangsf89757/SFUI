//
//  SFViewController.swift
//  SFUI
//
//  Created by hsf on 2024/7/18.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Third
import Then
import SnapKit
import SnapKitExtend

/*
 【计划内容】
 - back
    - back(through: Int)
    - backTo(level: Int)
    - backTo(tag: String)
    - backTo(cls: String)
    - backToRoot()
 */

// MARK: - SFViewController
open class SFViewController: UIViewController {
    // MARK: var
    /// 是否隐藏导航栏
    public var isHiddenNavBar: Bool = false {
        didSet {
            if isHiddenNavBar {
                edgesForExtendedLayout = .all
            } else {
                edgesForExtendedLayout = []
            }
        }
    }
    /// 是否监听app的生命周期通知
    public var isObserveAppLifeEnable: Bool = false {
        didSet {
            if isObserveAppLifeEnable {
                addAppLifeCycleObserver()
            } else {
                removeAppLifeCycleObserver()
            }
        }
    }
    /// 是否监听keyboard的生命周期通知
    public var isObserveKeyboardLifeEnable: Bool = false {
        didSet {
            if isObserveKeyboardLifeEnable {
                addKeyboardLifeCycleObserver()
            } else {
                removeKeyboardLifeCycleObserver()
            }
        }
    }
    /// 返回按钮
    public private(set) lazy var backBtn: SFButton = {
        return SFButton().then { view in
            view.frame = CGRectMake(0, 0, 40, 44)
            view.setImage(SFImage.UI.Com.back, for: .normal)
        }
    }()
    
    // MARK: life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SFColor.UI.background
        edgesForExtendedLayout = []
        if hidesBottomBarWhenPushed {
            backBtn.addTarget(self, action: #selector(backBtnClicked), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        }
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isHiddenNavBar {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: back
    public enum SFBackType {
        case one
        case root
        case count(Int)
        
    }
    /// 是否可以返回
    open func willBack() -> (will: Bool, animated: Bool) {
        return (will: true, animated: true)
    }
    /// 执行返回
    open func goBack(animated: Bool) {
        if let presentingViewController = presentingViewController {
            dismiss(animated: animated) {
                self.finishBack()
            }
        }
        else if let navigationController = navigationController as? SFNavigationController {
            navigationController.popViewController(animated: animated) {
                self.finishBack()
            }
        }
        else {
            // log
        }
    }
    /// 完成返回
    open func finishBack() {
        
    }    
}

// MARK: - action
extension SFViewController {
    @objc
    private func backBtnClicked() {
        let (will, animated) = willBack()
        guard will else { return }
        goBack(animated: animated)
    }
}

// MARK: - app life
extension SFViewController {
    private func addAppLifeCycleObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate(_:)), name: UIApplication.willTerminateNotification, object: nil)
    }
    private func removeAppLifeCycleObserver() {
        [UIApplication.didEnterBackgroundNotification,
         UIApplication.willEnterForegroundNotification,
         UIApplication.didBecomeActiveNotification,
         UIApplication.willResignActiveNotification,
         UIApplication.willTerminateNotification].forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: nil)
        }
    }
    
    @objc
    open func appDidEnterBackground(_ notify: Notification) { }
    
    @objc
    open func appWillEnterForeground(_ notify: Notification) { }
    
    @objc
    open func appDidBecomeActive(_ notify: Notification) { }
    
    @objc
    open func appWillResignActive(_ notify: Notification) { }
    
    @objc
    open func appWillTerminate(_ notify: Notification) { }
}


// MARK: - keyboard
extension SFViewController {
    private func addKeyboardLifeCycleObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIApplication.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIApplication.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIApplication.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChangeFrame(_:)), name: UIApplication.keyboardDidChangeFrameNotification, object: nil)
    }
    
    private func removeKeyboardLifeCycleObserver() {
        [UIApplication.keyboardWillShowNotification,
         UIApplication.keyboardDidShowNotification,
         UIApplication.keyboardWillHideNotification,
         UIApplication.keyboardDidHideNotification,
         UIApplication.keyboardWillChangeFrameNotification,
         UIApplication.keyboardDidChangeFrameNotification].forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: nil)
        }
    }
    
    @objc
    open func keyboardWillShow(_ notify: Notification) { }
    
    @objc
    open func keyboardDidShow(_ notify: Notification) { }
    
    @objc
    open func keyboardWillHide(_ notify: Notification) { }
    
    @objc
    open func keyboardDidHide(_ notify: Notification) { }
    
    @objc
    open func keyboardWillChangeFrame(_ notify: Notification) { }
    
    @objc
    open func keyboardDidChangeFrame(_ notify: Notification) { }
}
