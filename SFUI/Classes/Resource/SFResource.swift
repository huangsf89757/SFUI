//
//  SFResource.swift
//  SFUI
//
//  Created by hsf on 2024/7/24.
//

import Foundation

/*
 ⚠️注意

 具体的做法推荐：
 1）在image.xcasset中，全选所有，拷贝到你主工程中
 2）将图片替换为合适的图片
 3）在AppDelegate中设置 SFResource.imageBundle=nil 默认读取Bundle.main中的图片资源
 
 Color和Font同理

 这样，SFResource中所有的图片、颜色和字体等资源就都动态的替换成了主工程的资源
 
 
 */

public final class SFResource {
    public static var imageBundle: Bundle? = Bundle.sf.bundle(cls: SFResource.self, resource: nil)
    public static var colorBundle: Bundle? = Bundle.sf.bundle(cls: SFResource.self, resource: nil)
    public static var fontBundle: Bundle? = Bundle.sf.bundle(cls: SFResource.self, resource: nil)
}
