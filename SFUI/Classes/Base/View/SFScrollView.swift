//
//  SFScrollView.swift
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

// MARK: - SFScrollView
open class SFScrollView: UIScrollView {
    // MARK: Dir
    public enum Direction {
        case none
        case horizontal
        case vertical
    }
    
    // MARK: var
    public let dir: Direction
  
    
    // MARK: life cycle
    public init(dir: Direction) {
        self.dir = dir
        super.init(frame: .zero)
        contentInsetAdjustmentBehavior = .never
        isScrollEnabled = true
        showsVerticalScrollIndicator = dir == .vertical
        showsHorizontalScrollIndicator = dir == .horizontal
        customUI()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ui
    public private(set) lazy var contentView: SFView = {
        return SFView().then { view in
            view.backgroundColor = R.color.content()
        }
    }()
    private func customUI() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            switch dir {
            case .none:
                make.width.greaterThanOrEqualToSuperview()
                make.height.greaterThanOrEqualToSuperview()
            case .horizontal:
                make.width.greaterThanOrEqualToSuperview()
                make.height.equalToSuperview()
            case .vertical:
                make.width.equalToSuperview()
                make.height.greaterThanOrEqualToSuperview()
            }
        }
    }
    
    // MARK: func
    /// 停止滚动
    public func stopScrolling() {
        setContentOffset(contentOffset, animated: false)
    }
}
