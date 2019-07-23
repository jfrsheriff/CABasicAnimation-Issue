//
//  ViewController.swift
//  CABasic Animation
//
//  Created by Jaffer Sheriff U on 18/07/19.
//  Copyright © 2019 Jaffer Sheriff U. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let width : CGFloat = 300.0
    let height : CGFloat = 300.0
    
    let bottomPadding : CGFloat = 20
    let radius : CGFloat = 10.0
    
    var circleCenter : CGPoint {
        get{
           return CGPoint(x: width/2.0 , y: height - bottomPadding )
        }
    }
    
    lazy var containerView : UIView = {
            let view = UIView()
            view.backgroundColor = .gray
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        
            NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
                ])
        return view
    }()
    
    lazy var pointerLayer : CAShapeLayer = {
        let layer =  CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor.purple.cgColor
        layer.fillColor = UIColor.purple.cgColor
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return layer
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
     

        let circlePath = UIBezierPath.init(arcCenter: circleCenter, radius: width/2.0, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        let circleLayer = CAShapeLayer()
        circleLayer.lineWidth = 5
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.yellow.cgColor
        circleLayer.fillColor = UIColor.yellow.cgColor
        containerView.layer.addSublayer(circleLayer)
        
        let initialPath = UIBezierPath.init(arcCenter:circleCenter , radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        initialPath.move(to: circleCenter)
        initialPath.addLine(to: CGPoint(x: 0, y: height - bottomPadding ))
        pointerLayer.path = initialPath.cgPath
        
        containerView.layer.addSublayer(pointerLayer)
        
        self.configureButton()
        
    }
    
    func addAnimation(){
        
        let degrees = 30.0
        let radians = CGFloat(degrees * Double.pi / 180)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = radians
        rotateAnimation.duration = 2.0
        pointerLayer.add(rotateAnimation, forKey: "Animation")    }
    
    
    func configureButton() {
        let resetAnim = UIButton()
        resetAnim.setTitle("Animate", for: .normal)
        resetAnim.translatesAutoresizingMaskIntoConstraints = false
        resetAnim.backgroundColor = .red
        resetAnim.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        self.view.addSubview(resetAnim)
        
        NSLayoutConstraint.activate([
            
            resetAnim.leftAnchor.constraint(greaterThanOrEqualTo: self.view.leftAnchor, constant: 20),
            resetAnim.rightAnchor.constraint(lessThanOrEqualTo: self.view.rightAnchor, constant: -20),
            resetAnim.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            resetAnim.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
            ])
    }
    
    @objc func resetAction(){
        self.addAnimation()
    }


}

