//
//  SFSegmentIndicatorSquareView.swift
//  SFUI
//
//  Created by hsf on 2024/9/3.
//

import Foundation

// MARK: - SFSegmentIndicatorSquareView
open class SFSegmentIndicatorSquareView: SFSegmentIndicatorView {
    // MARK: var
    public override var color: UIColor? {
        didSet {
            squareView.backgroundColor = color
        }
    }
    
    /// 缩进
    public var edgeInsert: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            squareView.snp.updateConstraints { make in
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
    public private(set) var squareView: SFView = {
        return SFView()
    }()
    
    private func customUI() {
        squareView.backgroundColor = color?.withAlphaComponent(0.3)
        squareView.layer.cornerRadius = 4
        squareView.layer.masksToBounds = true
        addSubview(squareView)
        squareView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(edgeInsert.top)
            make.leading.equalToSuperview().offset(edgeInsert.left)
            make.trailing.equalToSuperview().offset(-edgeInsert.right)
            make.bottom.equalToSuperview().offset(-edgeInsert.bottom)
        }
    }
}
