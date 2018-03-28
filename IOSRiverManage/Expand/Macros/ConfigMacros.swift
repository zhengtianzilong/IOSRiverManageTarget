//
//  ConfigMacros.swift
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/14.
//  Copyright © 2017年 caizilong. All rights reserved.
//

import UIKit

// App Frame Height&Width
let App_Frame_Height = UIScreen.main.applicationFrame.size.height
let App_Frame_Width = UIScreen.main.applicationFrame.size.width

//不同屏幕尺寸字体适配（320，568是因为效果图为IPHONE5 如果不是则根据实际情况修改）

let kScreenWidthRatio = (App_Frame_Width / 375.0)
let kScreenHeightRatio = (App_Frame_Height / 667.0)


// 适配不同尺寸手机,除以2是因为px和pt的区别
func AdaptedWidth(width:CGFloat) -> CGFloat{
    return CGFloat(ceilf(Float((width)/720.0 * kScreenWidthRatio * App_Frame_Width)))
}
func AdaptedHeight(height:CGFloat) -> CGFloat{
    return CGFloat(ceilf(Float((height)/1280.0 * kScreenHeightRatio * App_Frame_Height)))
}



/// 字体适应
func AdaptedPSToFont(fontSize:CGFloat) -> UIFont {
    
    return UIFont(name: "Heiti SC", size: CGFloat(ceilf(Float((fontSize)/96.0 * 72))))!
    
    
}


/// 粗体字适应
func AdaptedPSToFontBold(fontSize:CGFloat) -> UIFont {
    
    return UIFont(name: "Helvetica-Bold", size: CGFloat(ceilf(Float((fontSize)/96.0 * 72))))!
}



extension UIColor {
    class func colorWithHexString(hex:String , alpha:CGFloat) ->UIColor {
        
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = cString.substring(from: index)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.substring(to: rIndex)
        let otherString = cString.substring(from: rIndex)
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = otherString.substring(to: gIndex)
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
}








