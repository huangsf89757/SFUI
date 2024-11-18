//
//  SFSegmentIndicatorDotView.swift
//  SFUI
//
//  Created by hsf on 2024/9/3.
//

import Foundation

// MARK: - SFSegmentIndicatorDotView
open class SFSegmentIndicatorDotView: SFSegmentIndicatorPositionView {
    // MARK: var
    public override var color: UIColor? {
        didSet {
            dotView.backgroundColor = color
        }
    }
    /// 半径
    public var radius: CGFloat
    
    
    // MARK: life cycle
    public init(position: SFSegmentIndicatorPositionView.Position = .bottom(2), radius: CGFloat = 2) {
        self.radius = radius
        super.init(position: position)
        customUI()
    }
    
    // MARK: ui
    public private(set) var dotView: SFView = {
        return SFView()
    }()
    
    private func customUI() {
        dotView.backgroundColor = color
        dotView.layer.cornerRadius = radius
        dotView.layer.masksToBounds = true
        addSubview(dotView)
        dotView.snp.makeConstraints { make in
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
                make.size.equalTo(CGSize(width: radius * 2, height: radius * 2))
            }
            func makeLeadingOrTrailing() {
                make.centerY.equalToSuperview()
                make.size.equalTo(CGSize(width: radius * 2, height: radius * 2))
            }
        }
    }
}
