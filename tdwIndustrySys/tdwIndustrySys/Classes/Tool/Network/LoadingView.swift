//
//  LoadingView.swift
//  TianDW
//
//  Created by B2B-IOS on 17/2/16.
//  Copyright © 2017年 tiandiwang. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    
    lazy var loadingKeyframeAnimationLeft: CAKeyframeAnimation = {
        
        let left = CAKeyframeAnimation(keyPath: "strokeEnd")
        left.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        left.keyTimes = [0.0, 0.3, 0.6,1.0]
        left.values = [0.0, 0.4,0.8, 1]
        left.duration = 1.5
        left.repeatCount = MAXFLOAT
        left.rotationMode = kCAAnimationCubic
        left.isRemovedOnCompletion = false
        return left
        
    }()

    
    var container: UIView?
    var loadingShaperLayerLeft: CAShapeLayer?
    

    var isShowing = false


    
    init(with view:UIView) {
        super.init(frame:view.bounds)
        center = CGPoint(x: view.width/2, y: view.height/2)
        
        container = view
        initCommon()
        initLoadingShapeLayer()
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    
    
    
    func show()  {
        if isShowing {
            return
        }
        isShowing = true
        loadingShaperLayerLeft?.add(loadingKeyframeAnimationLeft, forKey: "")
    }
    
    
    func dismiss()  {
        if !isShowing {
            return
        }
        isShowing = false
        loadingShaperLayerLeft?.removeAllAnimations()
    }
    
}

extension LoadingView {


    fileprivate func initCommon()  {
        isShowing = false
    }
    
