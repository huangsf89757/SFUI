//
//  SFTableView.swift
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
import EmptyDataSet_Swift

// MARK: - SFTableView
open class SFTableView: UITableView {
    // MARK: life cycle
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = SFColor.UI.background
        contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) { sectionHeaderTopPadding = 0 }
        rowHeight = UITableView.automaticDimension
        sectionHeaderHeight = UITableView.automaticDimension
        sectionFooterHeight = UITableView.automaticDimension
        tableFooterView = UIView()
        emptyDataSetView { view in
//            var title = NSMutableAttributedString(string: SFText.UI.noData)
//            let range = NSRange(location: 0, length: title.length)
//            title.setAttributes([
//                .font: UIFont.systemFont(ofSize: 12, weight: .regular)
//            ], range: range)
            view.image(SFImage.UI.Com.noData)
        }
        /*
         tableView.emptyDataSetView { view in
             view.titleLabelString(titleString)
                 .detailLabelString(detailString)
                 .image(image)
                 .imageAnimation(imageAnimation)
                 .buttonTitle(buttonTitle, for: .normal)
                 .buttonTitle(buttonTitle, for: .highlighted)
                 .buttonBackgroundImage(buttonBackgroundImage, for: .normal)
                 .buttonBackgroundImage(buttonBackgroundImage, for: .highlighted)
                 .dataSetBackgroundColor(backgroundColor)
                 .verticalOffset(verticalOffset)
                 .verticalSpace(spaceHeight)
                 .shouldDisplay(true, view: tableView)
                 .shouldFadeIn(true)
                 .isTouchAllowed(true)
                 .isScrollAllowed(true)
                 .isImageViewAnimateAllowed(isLoading)
                 .didTapDataButton {
                     // Do something
                 }
                 .didTapContentView {
                     // Do something
                 }
         }
         */
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
