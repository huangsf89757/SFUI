//
//  SFEditViewController.swift
//  SFUI
//
//  Created by hsf on 2025/1/9.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Third
import Then
import SnapKit

// MARK: - SFEditViewController
open class SFEditViewController<T: Equatable>: SFViewController {
    // MARK: block
    public var isEditDidChangedBlock: ((Bool) -> ())?
    
    // MARK: var
    /// 是否正在编辑
    public private(set) var isEdit = false {
        didSet {
            updateIsEdit()
        }
    }
    
    // MARK: alert
    public var saveAlertTitle = SFText.UI.com_save
    public var saveAlertMsg = ""
    public var saveAlertSureTitle = SFText.UI.com_sure
    public var saveAlertCancelTitle = SFText.UI.com_cancel
    
    // MARK: data
    public var data: T?
    private var data_saved: T?
    
    // MARK: life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
        updateIsEdit()
    }
    
    // MARK: ui
    private lazy var editBtn: SFButton = {
        return SFButton().then { view in
            view.setTitle(SFText.UI.com_edit, for: .normal)
            view.setTitle(SFText.UI.com_save, for: .selected)
            view.setTitleColor(SFColor.UI.title, for: .normal)
            view.setTitleColor(SFColor.UI.title, for: .selected)
            view.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
        }
    }()
    
    // MARK: back
    open override func willBack() -> (will: Bool, animated: Bool) {
        guard isEdit else {
            return super.willBack()
        }
        let isNeedSave = checkNeedSaveOrNot()
        if isNeedSave {
            showSaveAlert(cancelBlock: { [weak self] _ in
                self?.goBack(animated: true)
            }, sureBlock: { [weak self] _ in
                self?.goBack(animated: true)
            })
            return (false, false)
        } else {
            return super.willBack()
        }
    }

    // MARK: action
    @objc private func editBtnClicked() {
        if isEdit {
            let needSave = checkNeedSaveOrNot()
            if needSave {
                showSaveAlert()
            } else {
                isEdit = false
            }
        } else {
            data_saved = data
            isEdit = true
        }
    }
       
    // MARK: override func
    /// 执行保存
    open func executeSave() async -> Bool {
        // 在子类中重写
        return true
    }
        
}

// MARK: - Func
extension SFEditViewController {
    private func updateIsEdit() {
        editBtn.isSelected = isEdit
        isEditDidChangedBlock?(isEdit)
    }
}

// MARK: - Save
extension SFEditViewController {
    private func checkNeedSaveOrNot() -> Bool {
        guard let data = data,
              let data_saved = data_saved else {
            return false
        }
        return data != data_saved
    }
    
    private func save() async -> Bool {
        self.startSave()
        let isSuccess = await executeSave()
        if isSuccess {
            SFHud.show(.success, msg: SFText.UI.com_save_success, stay: 2)
        } else {
            SFHud.show(.success, msg: SFText.UI.com_save_failure, stay: 2)
        }
        self.finishSave()
        return isSuccess
    }
    
    private func startSave() {
        editBtn.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.24) {
            self.editBtn.alpha = 0.5
        }
    }
        
    private func finishSave() {
        editBtn.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.24) {
            self.editBtn.alpha = 1.0
        }
    }
}

// MARK: - Alert
extension SFEditViewController {
    private func showSaveAlert(cancelBlock: ((SFAlertView) -> ())? = nil, sureBlock: ((SFAlertView) -> ())? = nil) {
        SFAlert.config(title: saveAlertTitle, msg: saveAlertMsg)
        SFAlert.addCancelAction(title: saveAlertCancelTitle) { [weak self] alertView in
            self?.data = self?.data_saved
            self?.isEdit = false
            if let cancelBlock = cancelBlock {
                 cancelBlock(alertView)
            }
            return true
        }
        SFAlert.addConfirmAction(title: saveAlertSureTitle) { [weak self] alertView in
            Task {
                let isSuccess = await self?.save() ?? false
                if isSuccess {
                    self?.isEdit = false
                    if let sureBlock = sureBlock {
                        sureBlock(alertView)
                    }
                }
            }
            return true
        }
        SFAlert.show(autoDismiss: true)
    }
}
