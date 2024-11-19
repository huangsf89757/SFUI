//
//  SFNavigationController.swift
//  SFUI
//
//  Created by hsf on 2024/7/18.
//

import Foundation
import UIKit
// Basic
import SFBase
import SFExtension
// Third
import Then
import SnapKit
import SnapKitExtend

open class SFNavigationController: UINavigationController {
    // MARK: var
    /// 是否支持侧滑返回手势
    public var isPopGestureEnable = true {
        didSet {
            interactivePopGestureRecognizer?.isEnabled = isPopGestureEnable
        }
    }
    
    // MARK: life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = SFColor.UI.content
        edgesForExtendedLayout = []
        interactivePopGestureRecognizer?.delegate = self
        sf.updateBar(barTintColor: SFColor.UI.background, tintColor: SFColor.UI.title, titleColor: SFColor.UI.title, titleFont: .systemFont(ofSize: 20, weight: .bold))
    }

}


// MARK: - push
extension SFNavigationController {
    open func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = children.count > 0
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            interactivePopGestureRecognizer?.isEnabled = false
        }
        super.pushViewController(viewController, animated: animated)
    }
}


// MARK: - pop
extension SFNavigationController {
    open func popViewController(animated: Bool, completion: @escaping () -> ()) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let vc = self.popViewController(animated: animated)
        CATransaction.commit()
        return vc
    }
    open override func popViewController(animated: Bool) -> UIViewController? {
        super.popViewController(animated: animated)
    }
    
    open func popToViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let vc = self.popToViewController(viewController, animated: animated)
        CATransaction.commit()
        return vc
    }
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        super.popToViewController(viewController, animated: animated)
    }
    
    open func popToRootViewController(animated: Bool, completion: @escaping () -> ()) -> [UIViewController]? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let vc = self.popToRootViewController(animated: animated)
        CATransaction.commit()
        return vc
    }
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        super.popToRootViewController(animated: animated)
    }
}


// MARK: - UIGestureRecognizerDelegate
extension SFNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let vc = self.visibleViewController as? SFViewController {
            let (will, _) = vc.willBack()
            return will
        }
        return true
    }
}

//// MARK: - UINavigationControllerDelegate
//extension SFNavigationController: UINavigationControllerDelegate {
//    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
//            interactivePopGestureRecognizer?.isEnabled = viewControllers.count > 1
//        }
//    }
//}
