//
//  WCLLaunchView.swift
//  WCLLaunchView
//
//  Created by 王崇磊 on 16/8/11.
//  Copyright © 2016年 王崇磊. All rights reserved.(https://github.com/631106979)
//
// @class WCLLaunchView
// @abstract 缓慢展开的启动图
// @discussion 缓慢展开的启动图
//

import UIKit

class WCLLaunchView: UIView {
    
    private var topLayer:CALayer = CALayer()
    private var bottomLayer:CALayer = CALayer()
    private var launchImage:UIImage?
    //MARK: Public Methods
    /**
     展开的动画
     */
    func starAnimation() {
        //创建一个CABasicAnimation作用于CALayer的anchorPoint
        let topAnimation = CABasicAnimation.init(keyPath: "anchorPoint")
        //设置移动路径
        topAnimation.toValue = NSValue.init(CGPoint: CGPointMake(1, 1))
        //动画时间
        topAnimation.duration = 2.6
        //设置代理，方便完成动画后移除当前view
        topAnimation.delegate = self
        //设置动画速度为匀速
        topAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        //设置动画结束后不移除点，保持移动后的位置
        topAnimation.removedOnCompletion = false
        topAnimation.fillMode = kCAFillModeForwards
        topLayer.addAnimation(topAnimation, forKey: "topAnimation")
        
        //创建一个CABasicAnimation作用于CALayer的anchorPoint
        let bottomAnimation = CABasicAnimation.init(keyPath: "anchorPoint")
        //设置移动路径
        bottomAnimation.toValue = NSValue.init(CGPoint: CGPointMake(0, 0))
        //动画时间
        bottomAnimation.duration = 2.6
        //设置动画速度为匀速
        bottomAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        //设置动画结束后不移除点，保持移动后的位置
        bottomAnimation.removedOnCompletion = false
        bottomAnimation.fillMode = kCAFillModeForwards
        bottomLayer.addAnimation(bottomAnimation, forKey: "topAnimation")
    }
    
    //MARK: Initial Methods
    convenience init(frame: CGRect, launchImage:UIImage?) {
        self.init(frame:frame)
        self.launchImage = launchImage
        configTopShapeLayer()
        configBottomShapeLayer()
    }
    
    
    //MARK: Privater Methods
    /**
     绘制上半部分的layer
     */
    private func configTopShapeLayer() {
        //绘制贝斯尔曲线
        let topBezier:UIBezierPath = UIBezierPath()
        topBezier.moveToPoint(CGPointMake(-1, -1))
        topBezier.addLineToPoint(CGPointMake(bounds.width+1, -1))
        topBezier.addCurveToPoint(CGPointMake(bounds.width/2.0+1, bounds.height/2.0+1), controlPoint1: CGPointMake(bounds.width+1, 0+1), controlPoint2: CGPointMake(343.5+1, 242.5+1))
        topBezier.addCurveToPoint(CGPointMake(-1, bounds.height+2), controlPoint1: CGPointMake(31.5+2, 424.5+2), controlPoint2: CGPointMake(0+2, bounds.height+2))
        topBezier.addLineToPoint(CGPointMake(-1, -1))
        topBezier.closePath()
        //创建一个CAShapeLayer，将绘制的贝斯尔曲线的path给CAShapeLayer
        let topShape = CAShapeLayer()
        topShape.path = topBezier.CGPath
        //给topLayer设置contents为启动图
        topLayer.contents = launchImage?.CGImage
        topLayer.frame = bounds
        layer.addSublayer(topLayer)
        //将绘制后的CAShapeLayer做为topLayer的mask
        topLayer.mask = topShape
    }
    
    /**
     绘制下半部分的layer
     */
    private func configBottomShapeLayer() {
        //绘制贝斯尔曲线
        let bottomBezier:UIBezierPath = UIBezierPath()
        bottomBezier.moveToPoint(CGPointMake(bounds.width, 0))
        bottomBezier.addCurveToPoint(CGPointMake(bounds.width/2.0, bounds.height/2.0), controlPoint1: CGPointMake(bounds.width, 0), controlPoint2: CGPointMake(343.5, 242.5))
        bottomBezier.addCurveToPoint(CGPointMake(0, bounds.height), controlPoint1: CGPointMake(31.5, 424.5), controlPoint2: CGPointMake(0, bounds.height))
        bottomBezier.addLineToPoint(CGPointMake(bounds.width, bounds.height))
        bottomBezier.addLineToPoint(CGPointMake(bounds.width, 0))
        bottomBezier.closePath()
        //创建一个CAShapeLayer，将绘制的贝斯尔曲线的path给CAShapeLayer
        let bottomShape = CAShapeLayer()
        bottomShape.path = bottomBezier.CGPath
        //给bottomLayer设置contents为启动图
        bottomLayer.contents = launchImage?.CGImage
        bottomLayer.frame = bounds
        layer.addSublayer(bottomLayer)
        //将绘制后的CAShapeLayer做为bottomLayer的mask
        bottomLayer.mask = bottomShape
    }
    
    //MRAK: animationDelegate
    /**
     动画完成后移除当前view
     */
    internal override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag {
            removeFromSuperview()
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
