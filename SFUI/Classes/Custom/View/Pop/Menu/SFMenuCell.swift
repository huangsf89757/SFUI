////
////  SFMenuCell.swift
////  SFUI
////
////  Created by hsf on 2024/8/2.
////
//
//import Foundation
//import UIKit
//// Third
//import Then
//import SnapKit
//
//
//// MARK: - SFMenuCell
//class SFMenuCell: SFTableViewCell {
//    // MARK: var
//    var iconImgView: SFImageView = {
//        return SFImageView().then { view in
//            view.contentMode = .scaleAspectFit
//        }
//    }()
//    var titleLabel: SFLabel = {
//        return SFLabel().then { view in
//            
//        }
//    }()
//    
//    // MARK: life cycle
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        customUI()
//    }
//    
//    // MARK: ui
//    /// 自定义约束
//    private func customUI() {
//        addSubview(iconImgView)
//        addSubview(titleLabel)
//        iconImgView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(5)
//            make.leading.equalToSuperview().offset(10)
//            make.bottom.equalToSuperview().offset(-5)
//            make.size.equalTo(CGSize(width: 40, height: 40))
//        }
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(10)
//            make.leading.equalTo(iconImgView.snp.trailing).offset(10)
//            make.bottom.equalToSuperview().offset(-10)
//            make.trailing.equalToSuperview().offset(-10)
//        }
//    }
//}
//
