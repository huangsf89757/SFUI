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
        public static var close: UIImage? = UIImage.sf.image(name: "close", bundle: imageBundle)
        public static var back: UIImage? = UIImage.sf.image(name: "back", bundle: imageBundle)
        public struct Doc {
            public static var folder: UIImage? = UIImage.sf.image(name: "doc/folder", bundle: imageBundle)
            public static var file: UIImage? = UIImage.sf.image(name: "doc/file", bundle: imageBundle)
        }
        public struct Arrow {
            public static var top: UIImage? = UIImage.sf.image(name: "arrow/top", bundle: imageBundle)
            public static var left: UIImage? = UIImage.sf.image(name: "arrow/left", bundle: imageBundle)
            public static var right: UIImage? = UIImage.sf.image(name: "arrow/right", bundle: imageBundle)
            public static var bottom: UIImage? = UIImage.sf.image(name: "arrow/bottom", bundle: imageBundle)
        }
        public struct Triangle {
            public static var top: UIImage? = UIImage.sf.image(name: "triangle/top", bundle: imageBundle)
            public static var left: UIImage? = UIImage.sf.image(name: "triangle/left", bundle: imageBundle)
            public static var right: UIImage? = UIImage.sf.image(name: "triangle/right", bundle: imageBundle)
            public static var bottom: UIImage? = UIImage.sf.image(name: "triangle/bottom", bundle: imageBundle)
        }
        public struct Hud {
            public static var loading: UIImage? = UIImage.sf.image(name: "hud/loading", bundle: imageBundle)
            public static var success: UIImage? = UIImage.sf.image(name: "hud/success", bundle: imageBundle)
            public static var failure: UIImage? = UIImage.sf.image(name: "hud/failure", bundle: imageBundle)
            public static var info: UIImage? = UIImage.sf.image(name: "hud/info", bundle: imageBundle)
            public static var ban: UIImage? = UIImage.sf.image(name: "hud/ban", bundle: imageBundle)
            public static var ask: UIImage? = UIImage.sf.image(name: "hud/ask", bundle: imageBundle)
        }
    }
}

