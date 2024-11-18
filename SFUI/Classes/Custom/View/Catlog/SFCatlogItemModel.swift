//
//  SFCatlogItemModel.swift
//  SFUI
//
//  Created by hsf on 2024/7/23.
//

import Foundation


// MARK: - SFCatlogItemType
public enum SFCatlogItemType {
    case folder
    case file
    
    var icon: UIImage? {
        switch self {
        case .folder:
            return SFImage.Doc.folder
        case .file:
            return SFImage.Doc.file
        }
    }
}

// MARK: - SFCatlogItemModel
public struct SFCatlogItemModel {
    public var type: SFCatlogItemType = .folder
    public var name: String?
    public init(type: SFCatlogItemType, name: String? = nil) {
        self.type = type
        self.name = name
    }
}
