//
//  SFOutlineView.swift
//  SFUI
//
//  Created by hsf on 2024/7/23.
//

import Foundation
import UIKit
// Basic
import SFBase
// Third
import Then
import SnapKit


// MARK: - SFOutlineView （大纲）
open class SFOutlineView: SFView {
    // MARK: var
    public private(set) lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .plain).then { view in
            view.delegate = self
            view.dataSource = self
            view.register(cellType: SFOutlineCell.self)
        }
    }()
    public private(set) lazy var tree: SFTree<SFOutlineItemModel> = {
        let tree = SFTree<SFOutlineItemModel>()
        tree.reloadCompleteBlock = { // TODO: 增加动画更新效果
            [weak self] in
            self?.tableView.reloadData()
        }
        return tree
    }()
    
    
    // MARK: life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }
    
    // MARK: func
    private func customUI() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFOutlineView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tree.visibleNodes.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFOutlineCell.self)
        let node = tree.visibleNodes[indexPath.row]
        cell.node = node
        cell.expandBlock = {
            node in
            node?.expandOrShrink()
        }
        return cell
    }
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

