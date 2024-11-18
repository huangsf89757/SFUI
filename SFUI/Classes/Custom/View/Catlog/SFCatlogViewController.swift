//
//  SFCatlogViewController.swift
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


// MARK: - SFCatlogViewController (目录)
open class SFCatlogViewController: SFViewController {
    // MARK: var
    public private(set) lazy var tableView: SFTableView = {
        return SFTableView(frame: .zero, style: .plain).then { view in
            view.delegate = self
            view.dataSource = self
            view.register(cellType: SFCatlogCell.self)
        }
    }()
    public private(set) lazy var tree: SFTree<SFCatlogItemModel> = {
        let tree = SFTree<SFCatlogItemModel>()
        tree.reloadCompleteBlock = { // TODO: 增加动画更新效果
            [weak self] in
            self?.tableView.reloadData()
        }
        return tree
    }()
    
    
    // MARK: life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    // MARK: func
    private func customUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension SFCatlogViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tree.visibleNodes.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCatlogCell.self)
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
