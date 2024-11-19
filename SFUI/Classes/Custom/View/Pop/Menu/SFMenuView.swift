////
////  SFMenuView.swift
////  SFUI
////
////  Created by hsf on 2024/7/21.
////
//
//import Foundation
//import UIKit
//// Basic
//import SFBase
//// Third
//import Then
//import SnapKit
//
//
//// MARK: - SFMenuView
//class SFMenuView: SFPopView {
//    // MARK: var
//    var dependencyView: UIView?
//    
//    private lazy var tableView: SFTableView = {
//        return SFTableView(frame: .zero, style: .plain).then { view in
//            view.delegate = self
//            view.dataSource = self
//            view.register(cellType: SFMenuCell.self)
//            
//        }
//    }()
//    
//    // MARK: life cycle
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = .clear
//        shapeLayer.fillColor = SFColor.UI.content?.cgColor
//        maskConfigeration.color = .clear
//        maskConfigeration.clickEnable = true
//        autoDismissWhenClickMask = false
//        customUI()
//    }
//    override func customLayout() {
//        self.snp.remakeConstraints { make in
//            switch position {
//            case .top(offset: let offset):
//                make.top.equalToSuperview().offset(offset)
//            case .center(offset: let offset):
//                make.centerY.equalToSuperview().offset(offset)
//            case .bottom(offset: let offset):
//                make.bottom.equalToSuperview().offset(-offset)
//            }
//            make.centerX.equalToSuperview()
//            make.width.greaterThanOrEqualTo(60)
//            make.width.lessThanOrEqualTo(SFApp.screenWidthPortrait() - 60)
//            make.height.greaterThanOrEqualTo(40)
//            make.height.lessThanOrEqualTo(SFApp.screenHeightPortrait() - 60)
//        }
//    }
//    override func customShapePath(rect: CGRect) -> UIBezierPath? {
//        return UIBezierPath(roundedRect: rect, cornerRadius: 20)
//    }
//    
//    // MARK: ui
//    /// 自定义约束
//    private func customUI() {
//        addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(8)
//            make.leading.equalToSuperview().offset(16)
//            make.bottom.equalToSuperview().offset(-8)
//            make.trailing.equalToSuperview().offset(-16)
//        }
//    }
//}
//
//// MARK: - UITableViewDataSource, UITableViewDelegate
//extension SFMenuView: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SFMenuCell.self)
//        return cell
//    }
//}
