//
//  SFSegmentIndicatorLineView.swift
//  SFUI
//
//  Created by hsf on 2024/9/3.
//

import Foundation

// MARK: - SFSegmentIndicatorLineView
open class SFSegmentIndicatorLineView: SFSegmentIndicatorPositionView {
    // MARK: var
    public override var color: UIColor? {
        didSet {
            lineView.backgroundColor = color
        }
    }
    /// 线宽
    public var lineWidth: CGFloat
    /// 线长 
    /// nil：自适应到最大
    /// 负数：最大+该负数
    public var lineLength: CGFloat?
    
    
    // MARK: life cycle
    public init(position: SFSegmentIndicatorPositionView.Position = .bottom(0), lineWidth: CGFloat = 4, lineLength: CGFloat? = 15) {
        self.lineWidth = lineWidth
        self.lineLength = lineLength
        super.init(position: position)
        customUI()
    }
    
    // MARK: ui
    public private(set) var lineView: SFView = {
        return SFView()
    }()
    
    private func customUI() {
        lineView.backgroundColor = color
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            switch position {
            case .top(let space):
                make.top.equalToSuperview().offset(space)
                makeTopOrBottom()
            case .leading(let space):
                make.leading.equalToSuperview().offset(space)
                makeLeadingOrTrailing()
            case .trailing(let space):
                make.trailing.equalToSuperview().offset(-space)
                makeLeadingOrTrailing()
            case .bottom(let space):
                make.bottom.equalToSuperview().offset(-space)
                makeTopOrBottom()
            }
            
            func makeTopOrBottom() {
                make.centerX.equalToSuperview()
                make.height.equalTo(lineWidth)
                if let lineLength = lineLength {
                    if lineLength > 0 {
                        make.width.equalTo(lineLength)
                    } else {
                        make.leading.equalToSuperview().offset(lineLength)
                        make.trailing.equalToSuperview().offset(-lineLength)
                    }
                } else {
                    make.leading.equalToSuperview()
                    make.trailing.equalToSuperview()
                }
            }
            func makeLeadingOrTrailing() {
                make.centerY.equalToSuperview()
                make.width.equalTo(lineWidth)
                if let lineLength = lineLength {
                    if lineLength > 0 {
                        make.height.equalTo(lineLength)
                    } else {
                        make.top.equalToSuperview().offset(lineLength)
                        make.bottom.equalToSuperview().offset(-lineLength)
                    }
                } else {
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            }
        }
    }
}
