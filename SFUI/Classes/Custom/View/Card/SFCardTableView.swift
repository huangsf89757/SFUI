//
//  SFCardTableView.swift
//  SFUI
//
//  Created by hsf on 2024/7/22.
//

import Foundation
import UIKit

// MARK: - card cell
extension SFTableView {
    /// 给cell设置成card类型UI
    /// 在willDisplay中调用
    public func card(cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? SFCardTableViewCell else { return }
        guard let rowCount = dataSource?.tableView(self, numberOfRowsInSection: indexPath.section) else { return }
        let radius = cell.cardRadius
        var effectCorner = cell.cardCorner.intersection([.topLeft, .topRight, .bottomLeft, .bottomRight])
        let inset = cell.cardInset
        let rect = cell.bounds.inset(by: inset)
        var path: UIBezierPath?
        if rowCount == 1 {
            if let header = delegate?.tableView?(self, viewForHeaderInSection: indexPath.section) as? SFCardTableViewHeaderFooterView {
                effectCorner.remove([.topLeft, .topRight])
            }
            if let footer = delegate?.tableView?(self, viewForFooterInSection: indexPath.section) as? SFCardTableViewHeaderFooterView {
                effectCorner.remove([.bottomLeft, .bottomRight])
            }
            if effectCorner.contains(.topLeft) || effectCorner.contains(.topRight)
               || effectCorner.contains(.bottomLeft) || effectCorner.contains(.bottomRight) {
                let corners = effectCorner.intersection([.topLeft, .topRight, .bottomLeft, .bottomRight])
                path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            }else{
                path = UIBezierPath(rect: rect)
            }
        } else {
            if indexPath.row == 0 {
                if let header = delegate?.tableView?(self, viewForHeaderInSection: indexPath.section) as? SFCardTableViewHeaderFooterView {
                    effectCorner.remove([.topLeft, .topRight])
                }
                if effectCorner.contains(.topLeft) || effectCorner.contains(.topRight) {
                    let corners = effectCorner.intersection([.topLeft, .topRight])
                    path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                }else{
                    path = UIBezierPath(rect: rect)
                }
            }
            else if indexPath.row == rowCount - 1 {
                if let footer = delegate?.tableView?(self, viewForFooterInSection: indexPath.section) as? SFCardTableViewHeaderFooterView {
                    effectCorner.remove([.bottomLeft, .bottomRight])
                }
                if effectCorner.contains(.bottomLeft) || effectCorner.contains(.bottomRight) {
                    let corners = effectCorner.intersection([.bottomLeft, .bottomRight])
                    path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                }else{
                    path = UIBezierPath(rect: rect)
                }
            }
            else {
                path = UIBezierPath(rect: rect)
            }
        }
        cell.cardBackgroundNorLayer.frame = cell.bounds
        cell.cardBackgroundSelLayer.frame = cell.bounds
        cell.cardBackgroundNorLayer.path = path?.cgPath
        cell.cardBackgroundSelLayer.path = path?.cgPath
    }
 
    /// 给header设置成card类型UI
    /// 在willDisplay中调用
    public func card(header: UIView?, at section: Int) {
        guard let header = header as? SFCardTableViewHeaderFooterView else { return }
        let radius = header.cardRadius
        let effectCorner = header.cardCorner.intersection([.topLeft, .topRight])
        let inset = header.cardInset
        let rect = header.bounds.inset(by: inset)
        var path: UIBezierPath?
        if effectCorner.contains(.topLeft) || effectCorner.contains(.topRight) {
            let corners = effectCorner.intersection([.topLeft, .topRight])
            path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        }else{
            path = UIBezierPath(rect: rect)
        }
        header.cardBackgroundNorLayer.frame = header.bounds
        header.cardBackgroundNorLayer.path = path?.cgPath
    }
    
  
    
    /// 给footer设置成card类型UI
    /// 在willDisplay中调用
    public func card(footer: UIView?, at section: Int) {
        guard let footer = footer as? SFCardTableViewHeaderFooterView else { return }
        let radius = footer.cardRadius
        let effectCorner = footer.cardCorner.intersection([.bottomLeft, .bottomRight])
        let inset = footer.cardInset
        let rect = footer.bounds.inset(by: inset)
        var path: UIBezierPath?
        if effectCorner.contains(.bottomLeft) || effectCorner.contains(.bottomRight) {
            let corners = effectCorner.intersection([.bottomLeft, .bottomRight])
            path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        }else{
            path = UIBezierPath(rect: rect)
        }
        footer.cardBackgroundNorLayer.frame = footer.bounds
        footer.cardBackgroundNorLayer.path = path?.cgPath
    }
    
}
