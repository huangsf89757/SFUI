////
////  OutlineExampleVC.swift
////  SFUI_Example
////
////  Created by hsf on 2024/7/24.
////  Copyright © 2024 CocoaPods. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//import SFBase
//import SFUI
//// Third
//import SnapKit
//import Then
//
//class OutlineExampleVC: SFViewController {
//    
//    private lazy var outlineView: SFOutlineView = {
//        return SFOutlineView().then { view in
//            view.backgroundColor = .gray
//        }
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "CatlogExampleVC"
//        view.addSubview(outlineView)
//        outlineView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        outlineView.tree.clear()
//        
//        let node0 = SFNode(value: SFOutlineItemModel(name: "0"))
//        let node00 = SFNode(value: SFOutlineItemModel(name: "00"))
//        let node000 = SFNode(value: SFOutlineItemModel(name: "000"))
//        let node0000 = SFNode(value: SFOutlineItemModel(name: "0000"))
//        let node00000 = SFNode(value: SFOutlineItemModel(name: "00000"))
//        let node01 = SFNode(value: SFOutlineItemModel(name: "01"))
//        let node02 = SFNode(value: SFOutlineItemModel(name: "02"))
//        let node020 = SFNode(value: SFOutlineItemModel(name: "020"))
//        
//        let node1 = SFNode(value: SFOutlineItemModel(name: "1"))
//        let node10 = SFNode(value: SFOutlineItemModel(name: "10"))
//        
//        
//        let root = outlineView.tree.root
//        
//        node0.append(child: node00)
//        node00.append(child: node000)
//        node000.append(child: node0000)
//        node0000.append(child: node00000)
//        node0.append(child: node01)
//        node0.append(child: node02)
//        node02.append(child: node020)
//        node1.append(child: node10)
//                
//        
//        root.append(child: node1)
//        root.append(child: node0)
//        
//        outlineView.tree.reload()
//    }
//}
//
