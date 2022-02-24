//
//  GradientView.swift
//  HomeWork12
//
//  Created by Yura on 29.12.2021.
//

import UIKit

class GradientView: UIView {
    
    var leftColor: UIColor = .white
    var rightColor: UIColor = UIColor.init(red: 34.0 / 255, green: 39.0 / 255, blue: 46.0 / 255, alpha: 1)
    
    var startX: CGFloat = 0
    var startY: CGFloat = 0.5
    var endX: CGFloat = 1
    var endY: CGFloat = 0.5
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startX, y: startY)
        gradientLayer.endPoint = CGPoint(x: endX, y: endY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
