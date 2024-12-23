//
//  SFImage.swift
//  SFUI
//
//  Created by hsf on 2024/7/23.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase

// MARK: - SFImage
extension SFImage {
    public struct App {
        public static var icon: UIImage?
        public static var logo: UIImage?
    }
    
    public struct UI {
        public static var bundle = SFUILib.bundle
        private static func image(name: String) -> UIImage? {
            UIImage.sf.image(name: name, bundle: Self.bundle)
        }
        
        public struct Com {
            public static var add: UIImage? { image(name: "com/add") }
            public static var close: UIImage? { image(name: "com/close") }
            public static var back: UIImage? { image(name: "com/back") }
            public static var detail: UIImage? { image(name: "com/detail") }
            public static var search: UIImage? { image(name: "com/search") }
            public static var goto: UIImage? { image(name: "com/goto") }
            public static var tip: UIImage? { image(name: "com/tip") }
            public static var setting: UIImage? { image(name: "com/setting") }
            public static var filter: UIImage? { image(name: "com/filter") }
            public static var edit: UIImage? { image(name: "com/edit") }
            public static var noData: UIImage? { image(name: "com/noData") }
        }
        public struct Doc {
            public static var folder: UIImage? { image(name: "doc/folder") }
            public static var file: UIImage? { image(name: "doc/file") }
        }
        public struct Arrow {
            public static var top: UIImage? { image(name: "arrow/top") }
            public static var left: UIImage? { image(name: "arrow/left") }
            public static var right: UIImage? { image(name: "arrow/right") }
            public static var bottom: UIImage? { image(name: "arrow/bottom") }
        }
        public struct Triangle {
            public static var top: UIImage? { image(name: "triangle/top") }
            public static var left: UIImage? { image(name: "triangle/left") }
            public static var right: UIImage? { image(name: "triangle/right") }
            public static var bottom: UIImage? { image(name: "triangle/bottom") }
        }
        public struct Checkbox {
            public static var nor: UIImage? { image(name: "checkbox/nor") }
            public static var sel: UIImage? { image(name: "checkbox/sel") }
        }
        public struct Select {
            public static var nor: UIImage? { image(name: "select/nor") }
            public static var sel: UIImage? { image(name: "select/sel") }
        }
        public struct Sort {
            public static var asc: UIImage? { image(name: "sort/asc") }
            public static var des: UIImage? { image(name: "sort/des") }
            public static var none: UIImage? { image(name: "sort/none") }
        }
        public struct Hud {
            public static var loading: UIImage? { image(name: "hud/loading") }
            public static var success: UIImage? { image(name: "hud/success") }
            public static var failure: UIImage? { image(name: "hud/failure") }
            public static var info: UIImage? { image(name: "hud/info") }
            public static var warning: UIImage? { image(name: "hud/warning") }
            public static var error: UIImage? { image(name: "hud/error") }
        }
    }
}

