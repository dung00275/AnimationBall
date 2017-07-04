import Foundation
import UIKit


@IBDesignable
public class BallView: UIActivityIndicatorView {
    
    @IBInspectable var colorBall: UIColor? = .cyan
    @IBInspectable var numberBall: Int = 3
    // Dot
    private lazy var dot = CAShapeLayer()
    private lazy var replicator = CAReplicatorLayer()
    private var sizeBall: CGSize = CGSize(width: 20, height: 20)
    
    
    private override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
        super.init(activityIndicatorStyle: style)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public convenience init(frame: CGRect,
                            using colorBall: UIColor,
                            with numberBall: Int = 3)
    {
        self.init(frame: frame)
        self.colorBall = colorBall
        self.numberBall = numberBall
        self.clipsToBounds = false
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupLayer()
    }
    
    private func setupLayer() {
        self.subviews.filter({ $0 is UIImageView }).forEach({ $0.isHidden = true })
        // Calculate size
        let f = self.bounds
        
        let padding: CGFloat = 5
        let sBall = (f.width - (CGFloat(numberBall) + 1) * padding) / CGFloat(numberBall)
        sizeBall = CGSize(width: sBall, height: sBall)
        
        replicator.anchorPoint =  CGPoint(x: 0.5, y: 0.5)
        replicator.frame = CGRect(origin: .zero, size: f.size)
        self.layer.addSublayer(replicator)
        
        // Center
        let offsetY = max(0, (f.height - self.sizeBall.height) / 2)
        // Setup dot
        dot.frame = CGRect(origin: CGPoint(x: padding, y: offsetY), size: sizeBall)
        // circle path
        dot.path = UIBezierPath(ovalIn: CGRect(origin: .zero, size: sizeBall)).cgPath
        dot.fillColor = colorBall?.cgColor
        
        replicator.addSublayer(dot)
        replicator.instanceCount = numberBall
        replicator.instanceTransform = CATransform3DMakeTranslation(sizeBall.width + padding, 0, 0)
        replicator.instanceDelay = 0.12
    }
    
    override public func startAnimating() {
        super.startAnimating()
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scale.toValue = NSValue(caTransform3D:
            CATransform3DMakeScale(0.3, 0.3, 1))
        scale.duration = 0.75
        scale.repeatCount = Float.infinity
        scale.autoreverses = true
        scale.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseOut)
        dot.add(scale, forKey: "dotScale")
    }
    
    override public func stopAnimating() {
        dot.removeAllAnimations()
        super.stopAnimating()
    }
}


