//
//  Angle.swift
//  
//
//  Created by scchn on 2022/10/8.
//

import Foundation

public struct Angle: Equatable, Hashable, Codable {
    
    private let internalAngle: AngleEnum
    
    public var radians: CGFloat {
        internalAngle.radians
    }
    
    public var degrees: CGFloat {
        internalAngle.degrees
    }
    
    public static func ==(_ lhs: Angle, _ rhs: Angle) -> Bool {
        lhs.radians == rhs.radians
    }
    
    public init(degrees: CGFloat) {
        internalAngle = .degrees(degrees)
    }
    
    public init(radians: CGFloat) {
        internalAngle = .radians(radians)
    }
    
}

private enum AngleEnum: Hashable, Codable {
    
    case radians(CGFloat)
    case degrees(CGFloat)
    
    private var value: CGFloat {
        switch self {
        case let .degrees(v): fallthrough
        case let .radians(v): return v
        }
    }
    
    var radians: CGFloat {
        guard case .degrees(let deg) = self else {
            return value
        }
        return AngleEnum.radians(deg * .pi / 180).value
    }
    
    var degrees: CGFloat {
        guard case .radians(let rad) = self else {
            return value
        }
        return AngleEnum.degrees(rad / .pi * 180).value
    }
    
}
