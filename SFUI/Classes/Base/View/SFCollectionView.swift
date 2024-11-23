//
//  SFCollectionView.swift
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

open class SFCollectionView: UICollectionView {
    
    // MARK: func
    /// 停止滚动
    public func stopScrolling() {
        setContentOffset(contentOffset, animated: false)
    }
}
