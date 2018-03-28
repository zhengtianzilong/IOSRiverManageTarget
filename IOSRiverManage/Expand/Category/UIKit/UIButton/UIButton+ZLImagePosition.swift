//
//  UIButton+ZLImagePosition.swift
//  IOSRiverManage
//
//  Created by 蔡紫龙 on 2017/9/14.
//  Copyright © 2017年 caizilong. All rights reserved.
//

import UIKit


extension UIButton{
    enum ZLImagePosition {
        case ZLImagePositionLeft
        case ZLImagePositionRight
        case ZLImagePositionTop
        case ZLImagePositionBottom
    }
    
    func setImagePosition(position:ZLImagePosition,spacing:CGFloat){
        
        self.setTitle(currentTitle, for: .normal)
        self.setImage(currentImage, for: .normal)
        
        if let imageWidth = imageView?.image?.size.width,
            let imageHeight = imageView?.image?.size.height,
             let labelTitle:NSString = titleLabel?.text as NSString?
        {
            
            let labelSize = labelTitle.size(attributes: [NSFontAttributeName : titleLabel?.font as Any])
            let labelHeight = labelSize.height
            let labelWidth = labelSize.width
            
            let imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;//image中心移动的x距离
            let imageOffsetY = imageHeight / 2 + spacing / 2;//image中心移动的y距离
            let labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;//label中心移动的x距离
            let labelOffsetY = labelHeight / 2 + spacing / 2;//label中心移动的y距离
            
            let tempWidth = max(labelWidth, imageWidth);
            let changedWidth = labelWidth + imageWidth - tempWidth;
            let tempHeight = max(labelHeight, imageHeight);
            let changedHeight = labelHeight + imageHeight + spacing - tempHeight;

            switch position {
            case .ZLImagePositionLeft:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
                self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            case .ZLImagePositionRight:
                self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + spacing/2, 0, -(labelWidth + spacing/2));
                self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + spacing/2), 0, imageWidth + spacing/2);
                self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
                break;
                
            case .ZLImagePositionTop:
                self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
                self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
                self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
                break;
                
            case .ZLImagePositionBottom:
                self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
                self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
                self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
                break;
                
            }

        }
      
        
        
    }
    
    
}
