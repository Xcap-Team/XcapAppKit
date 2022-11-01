//
//  NSColor+Ext.swift
//  
//
//  Created by scchn on 2022/10/31.
//

#if os(macOS)

import AppKit

extension NSColor {
    
    public convenience init(value: Int) {
        self.init(red: CGFloat((value & 0xFF0000) >> 16) / 255,
                  green: CGFloat((value & 0x00FF00) >> 8) / 255,
                  blue: CGFloat((value & 0x0000FF)) / 255,
                  alpha: 1)
    }
    
}

#endif
