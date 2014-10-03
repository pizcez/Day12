
import UIKit
let maxAngle = M_PI_4 * 0.5
class Conlac: UIViewController {

    var pendulum: UIImageView = UIImageView()
    var timer : NSTimer?
    var angle : Double = 0
    var angleDelta : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "animatePendulum:", userInfo: nil , repeats: true)
        timer?.fire()
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        pendulum.image = UIImage(named: "pendulum.png")
        pendulum.frame = CGRect(x: self.view.bounds.size.width * 0.5, y: 100, width: 42, height: 291)
        self.view.addSubview(pendulum)
        var size :CGSize = self.pendulum.bounds.size
        self.pendulum.layer.anchorPoint = CGPointMake(0.5, 0)
        self.pendulum.frame = CGRectMake((self.view.bounds.size.width - size.width) * 0.5, 20, size.width, size.height)
        angleDelta = 0.05
    }
    
    func animatePendulum(timer: NSTimer){
        angle += angleDelta
        if ((angle > maxAngle) | (angle < -maxAngle)){
            angleDelta = -angleDelta
        }
        self.pendulum.transform = CGAffineTransformMakeRotation(CGFloat(angle))
    }
    
}

