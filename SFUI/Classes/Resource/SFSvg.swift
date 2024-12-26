//
//  SFSvg.swift
//  SFUI
//
//  Created by hsf on 2024/12/26.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase
// Third
import Macaw

extension SFSvg {
    public struct UI {
        public static var bundle = SFUILib.bundle ?? .main
        private static func svg(name: String, directory: String) -> Macaw.Node? {
            let node = try? SVGParser.parse(resource: name, inDirectory: directory, fromBundle: bundle)
            return node
        }
        
        public struct Com {
            private static func svg(name: String) -> Macaw.Node? {
                return UI.svg(name: name, directory: "Com")
            }
//            public static var add: Macaw.Node? { svg(name: "com/add") }
//            public static var close: Macaw.Node? { svg(name: "com/close") }
            public static var back: Macaw.Node? { svg(name: "back") }
//            public static var detail: Macaw.Node? { svg(name: "com/detail") }
//            public static var search: Macaw.Node? { svg(name: "com/search") }
//            public static var goto: Macaw.Node? { svg(name: "com/goto") }
//            public static var tip: Macaw.Node? { svg(name: "com/tip") }
//            public static var setting: Macaw.Node? { svg(name: "com/setting") }
//            public static var filter: Macaw.Node? { svg(name: "com/filter") }
//            public static var edit: Macaw.Node? { svg(name: "com/edit") }
//            public static var noData: Macaw.Node? { svg(name: "com/noData") }
        }
//        public struct Doc {
//            public static var folder: Macaw.Node? { svg(name: "doc/folder") }
//            public static var file: Macaw.Node? { svg(name: "doc/file") }
//        }
//        public struct Arrow {
//            public static var top: Macaw.Node? { svg(name: "arrow/top") }
//            public static var left: Macaw.Node? { svg(name: "arrow/left") }
//            public static var right: Macaw.Node? { svg(name: "arrow/right") }
//            public static var bottom: Macaw.Node? { svg(name: "arrow/bottom") }
//        }
//        public struct Triangle {
//            public static var top: Macaw.Node? { svg(name: "triangle/top") }
//            public static var left: Macaw.Node? { svg(name: "triangle/left") }
//            public static var right: Macaw.Node? { svg(name: "triangle/right") }
//            public static var bottom: Macaw.Node? { svg(name: "triangle/bottom") }
//        }
//        public struct Checkbox {
//            public static var nor: Macaw.Node? { svg(name: "checkbox/nor") }
//            public static var sel: Macaw.Node? { svg(name: "checkbox/sel") }
//        }
//        public struct Select {
//            public static var nor: Macaw.Node? { svg(name: "select/nor") }
//            public static var sel: Macaw.Node? { svg(name: "select/sel") }
//        }
//        public struct Sort {
//            public static var asc: Macaw.Node? { svg(name: "sort/asc") }
//            public static var des: Macaw.Node? { svg(name: "sort/des") }
//            public static var none: Macaw.Node? { svg(name: "sort/none") }
//        }
//        public struct Hud {
//            public static var loading: Macaw.Node? { svg(name: "hud/loading") }
//            public static var success: Macaw.Node? { svg(name: "hud/success") }
//            public static var failure: Macaw.Node? { svg(name: "hud/failure") }
//            public static var info: Macaw.Node? { svg(name: "hud/info") }
//            public static var warning: Macaw.Node? { svg(name: "hud/warning") }
//            public static var error: Macaw.Node? { svg(name: "hud/error") }
//        }
    }
}
