//
//  SFTableViewCell.swift
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
    public var backgroundColorNor: UIColor? = SFColor.UI.content {
        didSet {
            backgroundNorView.backgroundColor = backgroundColorNor
        }
    }
    public var backgroundColorSel: UIColor? = SFColor.UI.gray {
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
            view.backgroundColor = SFColor.UI.divider
        }
    }()
    
    // MARK: - life cycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = SFColor.UI.content
        contentView.backgroundColor = SFColor.UI.content
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
