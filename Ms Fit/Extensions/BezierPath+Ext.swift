//
//  BezierPath+Ext.swift
//  Ms Fit
//
//  Created by Yura Granchenko on 1/23/19.
//  Copyright © 2019 Simcord. All rights reserved.
//

import UIKit

public func ^ (lhs: CGFloat, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs, y: rhs)
}

public func ^ (lhs: CGFloat, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs, height: rhs)
}

public func ^ (lhs: CGPoint, rhs: CGSize) -> CGRect {
    return CGRect(origin: lhs, size: rhs)
}

extension UIBezierPath {
    
    @discardableResult func move(_ point: CGPoint) -> Self {
        self.move(to: point)
        return self
    }
    
    @discardableResult func line(_ point: CGPoint) -> Self {
        addLine(to: point)
        return self
    }
    
    @discardableResult func quadCurve(_ point: CGPoint, controlPoint: CGPoint) -> Self {
        addQuadCurve(to: point, controlPoint: controlPoint)
        return self
    }
}
