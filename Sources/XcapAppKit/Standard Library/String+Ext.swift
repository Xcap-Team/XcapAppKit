//
//  String+Ext.swift
//  
//
//  Created by scchn on 2022/9/30.
//

import Foundation

extension String {
    
    public static func isNilOrEmpty(_ string: String?) -> Bool {
        string?.isEmpty != false
    }
    
    public func ifEmpty(_ alt: String) -> String {
        isEmpty ? alt : self
    }
    
}
