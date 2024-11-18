//
//  SFCollectionViewController.swift
//  SFUI
//
//  Created by hsf on 2024/9/14.
//

import Foundation
import UIKit


// MARK: - SFCollectionViewController
open class SFCollectionViewController: SFViewController {
    // MARK: var
    public let collectionView: SFCollectionView
   
    // MARK: init
    public init(collectionViewLayout: UICollectionViewLayout) {
        collectionView = SFCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
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
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
