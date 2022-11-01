//
//  CGPathDescriptor.swift
//  
//
//  Created by scchn on 2022/10/1.
//

import Foundation
import QuartzCore

extension CGPathDescriptor {
    
    public enum LineCap {
        
        case butt
        case round
        case square
        
        var cgLineCap: CGLineCap {
            switch self {
            case .butt:   return .butt
            case .round:  return .round
            case .square: return .square
            }
        }
        
    }
    
    public enum LineJoin {
        
        case miter(limit: CGFloat)
        case round
        case bevel
        
        fileprivate var info: (cgLineJoin: CGLineJoin, miterLimit: CGFloat) {
            switch self {
            case .miter(let limit): return (.miter, limit)
            case .round:            return (.round, 0)
            case .bevel:            return (.bevel, 0)
            }
        }
        
    }
    
    public struct LineDash {
        public var phase: CGFloat
        public var lengths: [CGFloat]
    }
    
    public enum Method {
        case stroke(lineWidth: CGFloat, lineCap: LineCap = .butt, lineJoin: LineJoin = .bevel, lineDash: LineDash? = nil)
        case fill
    }
    
    public struct Shadow {
        public var offset: CGSize
        public var blur: CGFloat
        public var color: CGColor
    }
    
}

public class CGPathDescriptor {
    
    public let cgPath: CGPath
    
    public var method: Method
    
    public var color: CGColor
    
    public var shadow: Shadow?
    
    // MARK: - Life Cycle
    
    public init(method: Method, color: CGColor, shadow: Shadow? = nil, path: CGPath) {
        self.method = method
        self.color = color
        self.cgPath = path
        self.shadow = shadow
    }
    
    public init(method: Method, color: CGColor, shadow: Shadow? = nil, _ make: () -> CGPath) {
        self.method = method
        self.color = color
        self.cgPath = make()
        self.shadow = shadow
    }
    
    // MARK: - Utils
    
    public func draw(context: CGContext) {
        defer { context.restoreGState() }
        
        context.saveGState()
        
        context.addPath(cgPath)
        
        context.setShadow(offset: shadow?.offset ?? .zero, blur: shadow?.blur ?? 0, color: shadow?.color)
        
        switch method {
        case let .stroke(width, cap, join, dash):
            context.setLineWidth(width)
            context.setLineCap(cap.cgLineCap)
            context.setLineJoin(join.info.cgLineJoin)
            context.setMiterLimit(join.info.miterLimit)
            context.setLineDash(phase: dash?.phase ?? 0, lengths: dash?.lengths ?? [])
            context.setStrokeColor(color)
            context.strokePath()
            
        case .fill:
            context.setFillColor(color)
            context.fillPath()
        }
    }
    
    public func contains(point: CGPoint, extraRange: CGFloat = 0) -> Bool {
        switch method {
        case let .stroke(width, cap, join, _):
            let path = cgPath.copy(
                strokingWithWidth: width + extraRange * 2,
                lineCap: cap.cgLineCap,
                lineJoin: join.info.cgLineJoin,
                miterLimit: join.info.miterLimit
            )
            return path.contains(point)
            
        case .fill:
            return cgPath.contains(point, using: .evenOdd)
        }
    }
    
}