    fileprivate func initLoadingShapeLayer() {
    
        let loadingBezierPathLeft = LoadingView.loadingShapeBezierPathLeft()
        loadingShaperLayerLeft = CAShapeLayer()
        loadingShaperLayerLeft?.frame = bounds
        loadingShaperLayerLeft?.path = loadingBezierPathLeft.cgPath
        loadingShaperLayerLeft?.strokeEnd = 1.0;
        loadingShaperLayerLeft?.strokeColor = UIColor(hexString: kLoadingColor)?.cgColor
        loadingShaperLayerLeft?.fillColor = UIColor.white.cgColor
        loadingShaperLayerLeft?.fillMode =  kCAFillModeForwards
        loadingShaperLayerLeft?.lineWidth = 3
        loadingShaperLayerLeft?.lineCap = kCALineCapRound
        loadingShaperLayerLeft?.lineJoin = kCALineJoinRound
        
        container?.layer.addSublayer(loadingShaperLayerLeft!)

    }

 
    static private func loadingShapeBezierPathLeft() ->UIBezierPath {
    
    
    
        //// 形状 20 Drawing
        let _22Path = UIBezierPath()
        
        _22Path.move(to: CGPoint(x: 26.31, y: 68))
        _22Path.addCurve(to: CGPoint(x: 17.66, y: 49.3), controlPoint1: CGPoint(x: 26.31, y: 68), controlPoint2: CGPoint(x: 19.69, y: 66.48))
        _22Path.addCurve(to: CGPoint(x: 17.66, y: 30.09), controlPoint1: CGPoint(x: 17.66, y: 49.3), controlPoint2: CGPoint(x: 18.68, y: 32.99))
        _22Path.addCurve(to: CGPoint(x: 5.96, y: 20.48), controlPoint1: CGPoint(x: 17.66, y: 30.09), controlPoint2: CGPoint(x: 18.29, y: 26.42))
        _22Path.addCurve(to: CGPoint(x: 1.38, y: 10.88), controlPoint1: CGPoint(x: 5.96, y: 20.48), controlPoint2: CGPoint(x: -3.45, y: 19.72))
        _22Path.addCurve(to: CGPoint(x: 6.98, y: 4.81), controlPoint1: CGPoint(x: 1.38, y: 10.88), controlPoint2: CGPoint(x: 4.31, y: 11.51))
        _22Path.addCurve(to: CGPoint(x: 11.05, y: 5.31), controlPoint1: CGPoint(x: 6.98, y: 4.81), controlPoint2: CGPoint(x: 10.41, y: 6.58))
        _22Path.addCurve(to: CGPoint(x: 17.15, y: 3.8), controlPoint1: CGPoint(x: 11.68, y: 4.05), controlPoint2: CGPoint(x: 12.57, y: -0.88))
        _22Path.addCurve(to: CGPoint(x: 21.22, y: 2.79), controlPoint1: CGPoint(x: 17.15, y: 3.8), controlPoint2: CGPoint(x: 19.44, y: 1.65))
        _22Path.addCurve(to: CGPoint(x: 23.25, y: 0.76), controlPoint1: CGPoint(x: 21.22, y: 2.79), controlPoint2: CGPoint(x: 20.58, y: -1.76))
        _22Path.addCurve(to: CGPoint(x: 26.31, y: 3.8), controlPoint1: CGPoint(x: 25.92, y: 3.29), controlPoint2: CGPoint(x: 26.31, y: 3.8))
        _22Path.addCurve(to: CGPoint(x: 34.95, y: 5.82), controlPoint1: CGPoint(x: 26.31, y: 3.8), controlPoint2: CGPoint(x: 32.41, y: 1.27))
        _22Path.addLine(to: CGPoint(x: 34.95, y: 9.36))
        _22Path.addCurve(to: CGPoint(x: 39.53, y: 7.34), controlPoint1: CGPoint(x: 34.95, y: 9.36), controlPoint2: CGPoint(x: 38.01, y: 7.59))
        _22Path.addCurve(to: CGPoint(x: 42.58, y: 7.34), controlPoint1: CGPoint(x: 41.06, y: 7.08), controlPoint2: CGPoint(x: 41.95, y: 6.96))
        _22Path.addCurve(to: CGPoint(x: 42.58, y: 9.86), controlPoint1: CGPoint(x: 43.22, y: 7.72), controlPoint2: CGPoint(x: 42.58, y: 9.11))
        _22Path.addCurve(to: CGPoint(x: 48.18, y: 12.39), controlPoint1: CGPoint(x: 42.58, y: 10.62), controlPoint2: CGPoint(x: 48.43, y: 7.08))
        _22Path.addCurve(to: CGPoint(x: 50.21, y: 13.91), controlPoint1: CGPoint(x: 48.18, y: 12.39), controlPoint2: CGPoint(x: 49.45, y: 13.91))
        _22Path.addCurve(to: CGPoint(x: 53.27, y: 21.49), controlPoint1: CGPoint(x: 50.98, y: 13.91), controlPoint2: CGPoint(x: 52.5, y: 19.22))
        _22Path.addCurve(to: CGPoint(x: 54.79, y: 38.17), controlPoint1: CGPoint(x: 54.03, y: 23.77), controlPoint2: CGPoint(x: 55.56, y: 33.75))
        _22Path.addCurve(to: CGPoint(x: 47.67, y: 40.7), controlPoint1: CGPoint(x: 54.03, y: 42.6), controlPoint2: CGPoint(x: 51.1, y: 43.86))
        _22Path.addCurve(to: CGPoint(x: 27.83, y: 37.16), controlPoint1: CGPoint(x: 44.24, y: 37.54), controlPoint2: CGPoint(x: 34.83, y: 31.73))
        _22Path.addCurve(to: CGPoint(x: 22.24, y: 58.39), controlPoint1: CGPoint(x: 20.84, y: 42.6), controlPoint2: CGPoint(x: 20.84, y: 53.97))
        _22Path.addCurve(to: CGPoint(x: 27.32, y: 67.49), controlPoint1: CGPoint(x: 23.64, y: 62.82), controlPoint2: CGPoint(x: 27.32, y: 67.49))
        _22Path.addCurve(to: CGPoint(x: 26.31, y: 68), controlPoint1: CGPoint(x: 27.32, y: 67.49), controlPoint2: CGPoint(x: 27.32, y: 68))
        
        
        return _22Path
    
    
    
    }
    
}
