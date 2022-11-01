//
//  BinaryFloatingPoint+Ext.swift
//  
//
//  Created by scchn on 2022/10/5.
//

import Foundation

extension BinaryFloatingPoint {
    
    public func rounded(to decimalPlaces: UInt,
                        rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self
    {
        let n = Self(pow(10.0, Double(max(0, decimalPlaces))))
        return (self * n).rounded(rule) / n
    }
    
    public var clean: String {
        let double = Double(self)
        
        return truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", double)
            : double.description
    }
    
}
