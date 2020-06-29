//
//  ViewController.swift
//  GradientProgressViewExample
//
//  Created by carefree on 2020/6/13.
//  Copyright © 2020 carefree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView1: GradientProgressView!
    @IBOutlet weak var progressView2: GradientProgressView!
    @IBOutlet weak var progressView3: GradientProgressView!
    @IBOutlet weak var progressView4: GradientProgressView!
    
    @IBOutlet weak var tagView: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置圆角
        progressView1.layer.cornerRadius = 5
        progressView2.layer.cornerRadius = 0
        progressView3.layer.cornerRadius = 10
        progressView4.layer.cornerRadius = 4
        
        //设置进度条圆角
        progressView1.progressCornerRadius = 5
        progressView2.progressCornerRadius = 0
        progressView3.progressCornerRadius = 6
        progressView4.progressCornerRadius = 3
        
        //设置内间距
        progressView3.progressEdgeInsets = UIEdgeInsets(top: 4, left: 5, bottom: 4, right: 5)
        progressView4.progressEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        
        //设置纯色和渐变色
        progressView1.progressColors = [.green]
        progressView2.progressColors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
        progressView3.progressColors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
        progressView4.progressColors = [.red]
        
        //动画时间
        progressView1.animationDuration = 1
        progressView2.animationDuration = 0.2
        progressView3.animationDuration = 1.2
        progressView4.animationDuration = 1.8
        
        //动画函数
        progressView1.timingFunction = CAMediaTimingFunction(name: .default)
        progressView2.timingFunction = CAMediaTimingFunction(name: .linear)
        progressView3.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        progressView4.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        //更新回调
        progressView4.progressUpdating = {[unowned self] progress, frame in
            //更新Label的百分比
            let text = String(format: "%.0f", progress * 100)
            self.progressLabel.text = "\(text)%"
            
            //计算出标签的移动位置
            let newFrame = self.progressView4.convert(frame, to: self.self.progressView4.superview)
            let size: CGFloat = 36
            let tagFrame = CGRect(x: (newFrame.origin.x + newFrame.size.width) - size / 2.3, y: newFrame.origin.y - size, width: size, height: size)
            self.tagView.frame = tagFrame
            self.progressLabel.sizeToFit()
            self.progressLabel.center = CGPoint(x: self.tagView.center.x, y: self.tagView.center.y - 7)
        }
        
        //设置标签的初始位置
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let frame = self.progressView4.frame
            let size: CGFloat = 36
            let tagFrame = CGRect(x: frame.origin.x - size / 2.3, y: frame.origin.y - size, width: size, height: size)
            self.tagView.frame = tagFrame
            self.progressLabel.sizeToFit()
            self.progressLabel.center = CGPoint(x: self.tagView.center.x, y: self.tagView.center.y - 7)
            self.progressLabel.text = "0%"
        }
    }
    
    @IBAction func resetAction(_ sender: Any) {
        progressView1.progress = 0
        progressView2.progress = 0
        progressView3.progress = 0
        progressView4.progress = 0
    }
    
    @IBAction func startAction(_ sender: Any) {
        progressView1.setProgress(0.2 + progressView1.progress, animated: true)
        progressView2.setProgress(0.25 + progressView2.progress, animated: true)
        progressView3.setProgress(0.3 + progressView3.progress, animated: true)
        progressView4.setProgress(0.25 + progressView4.progress, animated: true)
    }
    
}

