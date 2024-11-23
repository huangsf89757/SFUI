//
//  SFColor.UI.swift
//  Pods
//
//  Created by hsf on 2024/7/19.
//

import Foundation
import UIKit
// Basic
import SFExtension
import SFBase


// MARK: - SFColor
/*
 APP 配色方案

 主题色: theme ｜ 浅色：#70BD65 (绿色) ｜ 深色：#4CAF50 (深绿色)
 代表生机与自然，适合用于强调积极的品牌形象和用户体验。

 标题颜色: title ｜ 浅色：#2A2A2A (深黑色) ｜ 深色：#FFFFFF (白色)
 清晰且易于阅读，适合用于主要标题，确保信息传达的有效性。

 副标题颜色: subtitle ｜ 浅色：#616161 (中灰色) ｜ 深色：#B0B0B0 (浅灰色)
 用于次要信息，提供视觉层次感，不会干扰主要内容。

 文本详情颜色: detail ｜ 浅色：#363636 (深灰色) ｜ 深色：#E0E0E0 (较浅灰色)
 适合用于正文文本，提供良好的可读性和舒适的视觉体验。

 背景色: background ｜ 浅色：#FFFFFF (浅灰色) ｜ 深色：#121212 (深灰色)
 作为整体背景色，营造干净、简约的界面，增强内容的可读性。

 内容背景色: content ｜ 浅色：#F4F4F4 (白色) ｜ 深色：#1E1E1E (稍浅的深灰色)
 用于卡片或模块背景，提供清晰的分隔效果。

 分割线颜色: divider ｜ 浅色：#DEDEDE (浅灰色) ｜ 深色：#333333 (中灰色)
 用于分隔不同内容区域，保持界面整洁。

 占位文本颜色: placeholder ｜ 浅色：#DCDCDC (浅灰色) ｜ 深色：#7A7A7A (灰色)
 用于输入框的占位符，提供提示信息而不干扰用户输入。

 禁用颜色: disabled ｜ 浅色：#EFF3F8 (浅灰色) ｜ 深色：#3A3A3A (深灰色)
 用于表示不可操作的元素，帮助用户识别功能限制。

 警告色: warning ｜ 浅色：#FFA500 (橙色) ｜ 深色：#FFA500 (橙色)
 用于提示用户注意的重要信息或警告，具有较强的视觉冲击力。

 成功色: success ｜ 浅色：#00CC66 (绿色) ｜ 深色：#00CC66 (绿色)
 表示成功的反馈信息，如表单提交成功，传达积极的情绪。

 错误色: error ｜ 浅色：#DC3545 (红色) ｜ 深色：#DC3545 (红色)
 用于表示错误或警示信息，具有强烈的警示作用。

 链接色: link ｜ 浅色：#0066CC (蓝色) ｜ 深色：#66B2FF (亮蓝色)
 用于超链接或可点击按钮，帮助用户快速识别可交互元素。

 辅助色: auxiliary ｜ 浅色：#6C757D (中灰色) ｜ 深色：#A6A6A6 (中灰色)
 用于辅助信息或次要元素，保持整体视觉的和谐。

 高亮色: highlight ｜ 浅色：#FFC107 (琥珀色) ｜ 深色：#FFC107 (琥珀色)

 浅灰色: lightGray ｜ 浅色：#F2F2F2 (更浅的浅灰色) ｜ 深色：#B0B0B0 (浅灰色)
 用于提供额外的视觉层次，适合用于背景或次要信息。
 
 灰色: gray ｜ 浅色：#A9A9A9 (灰色) ｜ 深色：#888888 (偏黑的灰色)
 用于强调内容或作为背景色的一部分，提供中等的对比度。
 
 深灰色: darkGray ｜ 浅色：#4B4B4B (深灰色) ｜ 深色：#444444 (偏黑的深灰色)
 用于强调内容或作为背景色的一部分，提供更深的对比度。

 白色: white ｜ 浅色：#FFFFFF (白色) ｜ 深色：#000000 (黑色)

 白色(always): whiteAlways ｜ 浅色：#FFFFFF (白色) ｜ 深色：#FFFFFF (白色)

 黑色: black ｜ 浅色：#000000 (黑色) ｜ 深色：#FFFFFF (白色)

 黑色(always): blackAlways ｜ 浅色：#000000 (黑色) ｜ 深色：#000000 (黑色)

 */


extension SFColor {
    public struct UI {
        public static var bundle = SFLibUI.bundle
        private static func color(name: String) -> UIColor? {
            UIColor.sf.color(name: name, bundle: Self.bundle)
        }
        
        /// 主题色: theme ｜ 浅色：#70BD65 (绿色) ｜ 深色：#4CAF50 (深绿色)
        /// 代表生机与自然，适合用于强调积极的品牌形象和用户体验。
        public static var theme: UIColor? { color(name: "theme") }
        
        /// 标题颜色: title ｜ 浅色：#2A2A2A (深黑色) ｜ 深色：#FFFFFF (白色)
        /// 清晰且易于阅读，适合用于主要标题，确保信息传达的有效性。
        public static var title: UIColor? { color(name: "title") }
        
