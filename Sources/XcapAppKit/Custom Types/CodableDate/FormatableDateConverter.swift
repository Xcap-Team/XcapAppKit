//
//  FormatableDateConverter.swift
//  
//
//  Created by scchn on 2022/9/30.
//

import Foundation

public protocol FormatableDateConverter: DateConverter {
    
    static var dateFormat: String { get }
    
    static var timeZone: TimeZone? { get }
    
    static var calendar: Calendar? { get }
    
    static var locale: Locale? { get }
    
}

extension FormatableDateConverter {
    
    private static func threadSharedFormatter() -> DateFormatter {
        let thread = Thread.current
        let key = "com.scchn.XcapAppKit.\(String(describing: self))"
        
        if let formatter = thread.threadDictionary[key] as? DateFormatter {
            return formatter
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        thread.threadDictionary[key] = formatter
        
        return formatter
    }
    
    private static func formatter() -> DateFormatter {
        let formatter = threadSharedFormatter()
        
        if let timeZone {
            formatter.timeZone = timeZone
        }
        
        if let calendar {
            formatter.calendar = calendar
        }
        
        if let locale {
            formatter.locale = locale
        }
        
        return formatter
    }
    
    public static var timeZone: TimeZone? { nil }
    
    public static var calendar: Calendar? { nil }
    
    public static var locale: Locale? { nil }
    
    public static func encode(date: Date) -> String {
        formatter().string(from: date)
    }
    
    public static func decode(from rawValue: String) -> Date? {
        formatter().date(from: rawValue)
    }
    
}
