//
//  SFTableViewCell.swift
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
import Reusable


// MARK: - SFTableViewCell
open class SFTableViewCell: UITableViewCell {
    // MARK: Position
    public enum Position {
        case only
        case first
        case mid
        case last
    }
    /// 卡片位置
    open var position: Position?
    
    
    // MARK: var
    public var backgroundColorNor: UIColor? {
        didSet {
            backgroundNorView.backgroundColor = backgroundColorNor
        }
    }
    public var backgroundColorSel: UIColor? {
        didSet {
            backgroundSelView.backgroundColor = backgroundColorSel
        }
    }
    public lazy var backgroundNorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = .clear
        }
    }()
    public lazy var backgroundSelView: SFView = {
        return SFView().then { view in
            view.backgroundColor = .clear
        }
    }()    
    public lazy var customSeparator: SFView = {
        return SFView().then { view in
            view.backgroundColor = SFColor.divider
        }
    }()
    
    // MARK: - life cycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = SFColor.content
        contentView.backgroundColor = SFColor.content
        backgroundView = backgroundNorView
        selectedBackgroundView = backgroundSelView
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func draw(_ rect: CGRect) {
        backgroundNorView.backgroundColor = backgroundColorNor
        backgroundSelView.backgroundColor = backgroundColorSel
    }
    
}


// MARK: - Reusable
extension SFTableViewCell: Reusable {}
