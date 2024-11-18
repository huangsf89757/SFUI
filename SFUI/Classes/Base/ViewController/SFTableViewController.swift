//
//  SFTableViewController.swift
//  SFUI
//
//  Created by hsf on 2024/9/14.
//

import Foundation
import UIKit


// MARK: - SFTableViewController
open class SFTableViewController: SFViewController {
    // MARK: var
    public let tableView: SFTableView
   
    // MARK: init
    public init(style: UITableView.Style) {
        tableView = SFTableView(frame: .zero, style: style)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        customUI()
    }
    
    // MARK: ui
    private func customUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
}
