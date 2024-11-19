//
//  SFSegmentView.swift
//  SFUI
//
//  Created by hsf on 2024/8/15.
//

import Foundation
import UIKit
import AudioToolbox
// Basic
import SFBase

// TODO: 嵌套一个ScrollView实现：
// 1、水平位置：居左、居中、居右
// 2、垂直位置：居上、居中、居下
// 3、宽高：定宽、自适应宽、均分宽
// 4、点击item后自动居中


// MARK: - SFSegmentView
open class SFSegmentView: SFView {
    // MARK: nameSFSegmentItem
    public typealias SFSegmentItem = SFButton
    
    // MARK: Direction
    public enum Direction {
        case horizontal
        case vertical
    }
    
    // MARK: block
    /// 选中回调
    public var didSelectedItemBlock: ((SFSegmentView, Int) -> ())?
    /// 自定义指示器动画
    public var indicatorAnimationBlock: ((SFSegmentIndicatorView, SFSegmentItem) -> Void)?
    
    // MARK: var
    public private(set) var direction: Direction
    public private(set) var titles: [String?]?
    public private(set) var images: [UIImage?]?
    public private(set) var selectedImages: [UIImage?]?
    
    /// 震动反馈
    public var isFeedbackEnable = true
        
    public private(set) var items = [SFSegmentItem]()
    public private(set) var selectedItem: SFSegmentItem?
    
    /// 指示器
    public var indicatorView: SFSegmentIndicatorView? = SFSegmentIndicatorLineView() {
        didSet {
            oldValue?.removeFromSuperview()
            updateIndicatorView(animated: false)
        }
    }
    
    /// 缩进
    public var edgeInsert: UIEdgeInsets = .zero {
        didSet {
            updateEdgeInsert()
        }
    }
    
    /// item之间的间距
    public var spaceOfItems: CGFloat = 0 {
        didSet {
            updateSpaceOfItems()
        }
    }
    
    /// item的title和image之间的组合样式
    public var itemStyle: SFSegmentItem.Style = .top(0) {
        didSet {
            
        }
    }
    
    /// 当前选中索引
    public private(set) var selectedIndex = 0
    
    /// 标题字体
    public var titleFont: UIFont = .systemFont(ofSize: 10, weight: .regular) {
        didSet {
            updateTitleFont()
        }
    }
    
    /// 选中标题字体
    public var selectedTitleFont: UIFont? {
        didSet {
            updateTitleFont()
        }
    }
    
    /// 标题颜色
    public var titleColor: UIColor? = SFColor.UI.placeholder {
        didSet {
            updateTitleColor()
        }
    }
    
    /// 选中标题颜色
    public var selectedTitleColor: UIColor? = SFColor.UI.theme {
        didSet {
            updateSelectedTitleColor()
        }
    }
    
    // MARK: life cycle
    public init(direction: Direction = .horizontal,
                titles: [String?]?,
                images: [UIImage?]?,
                selectedImages: [UIImage?]? = nil) {
        self.direction = direction
        self.titles = titles
        self.images = images
        self.selectedImages = selectedImages
        super.init(frame: .zero)
        customUI()
    }
    
    // MARK: ui
    private lazy var contentView: SFView = {
        return SFView()
    }()
    private func customUI() {
        let withTitle = (titles != nil)
        let withImage = ((images != nil) || (selectedImages != nil))
        if withTitle == false, withImage == false {
            return
        }
        var count = 0
        if withTitle {
            guard let titles = titles, titles.count > 0 else { return }
            if withImage {
                guard let images = images else { return }
                guard titles.count == images.count else { return }
                if let selectedImages = selectedImages {
                    guard titles.count == selectedImages.count else { return }
                }
            }
            count = titles.count
        } else {
            if withImage {
                guard let images = images, images.count > 0 else { return }
                if let selectedImages = selectedImages {
                    guard images.count == selectedImages.count else { return }
                }
                count = images.count
            }
        }
        guard count > 0 else {
            return
        }
        
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(edgeInsert.top)
            make.leading.equalToSuperview().offset(edgeInsert.left)
            make.trailing.equalToSuperview().offset(-edgeInsert.right)
            make.bottom.equalToSuperview().offset(-edgeInsert.bottom)
        }
        
        var lastItem: SFSegmentItem?
        var selectedItem: SFSegmentItem?
        for i in 0..<count {
            let title = titles?[i]
            let image = images?[i]
            let selectedImage = selectedImages?[i]
            let item = SFSegmentItem().then { view in
                view.titleLabel?.font = titleFont
                view.setTitle(title, for: .normal)
                view.setTitleColor(titleColor, for: .normal)
                view.setTitleColor(selectedTitleColor, for: .selected)
                view.setImage(image, for: .normal)
                if let selectedImage = selectedImage {
                    view.setImage(selectedImage, for: .selected)
                } else {
                    view.setImage(image, for: .selected)
                }
                if withTitle, withImage {
                    view.style = itemStyle
                }
                view.addTarget(self, action: #selector(itemClicked(_:)), for: .touchUpInside)
                view.tag = i
                view.isSelected = selectedIndex == i
            }
            items.append(item)
            contentView.addSubview(item)
            item.snp.makeConstraints { make in
                switch direction {
                case .horizontal:
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    if let lastItem = lastItem {
                        make.leading.equalTo(lastItem.snp.trailing).offset(spaceOfItems)
                        make.width.equalTo(lastItem)
                    } else {
                        make.leading.equalToSuperview()
                    }
                    if i == count - 1 {
                        make.trailing.equalToSuperview()
                    }
                case .vertical:
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    if let lastItem = lastItem {
                        make.top.equalTo(lastItem.snp.bottom).offset(spaceOfItems)
                        make.height.equalTo(lastItem)
                    } else {
                        make.top.equalToSuperview()
                    }
                    if i == count - 1 {
                        make.bottom.equalToSuperview()
                    }
                }
            }
            lastItem = item
            if selectedIndex == i {
                selectedItem = item
            }
        }
        self.selectedItem = selectedItem
        
        if let indicatorView = indicatorView, let selectedItem = selectedItem {
            contentView.insertSubview(indicatorView, at: 0)
            indicatorView.snp.makeConstraints { make in
                make.edges.equalTo(selectedItem)
            }
        }
    }
}

