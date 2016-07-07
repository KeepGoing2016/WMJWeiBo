//
//  UserAccount.swift
//  WMJWeiBo
//
//  Created by lumf on 16/7/7.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class UserAccount: NSObject,NSCoding {
    var access_token:String?
    var expires_in:Int = 0
    var uid:String?
    
    init(dict:[String:AnyObject]) {
        super.init()
        self.setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        let property = ["access_token","expires_in","uid"]
        let dict = dictionaryWithValuesForKeys(property)
        return "\(dict)"
    }
    
    static var account : UserAccount?
    static var filePath:String = "UserAccount.plist".cachesDir()
    
    func saveAccount()->Bool{
        WMJLog(UserAccount.filePath)
       return NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    class func loadAccount()->UserAccount?{
        
        //不为空就直接返回
        if UserAccount.account != nil{
            return UserAccount.account
        }
        
        guard let userData = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? UserAccount else {
            return UserAccount.account
        }
        
        UserAccount.account = userData
        
        return UserAccount.account
    }
    
    class func isLogin()->Bool{
        return UserAccount.loadAccount() != nil
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeInteger(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
    }
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeIntegerForKey("expires_in") as Int
        uid = aDecoder.decodeObjectForKey("uid") as? String
    }
}