        /// 副标题颜色: subtitle ｜ 浅色：#616161 (中灰色) ｜ 深色：#B0B0B0 (浅灰色)
        /// 用于次要信息，提供视觉层次感，不会干扰主要内容。
        public static var subtitle: UIColor? { color(name: "subtitle") }
        
        /// 文本详情颜色: detail ｜ 浅色：#363636 (深灰色) ｜ 深色：#E0E0E0 (较浅灰色)
        /// 适合用于正文文本，提供良好的可读性和舒适的视觉体验。
        public static var detail: UIColor? { color(name: "detail") }
        
        /// 背景色: background ｜ 浅色：#F4F4F4 (浅灰色) ｜ 深色：#121212 (深灰色)
        /// 作为整体背景色，营造干净、简约的界面，增强内容的可读性。
        public static var background: UIColor? { color(name: "background") }
        
        /// 内容背景色: content ｜ 浅色：#FFFFFF (白色) ｜ 深色：#1E1E1E (稍浅的深灰色)
        /// 用于卡片或模块背景，提供清晰的分隔效果。
        public static var content: UIColor? { color(name: "content") }
        
        /// 分割线颜色: divider ｜ 浅色：#DEDEDE (浅灰色) ｜ 深色：#333333 (中灰色)
        /// 用于分隔不同内容区域，保持界面整洁。
        public static var divider: UIColor? { color(name: "divider") }
        
        /// 占位文本颜色: placeholder ｜ 浅色：#B0B0B0 (浅灰色) ｜ 深色：#7A7A7A (灰色)
        /// 用于输入框的占位符，提供提示信息而不干扰用户输入。
        public static var placeholder: UIColor? { color(name: "placeholder") }
        
        /// 禁用颜色: disabled ｜ 浅色：#EFF3F8 (浅灰色) ｜ 深色：#3A3A3A (深灰色)
        /// 用于表示不可操作的元素，帮助用户识别功能限制。
        public static var disabled: UIColor? { color(name: "disabled") }
        
        /// 警告色: warning ｜ 浅色：#FFA500 (橙色) ｜ 深色：#FFA500 (橙色)
        /// 用于提示用户注意的重要信息或警告，具有较强的视觉冲击力。
        public static var warning: UIColor? { color(name: "warning") }
        
        /// 成功色: success ｜ 浅色：#00CC66 (绿色) ｜ 深色：#00CC66 (绿色)
        /// 表示成功的反馈信息，如表单提交成功，传达积极的情绪。
        public static var success: UIColor? { color(name: "success") }
        
        /// 错误色: error ｜ 浅色：#DC3545 (红色) ｜ 深色：#DC3545 (红色)
        /// 用于表示错误或警示信息，具有强烈的警示作用。
        public static var error: UIColor? { color(name: "error") }
        
        /// 链接色: link ｜ 浅色：#0066CC (蓝色) ｜ 深色：#66B2FF (亮蓝色)
        /// 用于超链接或可点击按钮，帮助用户快速识别可交互元素。
        public static var link: UIColor? { color(name: "link") }
        
        /// 辅助色: auxiliary ｜ 浅色：#6C757D (中灰色) ｜ 深色：#A6A6A6 (中灰色)
        /// 用于辅助信息或次要元素，保持整体视觉的和谐。
        public static var auxiliary: UIColor? { color(name: "auxiliary") }
        
        /// 高亮色: highlight ｜ 浅色：#FFC107 (琥珀色) ｜ 深色：#FFC107 (琥珀色)
        /// 用于高亮显示某些元素，吸引用户的注意力。
        public static var highlight: UIColor? { color(name: "highlight") }
        
        /// 浅灰色: lightGray ｜ 浅色：#F2F2F2 (更浅的浅灰色) ｜ 深色：#E0E0E0 (较浅灰色)
        public static var lightGray: UIColor? { color(name: "lightGray") }
        
        /// 灰色: gray ｜ 浅色：#A9A9A9 (灰色) ｜ 深色：#7A7A7A (深灰色)
        public static var gray: UIColor? { color(name: "gray") }
        
        /// 深灰色: darkGray ｜ 浅色：#4B4B4B (深灰色) ｜ 深色：#333333 (中灰色)
        public static var darkGray: UIColor? { color(name: "darkGray") }
        
        /// 白色: white ｜ 浅色：#FFFFFF (白色) ｜ 深色：#000000 (黑色)
        public static var white: UIColor? { color(name: "white") }
        
        /// 白色(always): whiteAlways ｜ 浅色：#FFFFFF (白色) ｜ 深色：#FFFFFF (白色)
        public static var whiteAlways: UIColor? { color(name: "whiteAlways") }
        
        /// 黑色: black ｜ 浅色：#000000 (黑色) ｜ 深色：#FFFFFF (白色)
        public static var black: UIColor? { color(name: "black") }
        
        /// 黑色(always): blackAlways ｜ 浅色：#000000 (黑色) ｜ 深色：#000000 (黑色)
        public static var blackAlways: UIColor? { color(name: "blackAlways") }
    }
}


