//
//  DateConverter.swift
//  
//
//  Created by scchn on 2022/9/30.
//

import Foundation

public protocol DateConverter {
    
    associatedtype RawValue: Codable
    
    static func encode(date: Date) -> RawValue
    
    static func decode(from rawValue: RawValue) -> Date?
    
}
