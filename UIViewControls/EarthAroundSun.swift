//
//  DemoNSTimer.swift
//  UIViewControls
//
//  Created by Trinh Minh Cuong on 9/26/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class EarthAroundSun: UIViewController {
    var timer: NSTimer?
    
    var x0: Double = 0.0  //Toạ độ mặt trời
    var y0: Double = 0.0
    var radius: Double = 0.0
    var angle: Double = 0.0
    var earth: UIImageView?
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.blackColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        let sun = UIImageView(image: UIImage(named: "sun.png"))
        let boundSize = self.view.bounds.size
        x0 = Double(boundSize.width) * 0.5
        y0 = Double(boundSize.height - 60) * 0.5
        radius = Double(x0) - 20.0
        sun.center = CGPoint(x: x0, y: y0)
        sun.bounds = CGRect(x: 0, y: 0, width: 48, height: 48)
        self.view.addSubview(sun)
  
        earth = UIImageView(image: UIImage(named: "earth.png"))
        earth?.center = computePos(angle)
        self.view.addSubview(earth!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
       /* timer = NSTimer(timeInterval: 0.1, target: self, selector: Selector("timingFunction:"), userInfo: ["data": "OX-13"], repeats: true)*/
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "timingFunction:", userInfo: ["data": "OX-13"], repeats: true)
        timer?.fire()
    }
    
    func timingFunction(timer: NSTimer) {
        /*if let userInfo : AnyObject = timer.userInfo? {
            if let message: AnyObject? = userInfo["data"] {
                println("test \(message!)")
            }
        }*/
        earth?.center = computePos(angle)
        angle += 0.1
        
    }
    //Tính toạ độ của trái đất theo góc truyền vào
    func computePos(alpha: Double) -> CGPoint {
        println("\(alpha)")
        return CGPoint (x: Double(x0) + radius * cos(alpha),
            y: Double(y0) + radius * sin(alpha))
 
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
   
}
