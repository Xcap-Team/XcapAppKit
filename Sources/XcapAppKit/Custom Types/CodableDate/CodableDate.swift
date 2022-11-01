//
//  CodableDate.swift
//  
//
//  Created by scchn on 2022/9/30.
//

import Foundation

@propertyWrapper
public struct CodableDate<Converter: DateConverter>: Hashable, Equatable, Codable {
    
    public let wrappedValue: Date
    
    public var projectedValue: Converter.RawValue {
        Converter.encode(date: wrappedValue)
    }
    
    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        let rawValue = try Converter.RawValue(from: decoder)
        
        if let date = Converter.decode(from: rawValue) {
            wrappedValue = date
        } else {
            let path = decoder.codingPath.first?.stringValue ?? ""
            let desc = "Failed to decode `\(path)` from \(rawValue)."
            let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: desc)
            
            throw DecodingError.dataCorrupted(context)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        try projectedValue.encode(to: encoder)
    }
    
}
