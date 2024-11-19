//
//  SFTableView.swift
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

// MARK: - SFTableView
open class SFTableView: UITableView {
    // MARK: life cycle
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = R.color.content()
        contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) { sectionHeaderTopPadding = 0 }
        rowHeight = UITableView.automaticDimension
        tableFooterView = UIView()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: func
    /// 停止滚动
    public func stopScrolling() {
        setContentOffset(contentOffset, animated: false)
    }
}

// MARK: - position
extension SFTableView {
    public func configPosition(cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? SFTableViewCell else { return }
        guard let rowCount = dataSource?.tableView(self, numberOfRowsInSection: indexPath.section) else { return }
        var position: SFTableViewCell.Position?
        if rowCount == 1 {
            position = .only
            
        } else {
            if indexPath.row == 0 {
                position = .first
            }
            else if indexPath.row == rowCount - 1 {
                position = .last
            }
            else {
                position = .mid
            }
        }
        cell.position = position
    }
}
