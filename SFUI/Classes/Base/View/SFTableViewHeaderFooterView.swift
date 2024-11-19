//
//  SFTableViewHeaderFooterView.swift
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

// MARK: - SFTableViewHeaderFooterView
open class SFTableViewHeaderFooterView: UITableViewHeaderFooterView {
    // MARK: var
    public var backgroundColorNor: UIColor? {
        didSet {
            backgroundNorView.backgroundColor = backgroundColorNor
        }
    }
    public lazy var backgroundNorView: SFView = {
        return SFView().then { view in
            view.backgroundColor = .clear
        }
    }()
    
    // MARK: life cycle
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = SFColor.UI.content
        backgroundView = backgroundNorView
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Reusable
extension SFTableViewHeaderFooterView: Reusable {}
