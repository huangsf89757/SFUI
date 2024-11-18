//
//  SFResource.swift
//  SFUI
//
//  Created by hsf on 2024/7/24.
//

import Foundation

/*
 ⚠️注意
 
 SFResource中所有的图片的图片尺寸大多数都是 200*200 、 300*300
 在使用的时候，使用resize的方式，让图片resize到合适的尺寸
 这在性能上会增加额外的图片resize消耗，因此推荐这种做法
 但是为了让图片更加通用，所以设计成这样
 在实际项目中，还是建议使用对应合适的图片尺寸，减少离屏渲染
 
 
 具体的做法推荐：
 1）在image.xcasset中，全选所有，拷贝到你主工程中
 2）将图片替换为合适的图片
 3）在AppDelegate中设置 SFImage.cls=nil 默认读取Bundle.main中的图片资源
 
 Color同理

 这样，SFResource中所有的图片和颜色等资源就都动态的替换成了主工程的资源
 
 
 */

public final class SFResource {
    public static var cls: AnyClass? = SFResource.self
}
