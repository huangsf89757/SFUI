//
//  SFScrollViewController.swift
//  SFUI
//
//  Created by hsf on 2024/8/7.
//

import Foundation
import UIKit


// MARK: - SFScrollViewController
open class SFScrollViewController: SFViewController {
    // MARK: var
    public let scrollView: SFScrollView
   
    // MARK: init
    public convenience init() {
        self.init(dir: .vertical)
    }
    public init(dir: SFScrollView.Direction) {
        scrollView = SFScrollView(dir: dir)
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
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
