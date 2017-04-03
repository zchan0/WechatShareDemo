//
//  ViewController.swift
//  WechatShare
//
//  Created by Cencen Zheng on 4/3/17.
//  Copyright © 2017 Cencen Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareText(_ sender: UIButton) {
        ShareManager.shared.sendText(textLabel.text!, inScene: WXSceneSession)
    }
    
    @IBAction func shareImage(_ sender: UIButton) {
        if let imageData = UIImagePNGRepresentation(imageView.image!) {
            ShareManager.shared.sendImage(imageData, inScene: WXSceneTimeline)
        }
    }
    
    @IBAction func shareLink(_ sender: UIButton) {
        let url = "https://httpbin.org/get"
        ShareManager.shared.sendLink(url, textLabel.text!, inScene: WXSceneSession)
    }
    
}
