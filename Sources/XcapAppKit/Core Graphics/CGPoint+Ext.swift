//
//  CGPoint+Ext.swift
//  
//
//  Created by scchn on 2022/10/8.
//

import Foundation

extension CGPoint {
    
    public func mid(with point: CGPoint) -> CGPoint {
        CGPoint(x: (x + point.x) / 2,
                y: (y + point.y) / 2)
    }
    
    public func distance(with point: CGPoint) -> CGFloat {
        let dx = point.x - x
        let dy = point.y - y
        return sqrt(dx * dx + dy * dy)
    }
    
    public func extended(length: CGFloat, angle: CGFloat) -> CGPoint {
        CGPoint(x: x + length * cos(angle),
                y: y + length * sin(angle))
    }
    
}
