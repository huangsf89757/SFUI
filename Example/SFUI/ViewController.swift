////
////  ViewController.swift
////  SFUI
////
////  Created by hsf89757 on 07/18/2024.
////  Copyright (c) 2024 hsf89757. All rights reserved.
////
//
//import UIKit
//
//import SFBase
//import SFUI
//// Third
//import SnapKit
//import Then
//
//class ViewController: SFViewController {
//    
//    private lazy var tableView: SFCardTableView = {
//        return SFCardTableView(frame: .zero, style: .grouped).then { view in
//            view.delegate = self
//            view.dataSource = self
//            view.register(cellType: SFCardTableViewCell.self)
//            view.register(headerFooterViewType: SFCardTableViewHeaderFooterView.self)
//            view.rowHeight = 50
//            view.sectionHeaderHeight = 60
//            view.sectionFooterHeight = 60
//            view.clipsToBounds = true
//        }
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "Home"
//        
//        
//               
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        
////        let linkLabel = SFLabel().then { view in
////            view.textColor = .black
////            view.font = .systemFont(ofSize: 17, weight: .regular)
////            view.numberOfLines = 0
////        }
////        view.addSubview(linkLabel)
////        linkLabel.snp.makeConstraints { make in
////            make.centerY.equalToSuperview()
////            make.leading.equalToSuperview().offset(10)
////            make.trailing.equalToSuperview().offset(-10)
////        }
////        linkLabel.text = "哈佛沙发爱哈佛施法哦四件套洒脱放到死发送几条件发送礼服扫街佛阿四发G露个你副教授金佛瓜瓜是否阿什贡嘎哈"
////        linkLabel.addLink(text: "哈佛") {
////            print("哈佛", "clicked")
////        }
////        
////        linkLabel.addLink(text: "法哦四") {
////            print("法哦四", "clicked")
////        }
////        
////        linkLabel.addLink(text: "死发送几条件发送", attrs: [:
//////            NSAttributedString.Key.foregroundColor : UIColor.red,
//////            NSAttributedString.Key.backgroundColor : UIColor.green
////        ]) {
////            print("死发送几条件发送", "clicked")
////        }
////       
////        linkLabel.addLink(text: "是否阿", attrs: [:
//////            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30, weight: .bold),
//////            NSAttributedString.Key.foregroundColor : UIColor.gray
////        ]) {
////            print("是否阿", "clicked")
////        }
//    }
//   
//
//}
//
//extension ViewController: UITableViewDataSource, UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 10
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return section
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFCardTableViewCell.self)
//        cell.backgroundColorNor = .lightGray
//        cell.backgroundColorSel = .blue
//        return cell
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableHeaderFooterView(SFCardTableViewHeaderFooterView.self)
//        header?.backgroundColorNor = .green
//        header?.cardInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
//        return header
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = tableView.dequeueReusableHeaderFooterView(SFCardTableViewHeaderFooterView.self)
//        footer?.backgroundColorNor = .red
//        footer?.cardInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//        return footer
//    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let tableView = tableView as? SFCardTableView else {
//            return
//        }
//        tableView.card(cell: cell, at: indexPath)
//    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        guard let tableView = tableView as? SFCardTableView else {
//            return
//        }
//        tableView.card(header: view, at: section)
//    }
//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        guard let tableView = tableView as? SFCardTableView else {
//            return
//        }
//        tableView.card(footer: view, at: section)
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let vc = CatlogExampleVC()
////        let vc = OutlineExampleVC()
////        let vc = PopViewExampleVC()
//        let vc = BluetoothExampleVC()
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