// MARK: - action
extension SFSegmentView {
    @objc private func itemClicked(_ sender: SFSegmentItem) {
        selectedIndex = sender.tag
        selectedItem = sender
        for item in items {
            item.isSelected = selectedIndex == item.tag
            if item === selectedItem {
                if let selectedTitleFont = selectedTitleFont {
                    item.titleLabel?.font = selectedTitleFont
                } else {
                    item.titleLabel?.font = titleFont
                }
            } else {
                item.titleLabel?.font = titleFont
            }
        }
        if let indicatorView = indicatorView, let selectedItem = selectedItem {
            if let indicatorAnimationBlock = indicatorAnimationBlock {
                // 使用自定义动画执行方式
                indicatorAnimationBlock(indicatorView, selectedItem)
            } else {
                // 默认动画执行方式
                UIView.animate(withDuration: 0.3) {
                    self.updateIndicatorConstraints(indicatorView: indicatorView, selectedItem: selectedItem)
                }
            }
        }
        if isFeedbackEnable {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        didSelectedItemBlock?(self, selectedIndex)
    }
    
    /// 更新指示器约束
    public func updateIndicatorConstraints(indicatorView: SFSegmentIndicatorView, selectedItem: SFSegmentItem) {
        indicatorView.snp.remakeConstraints { make in
            make.edges.equalTo(selectedItem)
        }
        layoutIfNeeded()
    }
}

// MARK: - func
extension SFSegmentView {
    public func select(index: Int, animated: Bool) {
        selectedIndex = index
        updateSeletedIndex()
        updateTitleFont()
        updateIndicatorView(animated: animated)
    }
}

// MARK: - update
extension SFSegmentView {
    private func updateIndicatorView(animated: Bool) {
        if let indicatorView = indicatorView, let selectedItem = selectedItem {
            contentView.insertSubview(indicatorView, at: 0)
            if animated {
                if let indicatorAnimationBlock = indicatorAnimationBlock {
                    // 使用自定义动画执行方式
                    indicatorAnimationBlock(indicatorView, selectedItem)
                } else {
                    // 默认动画执行方式
                    UIView.animate(withDuration: 0.3) {
                        self.updateIndicatorConstraints(indicatorView: indicatorView, selectedItem: selectedItem)
                    }
                }
            } else {
                updateIndicatorConstraints(indicatorView: indicatorView, selectedItem: selectedItem)
            }
        }
        
        layoutIfNeeded()
    }
        
    private func updateEdgeInsert() {
        contentView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(edgeInsert.top)
            make.leading.equalToSuperview().offset(edgeInsert.left)
            make.trailing.equalToSuperview().offset(-edgeInsert.right)
            make.bottom.equalToSuperview().offset(-edgeInsert.bottom)
        }
        layoutIfNeeded()
    }
    
    private func updateSpaceOfItems() {
        var lastItem: SFSegmentItem?
        let count = items.count
        for i in 0..<count {
            let item = items[i]
            item.snp.remakeConstraints { make in
                switch direction {
                case .horizontal:
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    if let lastItem = lastItem {
                        make.leading.equalTo(lastItem.snp.trailing).offset(spaceOfItems)
                        make.width.equalTo(lastItem)
                    } else {
                        make.leading.equalToSuperview()
                    }
                    if i == count - 1 {
                        make.trailing.equalToSuperview()
                    }
                case .vertical:
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                    if let lastItem = lastItem {
                        make.top.equalTo(lastItem.snp.bottom).offset(spaceOfItems)
                        make.height.equalTo(lastItem)
                    } else {
                        make.top.equalToSuperview()
                    }
                    if i == count - 1 {
                        make.bottom.equalToSuperview()
                    }
                }
            }
            lastItem = item
        }
        layoutIfNeeded()
    }
    
    private func updateItemStyle() {
        for item in items {
            if let title = item.titleLabel?.text, let image = item.imageView?.image {
                item.style = itemStyle
            }
        }
        layoutIfNeeded()
    }
    
    private func updateSeletedIndex() {
        for (index, item) in items.enumerated() {
            if index == selectedIndex {
                selectedItem = item
            }
            item.isSelected = selectedIndex == item.tag
        }
    }
    
    private func updateTitleFont() {
        for item in items {
            if item === selectedItem {
                if let selectedTitleFont = selectedTitleFont {
                    item.titleLabel?.font = selectedTitleFont
                } else {
                    item.titleLabel?.font = titleFont
                }
            } else {
                item.titleLabel?.font = titleFont
            }
        }
    }
    
    private func updateTitleColor() {
        for item in items {
            item.setTitleColor(titleColor, for: .normal)
        }
    }
    
    private func updateSelectedTitleColor() {
        for item in items {
            item.setTitleColor(selectedTitleColor, for: .selected)
        }
    }
}
