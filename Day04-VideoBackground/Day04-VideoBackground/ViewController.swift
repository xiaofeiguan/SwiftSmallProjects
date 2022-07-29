//
//  ViewController.swift
//  Day04-VideoBackground
//
//  Created by 刘观华 on 2022/7/29.
//

import UIKit

class ViewController: VideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoBackground()
    }

    
    func setupVideoBackground(){
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        contentURL = url
    }

}

