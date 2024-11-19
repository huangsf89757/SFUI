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

// MARK: - SFImage
extension SFImage {
    public struct UI {
        public static var bundle = SFLibUI.bundle
        private static func image(name: String) -> UIImage? {
            UIImage.sf.image(name: "close", bundle: Self.bundle)
        }
        
        public static var close: UIImage? = image(name: "close")
        public static var back: UIImage? = image(name: "back")
        public struct Doc {
            public static var folder: UIImage? = image(name: "doc/folder")
            public static var file: UIImage? = image(name: "doc/file")
        }
        public struct Arrow {
            public static var top: UIImage? = image(name: "arrow/top")
            public static var left: UIImage? = image(name: "arrow/left")
            public static var right: UIImage? = image(name: "arrow/right")
            public static var bottom: UIImage? = image(name: "arrow/bottom")
        }
        public struct Triangle {
            public static var top: UIImage? = image(name: "triangle/top")
            public static var left: UIImage? = image(name: "triangle/left")
            public static var right: UIImage? = image(name: "triangle/right")
            public static var bottom: UIImage? = image(name: "triangle/bottom")
        }
        public struct Hud {
            public static var loading: UIImage? = image(name: "hud/loading")
            public static var success: UIImage? = image(name: "hud/success")
            public static var failure: UIImage? = image(name: "hud/failure")
            public static var info: UIImage? = image(name: "hud/info")
            public static var warning: UIImage? = image(name: "hud/warning")
            public static var error: UIImage? = image(name: "hud/error")
        }
    }
}

