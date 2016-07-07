//
//  OAuthViewController.swift
//  WMJWeiBo
//
//  Created by lumf on 16/7/7.
//  Copyright © 2016年 WMJ. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    @IBOutlet weak var customView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(WB_App_Key)&redirect_uri=\(WB_Redirect_URL)") else{
            return
        }
        customView.loadRequest(NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 15))
    }

  
}

extension OAuthViewController:UIWebViewDelegate{
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //1、https://api.weibo.com/oauth2/authorize?client_id=132234267&redirect_uri=https://www.baidu.com
        //2、https://api.weibo.com/oauth2/authorize
        //3、https://api.weibo.com/oauth2/authorize#
        //4、https://www.baidu.com/?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
        
        //https://www.baidu.com/?code=6e1d615898e57c0ec6e662ff57cca571
//        WMJLog(request.URL?.absoluteString)
        
        guard let urlStr = request.URL?.absoluteString else{
            return false
        }
        
        if !urlStr.hasPrefix(WB_Redirect_URL) {
            return true
        }
        
        let key = "code="
        
        guard let str=request.URL?.query else{
            return false
        }
        
        if str.hasPrefix(key) {
            let code = str.substringFromIndex(key.endIndex)
            
            loadAccessToken(code)
            
            return false
        }
        
        return true
    }
    
    private func loadAccessToken(code:String){
        let urlStr = "oauth2/access_token"
        let params = ["client_id":WB_App_Key,"client_secret":WB_App_Secret,"grant_type":"authorization_code","code":code,"redirect_uri":WB_Redirect_URL]
        NetworkTools.shareInstance.POST(urlStr, parameters: params, success: { (task:NSURLSessionDataTask, objc:AnyObject?) -> Void in
//            Optional({
//                "access_token" = "2.00pPasgF0lKqwI0986964e1dHKsI3D";
//                "expires_in" = 157679999;
//                "remind_in" = 157679999;
//                uid = 5214279349;
//            })
            let account = UserAccount(dict: objc as! [String:AnyObject])
            WMJLog(account.saveAccount())
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                
        }
    }
}
