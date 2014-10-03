//
//  Mario.swift
//  UIViewControls
//
//  Created by Trinh Minh Cuong on 9/29/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class Mario: UIViewController {
    var mario: UIImageView?
    var city1, city2, city3, city4, box1, box2 : UIImageView?
    var _timer: NSTimer?
    var viewHeight: Double = 0.0
    var x: CGFloat = 0.0
    var y: Double = 0.0
    var accY: Double = 12
    var moveX = 20
    var jump : Bool = false
    var maxheight : Double = 0.0
    var minheight : Double = 450
    var boxwidth: Double = 40
    var boxheight: Double = 40
    let cityWidth: Double = 1498
    let cityHeight: Double = 400
    var Score : Int = 0
    var ScoreLabel : UILabel = UILabel()
    var endLabel : UILabel = UILabel()
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        let viewSize = self.view.bounds.size
        viewHeight = Double(viewSize.height) - 60
        
        
        city1 = UIImageView(frame: CGRect(x: 0, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city1!.image = UIImage(named: "city1.png")
        self.view.addSubview(city1!)
       /*
        city2 = UIImageView(frame: CGRect(x: cityWidth, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city2!.image = UIImage(named: "city2.png")
        self.view.addSubview(city2!)
        
        city3 = UIImageView(frame: CGRect(x: cityWidth * 2, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city3!.image = UIImage(named: "city3.png")
        self.view.addSubview(city3!) */
        
        city4 = UIImageView(frame: CGRect(x: cityWidth, y: viewHeight - cityHeight, width: cityWidth, height: cityHeight))
        city4!.image = UIImage(named: "city1.png")
        self.view.addSubview(city4!)
        box1 = UIImageView(frame: CGRect(x: Double(viewSize.width - CGFloat(boxwidth))  , y: Double(viewHeight  - boxheight - 10), width: boxwidth, height: boxheight))
        box1!.image = UIImage(named: "box.jpg" )
        self.view.addSubview(box1!)
        box2 = UIImageView(frame: CGRect(x: Double(viewSize.width - CGFloat(boxwidth))  , y: Double(viewHeight  - boxheight - 10), width: boxwidth, height: boxheight))
        box2!.image = UIImage(named: "box2.jpg")
        
        ScoreLabel = UILabel(frame: CGRect(x: viewSize.width - 100, y: 20, width: 80, height: 30))
        self.view.addSubview(ScoreLabel)
        
        endLabel = UILabel(frame: CGRect(x: viewSize.width - 220, y: 40, width: 250, height: 250))
        self.view.addSubview(endLabel)
        
        mario = UIImageView(frame: CGRect(x: 0, y: 0, width: 65, height: 102))
        mario?.center = CGPoint(x: viewSize.width * 0.2, y: CGFloat(viewHeight) - 10 - mario!.bounds.size.height * 0.5)
        mario!.userInteractionEnabled = true
        mario!.multipleTouchEnabled = true
        mario!.animationImages = [
            UIImage(named: "1.png"),
            UIImage(named: "2.png"),
            UIImage(named: "3.png"),
            UIImage(named: "4.png"),
            UIImage(named: "5.png"),
            UIImage(named: "6.png"),
            UIImage(named: "7.png"),
            UIImage(named: "8.png")
        ]
        mario!.animationDuration = 1.0
        self.view.addSubview(mario!)
        mario!.startAnimating()
        maxheight = viewHeight - 10 - Double(mario!.bounds.size.height) * 0.5
        x = viewSize.width * 0.5
        let tap = UITapGestureRecognizer(target: self, action: "tapOnMario")
        self.view.addGestureRecognizer(tap)
        
        self._timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "runCity", userInfo: nil, repeats: true)
        self._timer?.fire()
    }
    
    func runCity() {
        box1!.center = CGPoint(x: box1!.center.x - CGFloat(moveX), y: box1!.center.y)
        if box1!.frame.origin.x + CGFloat(boxwidth) < 0 {
            box1!.frame = CGRect(x: Double(box2!.frame.origin.x) + boxwidth, y: Double(box1!.frame.origin.y), width: boxwidth, height: boxheight)
            Score++
            ScoreLabel.text = "Score: \(Score)"
        }
        if box2!.frame.origin.x + CGFloat(boxwidth) < 0 {
            box2!.frame = CGRect(x: Double(box1!.frame.origin.x) + boxwidth, y: Double(box2!.frame.origin.y), width: boxwidth, height: boxheight)
            Score++
            ScoreLabel.text = "Score: \(Score)"
        }

       // box2!.center = CGPoint(x: box2!.center.x - CGFloat(moveX), y: box2!.center.y)
        city1!.center = CGPoint(x: city1!.center.x - CGFloat(moveX), y: city1!.center.y)
       /* city2!.center = CGPoint(x: city2!.center.x - CGFloat(moveX), y: city2!.center.y)
        city3!.center = CGPoint(x: city3!.center.x - CGFloat(moveX), y: city3!.center.y) */
        city4!.center = CGPoint(x: city4!.center.x - CGFloat(moveX), y: city4!.center.y)
        
        if city1!.frame.origin.x + CGFloat(cityWidth) < 0 {
            city1!.frame = CGRect(x: Double(city4!.frame.origin.x) + cityWidth, y: Double(city1!.frame.origin.y), width: cityWidth, height: cityHeight)
            println("move 1")
        }
        if city4!.frame.origin.x + CGFloat(cityWidth) < 0 {
            city4!.frame = CGRect(x: Double(city1!.frame.origin.x) + cityWidth, y: Double(city1!.frame.origin.y), width: cityWidth, height: cityHeight)
            println("move 2")
        }
        if ((mario!.center.x) < (box1!.center.x + 20) && (mario!.center.x) > (box1!.center.x - 20) && (mario!.center.y + 50) > (box1!.center.y - 20)){
            _timer?.invalidate()
            _timer = nil
            ScoreLabel.text = "Score: \(Score)"
            mario?.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 3))
            endLabel.text = "The End!"
            endLabel.textColor = UIColor.blueColor()
        }
        if ((mario!.center.x) < (box2!.center.x + 25) && (mario!.center.x) > (box2!.center.x - 25) && (mario!.center.y + 65) > (box2!.center.y - 25)){
            _timer?.invalidate()
            _timer = nil
            ScoreLabel.text = "Score: \(Score)"
            mario?.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI / 3))
            endLabel.text = "The End!"
            endLabel.textColor = UIColor.blueColor()
        }
        if (jump == true) {
           y -= accY
            if y < minheight {
                accY *= -1
                y = minheight
            }else if (y > maxheight) {
                jump = false
                    accY *= -1
                    y = maxheight
                }
                mario?.center = CGPoint(x: Double(x) * 0.4, y: y)
            }
    }
        
    func tapOnMario() {
        jump = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        _timer?.invalidate()
        _timer = nil
    }
    
}