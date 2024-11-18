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
// TODO: 使用SF Symbles替换

public typealias SFImage = SFResource.Image

extension SFResource {
    public struct Image {
        public static var close: UIImage? = UIImage.sf.image(name: "close", cls: cls)
        public static var back: UIImage? = UIImage.sf.image(name: "back", cls: cls)
        public struct Doc {
            public static var folder: UIImage? = UIImage.sf.image(name: "doc/folder", cls: cls)
            public static var file: UIImage? = UIImage.sf.image(name: "doc/file", cls: cls)
        }
        public struct Arrow {
            public static var top: UIImage? = UIImage.sf.image(name: "arrow/top", cls: cls)
            public static var left: UIImage? = UIImage.sf.image(name: "arrow/left", cls: cls)
            public static var right: UIImage? = UIImage.sf.image(name: "arrow/right", cls: cls)
            public static var bottom: UIImage? = UIImage.sf.image(name: "arrow/bottom", cls: cls)
        }
        public struct Triangle {
            public static var top: UIImage? = UIImage.sf.image(name: "triangle/top", cls: cls)
            public static var left: UIImage? = UIImage.sf.image(name: "triangle/left", cls: cls)
            public static var right: UIImage? = UIImage.sf.image(name: "triangle/right", cls: cls)
            public static var bottom: UIImage? = UIImage.sf.image(name: "triangle/bottom", cls: cls)
        }
        public struct Hud {
            public static var loading: UIImage? = UIImage.sf.image(name: "hud/loading", cls: cls)
            public static var success: UIImage? = UIImage.sf.image(name: "hud/success", cls: cls)
            public static var failure: UIImage? = UIImage.sf.image(name: "hud/failure", cls: cls)
            public static var info: UIImage? = UIImage.sf.image(name: "hud/info", cls: cls)
            public static var ban: UIImage? = UIImage.sf.image(name: "hud/ban", cls: cls)
            public static var ask: UIImage? = UIImage.sf.image(name: "hud/ask", cls: cls)
        }
    }
}

