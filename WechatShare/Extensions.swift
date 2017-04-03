//
//  Extensions.swift
//  WechatShare
//
//  Created by Cencen Zheng on 4/3/17.
//  Copyright © 2017 Cencen Zheng. All rights reserved.
//

import Foundation

extension WXMediaMessage {
    
    /// Build WXMediaMessage
    ///
    /// - Parameters:
    ///   - title: < 512B
    ///   - description: < 1k
    ///   - mediaObject: can be WXImageObject，WXMusicObject，WXVideoObject，WXWebpageObject, etc.
    ///   - ext:
    ///   - action:
    ///   - thumbImage: < 32k
    ///   - tagName: < 64B
    class func message(_ title: String?, _ description: String?, _ mediaObject: Any, _ messageExt: String? = nil, _ messageAction: String? = nil, _ thumbImage: UIImage? = nil, _ tagName: String? = nil) -> WXMediaMessage {
        let message = WXMediaMessage()
        message.title = title
        message.description = description
        message.mediaObject = mediaObject
        message.messageExt  = messageExt
        message.messageAction = messageAction
        message.mediaTagName  = tagName
        message.setThumbImage(thumbImage)
        return message
    }
}

extension SendMessageToWXReq {
    
    /// Send request with text-only message or multimedia message
    ///
    /// - Parameters:
    ///   - text: text content, < 10k
    ///   - message: multimedia message
    ///   - bText: true -> sharing text-only message; false -> sharing multimedia message
    ///   - scene: default value is WXSceneSession
    class func request(_ text: String?, _ message: WXMediaMessage?, _ bText: Bool, inScene scene: WXScene) -> SendMessageToWXReq {
        let request = SendMessageToWXReq()
        request.bText = bText
        request.scene = Int32(scene.rawValue)
        if bText {
            request.text = text
        } else {
            request.message = message
        }
        return request
    }
}
