//
//  SFSegmentIndicatorImageView.swift
//  SFUI
//
//  Created by hsf on 2024/9/3.
//

import Foundation

// MARK: - SFSegmentIndicatorImageView
open class SFSegmentIndicatorImageView: SFSegmentIndicatorView {
    // MARK: var
    public override var color: UIColor? {
        didSet {
            imageView.backgroundColor = color
        }
    }
    
    /// 缩进
    public var edgeInsert: UIEdgeInsets = .zero {
        didSet {
            imageView.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(edgeInsert.top)
                make.leading.equalToSuperview().offset(edgeInsert.left)
                make.trailing.equalToSuperview().offset(-edgeInsert.right)
                make.bottom.equalToSuperview().offset(-edgeInsert.bottom)
            }
            setNeedsLayout()
        }
    }
    
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: ui
    public private(set) var imageView: SFView = {
        return SFView()
    }()
    
    private func customUI() {
        imageView.backgroundColor = color
        imageView.layer.masksToBounds = true
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(edgeInsert.top)
            make.leading.equalToSuperview().offset(edgeInsert.left)
            make.trailing.equalToSuperview().offset(-edgeInsert.right)
            make.bottom.equalToSuperview().offset(-edgeInsert.bottom)
        }
    }
}
