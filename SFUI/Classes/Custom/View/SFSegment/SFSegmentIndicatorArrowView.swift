//
//  SFSegmentIndicatorArrowView.swift
//  SFUI
//
//  Created by hsf on 2024/9/3.
//

import Foundation

// MARK: - SFSegmentIndicatorArrowView
open class SFSegmentIndicatorArrowView: SFSegmentIndicatorPositionView {
    // MARK: var
    public override var color: UIColor? {
        didSet {
            arrowView.shapeLayer.fillColor = color?.cgColor
        }
    }
    /// size
    public var size: CGSize
    
    
    // MARK: life cycle
    public init(position: SFSegmentIndicatorPositionView.Position = .bottom(0), size: CGSize = CGSize(width: 8, height: 8)) {
        self.size = size
        super.init(position: position)
        customUI()
    }
    
    // MARK: ui
    public private(set) var arrowView: SFTriangleView = {
        return SFTriangleView()
    }()
    
    private func customUI() {
        arrowView.shapeLayer.fillColor = color?.cgColor
        switch position {
        case .top(let space):
            arrowView.rotationAngle = Double.pi
        case .leading(let space):
            arrowView.rotationAngle = Double.pi / 2
        case .trailing(let space):
            arrowView.rotationAngle = -Double.pi / 2
        case .bottom(let space):
            arrowView.rotationAngle = 0
        }
        addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
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
                make.size.equalTo(size)
            }
            func makeLeadingOrTrailing() {
                make.centerY.equalToSuperview()
                make.size.equalTo(size)
            }
        }
    }
}
