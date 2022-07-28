//
//  ViewController.swift
//  Day01-SimpleStopWatch
//
//  Created by 刘观华 on 2022/7/28.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    var timer:Timer? = Timer()
    var isPlaying = false
    var num:Float = 0.0{
        // 属性观察器 监听
        didSet{
            numLabel.text = String(format: "%.1f", num)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        num = 0.0
    }
    
    
    @IBAction func resetBtnAction(_ sender: UIButton) {
        if let timeTemp = timer{
            timeTemp.invalidate()
        }
        num = 0.0;
        timer = nil
        isPlaying = false
        num = 0.0
        playBtn.isEnabled = true
        pauseBtn.isEnabled = true
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        // 调用实例的方法时建议用self.UpdateTimer,
        // 不建议使用ViewController.UpdateTimer
        // 因为若方法定义成了类方法，第二种方式编译器不会报错。
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
/**
 *
 */
    @IBAction func pause(_ sender: UIButton) {
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        
        if let timeTemp = timer{
            timeTemp.invalidate()
        }
        timer = nil
        isPlaying = false
    }
    
    @objc func updateTimer(){
        num = num+0.1
    }
    
}

