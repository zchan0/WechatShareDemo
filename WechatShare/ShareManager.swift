//
//  ShareManager.swift
//  WechatShare
//
//  Created by Cencen Zheng on 4/3/17.
//  Copyright © 2017 Cencen Zheng. All rights reserved.
//


class ShareManager {
    
    private init() {}
    
    static let shared: ShareManager = ShareManager()
    
    @discardableResult
    func sendLink(_ linkUrl: String, _ title: String, _ description: String? = nil, inScene scene: WXScene, _ thumbImage: UIImage? = nil, _ tagName: String? = nil) -> Bool {
        let ext = WXWebpageObject()
        ext.webpageUrl = linkUrl
        
        let message = WXMediaMessage.message(title, description, ext, nil, nil, thumbImage, tagName)
        let request = SendMessageToWXReq.request(nil, message, false, inScene: scene)
        
        return WXApi.send(request)
    }
    
    @discardableResult
    func sendImage(_ imageData: Data, inScene scene: WXScene, _ messageExt: String? = nil, _ action: String? = nil, _ thumbImage: UIImage? = nil, _ tagName: String? = nil) -> Bool {
        let ext = WXImageObject()
        ext.imageData = imageData
        
        let message = WXMediaMessage.message(nil, nil, ext, messageExt, action, thumbImage, tagName)
        let request = SendMessageToWXReq.request(nil, message, false, inScene: scene)
        
        return WXApi.send(request)
    }
    
    @discardableResult
    func sendText(_ text: String, inScene scene: WXScene) -> Bool {
        let request = SendMessageToWXReq.request(text, nil, true, inScene: scene)
        
        return WXApi.send(request)
    }
}
