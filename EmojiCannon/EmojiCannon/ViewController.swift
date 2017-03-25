//
//  ViewController.swift
//  StreamAnimation
//
//  Created by Zain Haq on 2017-03-24.
//  Copyright © 2017 Zain Haq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cannonImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cannon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.transform = CGAffineTransform(rotationAngle: -.pi/4)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(cannonImageView)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        addConstraints()
        
    }
    
    private func addConstraints() {
        cannonImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        cannonImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 5).isActive = true
        cannonImageView.widthAnchor.constraint(equalToConstant: 100*1.235).isActive = true
        cannonImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc
    private func didTap() {
        (0...10).forEach { _ in
            generateEmojis()
        }
        
    }
    
    private func generateEmojis() {
        
        let emojiStart = 0x1F601
        let ascii = emojiStart + Int(arc4random_uniform(UInt32(60)))
        let emoji = UnicodeScalar(ascii)?.description ?? "🐶"
        
        let label = UILabel()
        label.text = emoji
        label.font = UIFont.systemFont(ofSize: 35)
        label.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = generatePath().cgPath
        animation.duration = TimeInterval(2 + arc4random_uniform(3))
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        label.layer.add(animation, forKey: nil)
        view.insertSubview(label, belowSubview: cannonImageView)
        
    }
    
    func generatePath() -> UIBezierPath {
        let path = UIBezierPath()
        
        let yShift = 200 + CGFloat(arc4random_uniform(300))
        
        let startPoint = CGPoint(x: cannonImageView.frame.origin.x + cannonImageView.frame.height - 35,
                                 y: cannonImageView.frame.origin.y  + cannonImageView.frame.height/2)
        let endPoint = CGPoint(x: view.frame.width + 100, y: 300)
        let cp1 = CGPoint(x: 100, y: 100 - yShift)
        
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: endPoint)
        
        return path
    }
    
}


