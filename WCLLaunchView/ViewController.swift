//
//  ViewController.swift
//  WCLLaunchView
//
//  Created by 王崇磊 on 16/8/11.
//  Copyright © 2016年 王崇磊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        let launchView = WCLLaunchView.init(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height), launchImage: UIImage.init(named: "LaunchBackgroundImage"))
        view.addSubview(launchView)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1000) * Int64(NSEC_PER_MSEC)), dispatch_get_main_queue(), {
            launchView.starAnimation()
        })
    }
    
    internal override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

