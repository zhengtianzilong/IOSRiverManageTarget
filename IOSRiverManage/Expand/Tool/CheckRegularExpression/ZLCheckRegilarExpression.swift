//
//  ZLCheckRegilarExpression.swift
//  AIProduct
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

 public class ZLCheckRegilarExpression: NSObject {

    override init() {
        super.init()
    }
    
   public static func checkTelNumber(tel:String) -> Bool {
        
        let pattern = "^1+[3578]+\\d{9}"
    
        let pred = NSPredicate.init(format: "SELF MATCHES%@",pattern )
        pred.evaluate(with: tel)
    
        let isMatch = pred.evaluate(with: tel);
        return isMatch;

    }
    
   public static func checkPassword(password:String) -> Bool {
        
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
        let pred = NSPredicate.init(format: "SELF MATCHES%@",pattern )
        let isMatch = pred.evaluate(with: password)
        return isMatch;

        
    }
    
    static func checkUserIdCard(userIdCard:String) -> Bool {
        
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate.init(format: "SELF MATCHES%@",pattern )
        let isMatch = pred.evaluate(with: userIdCard)
        return isMatch;
        
        
    }
    
    static func checkUserName(userName:String) -> Bool {
        
        let pattern = "^[a-zA-Z\\u4E00-\\u9FA5]{1,20}";
        let pred = NSPredicate.init(format: "SELF MATCHES%@",pattern )
        let isMatch = pred.evaluate(with: userName)
        return isMatch;
        
        
    }
    
}
