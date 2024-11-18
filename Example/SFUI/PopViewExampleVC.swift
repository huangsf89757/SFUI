////
////  PopViewExampleVC.swift
////  SFUI_Example
////
////  Created by hsf on 2024/7/25.
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
//class PopViewExampleVC: SFViewController {
//    private lazy var popView: PopView = {
//        return PopView().then { view in
//            view.backgroundColor = .red
//            view.layer.cornerRadius = 100
//            view.showCompletionBlock = {
//                popView in
//                print("showCompletionBlock")
//            }
//            view.dismissCompletionBlock = {
//                popView in
//                print("dismissCompletionBlock")
//            }
//        }
//    }()
//    private lazy var popView1: PopView1 = {
//        return PopView1().then { view in
//            view.backgroundColor = .red
//            view.layer.cornerRadius = 100
//        }
//    }()
//    private lazy var popView2: PopView2 = {
//        return PopView2().then { view in
//            view.backgroundColor = .red
//            view.layer.cornerRadius = 100
//        }
//    }()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.title = "PopViewExampleVC"
//        
//        let identifier = UUID().uuidString
////        popView.identifier = identifier
////        popView1.identifier = identifier
////        popView2.identifier = identifier
//        
//        SFAlert.addCustomAction(style: .block, title: "自定义1")
//        SFAlert.addCustomAction(style: .block, title: "自定义2")
//        SFAlert.addCustomAction(style: .block, title: "自定义3")
//        
//        let btn = SFButton().then { view in
//            view.backgroundColor = .black
//            view.setTitle("CLICK ME", for: .normal)
//            view.addTarget(self, action: #selector(clickMe), for: .touchUpInside)
//        }
//        view.addSubview(btn)
//        btn.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(100)
//            make.bottom.equalToSuperview()
//        }
//    }
//    
//    @objc private func clickMe() {
//        
//        SFNotify.show(icon: nil, title: "通知", msg: "您有一条未读消息。")
//       
////        SFAlert.addCancelAction(title: "取消", action: { popView in
////            print("点击【取消】")
////            return true
////        })
////        SFAlert.addSureAction(title: "确定", action: { popView in
////            print("点击【确定】")
////            return true
////        }) 
////        SFAlert.show(alertStyle: .sheet, headerStyle: .leading, title: "标题", offset: 0)
////        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////            SFAlert.show(alertStyle: .sheet, headerStyle: .leading, msg: "副标题", offset: 0)
////            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                SFAlert.show(alertStyle: .sheet, headerStyle: .leading, actionStyle: .block, footerStyle: .spacing, title: "标题", msg: "副标题", offset: 0)
////                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                    SFAlert.show(alertStyle: .sheet, headerStyle: .leading, actionStyle: .border, footerStyle: .spacing, title: "标题", msg: "副标题", offset: 0)
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                        SFAlert.show(alertStyle: .sheet, headerStyle: .leading, actionStyle: .border, footerStyle: .edging, title: "标题", msg: "副标题", offset: 0)
////                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                            SFAlert.show(alertStyle: .sheet, headerStyle: .leading, actionStyle: .border, footerStyle: .edging, title: "标题", msg: "副标题", offset: 0)
////                        }
////                    }
////                }
////            }
////        }
//       
//        
//        
////        SFHud.show(.loading, msg: "加载中") { popView in
////            popView.dismiss()
////        }
////        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
////            SFHud.show(.success, msg: "加载成功")
////            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                SFHud.show(.failure, msg: "加载失败")
////                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                    SFHud.show(.info, msg: "信息提示")
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                        SFHud.show(.ban, msg: "信息提示")
////                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////                            SFHud.show(.ask, msg: "信息提示")
////                        }
////                    }
////                }
////            }
////        }
//        
//        
////        SFToast.show("00000000", at: .top(offset: 100))
////        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////            SFToast.show("aaaaaaaaaaaaa", at: .center(offset: 0))
////            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                SFToast.show("bbbbbbbbb", at: .bottom(offset: 100))
////            }
////        }
//        
//        
//        
////        popView.show(delayDismiss: (delay: 2, dismissAnimation: (dir: .trailing, offset: 150, duration: 0.5)))
////        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////            self.popView1.show()
////            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                self.popView2.show()
////                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                    SFPopManager.shared.bringToFront(identifier: self.popView.identifier)
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                        SFPopManager.shared.sendToBack(identifier: self.popView.identifier)
////                    }
////                }
////            }
////        }
//    }
//}
//
//class PopView: SFPopView {
//    override func customLayout() {
//        self.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(200)
//        }
//    }
//}
//
//class PopView1: SFPopView {
//    override func customLayout() {
//        self.snp.makeConstraints { make in
//            make.center.equalToSuperview().offset(50)
//            make.width.equalTo(200)
//            make.height.equalTo(200)
//        }
//    }
//}
//class PopView2: SFPopView {
//    override func customLayout() {
//        self.snp.makeConstraints { make in
//            make.center.equalToSuperview().offset(100)
//            make.width.equalTo(200)
//            make.height.equalTo(200)
//        }
//    }
//}
