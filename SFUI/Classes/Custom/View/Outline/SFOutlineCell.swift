//
//  SFOutlineCell.swift
//  SFUI
//
//  Created by hsf on 2024/7/23.
//

import Foundation
import UIKit
// Basic
import SFBase
// Third
import Then
import SnapKit



// MARK: - SFOutlineCell
open class SFOutlineCell: SFTableViewCell {
    // MARK: var
    public var node: SFNode<SFOutlineItemModel>? {
        didSet {
            guard let node = node else { return }
            guard let itemModel = node.value else { return }
            expandBtn.isHidden = !node.isExpandable
            let arrowImage = (node.isExpanded ? SFImage.UI.Triangle.bottom : SFImage.UI.Triangle.right)?.sf.resize(to: CGSize(width: 20, height: 20))
            expandBtn.setImage(arrowImage, for: .normal)
            nameLable.text = itemModel.name
            let leadingOffset = CGFloat((node.levelIdx - 1) * 10)
            expandBtn.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(leadingOffset)
            }
            var leftInset = leadingOffset
            leftInset += expandBtn.isHidden ? 40 : 0
            separatorInset = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
            layoutIfNeeded()
        }
    }
    /// 展开 / 收起 回调
    public var expandBlock: ((SFNode<SFOutlineItemModel>?)->())?
    
    /// 展开 / 收起
    public private(set) lazy var expandBtn: SFButton = {
        return SFButton().then { view in
            view.addTarget(self, action: #selector(expandBtnClicked), for: .touchUpInside)
        }
    }()
    /// 名称
    public private(set) lazy var nameLable: SFLabel = {
        return SFLabel().then { view in
            
        }
    }()
    
    
    // MARK: life cycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customUI()
    }
    
    // MARK: custom ui
    private func customUI() {
        contentView.addSubview(expandBtn)
        contentView.addSubview(nameLable)
        
        expandBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.top.greaterThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        nameLable.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.leading.equalTo(expandBtn.snp.trailing)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    
    // MARK: func
    @objc
    private func expandBtnClicked() {
        expandBlock?(node)
    }
}

