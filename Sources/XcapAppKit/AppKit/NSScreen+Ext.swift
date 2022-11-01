//
//  NSScreen+Ext.swift
//  
//
//  Created by scchn on 2022/10/5.
//

#if os(macOS)

import AppKit

extension NSScreen {
    
    public var displayID: CGDirectDisplayID {
        let key = NSDeviceDescriptionKey(rawValue: "NSScreenNumber")
        return (deviceDescription[key] as! NSNumber).uint32Value
    }
    
    public var pixelSize: CGSize {
        (deviceDescription[.size] as! NSValue).sizeValue
    }
    
    public var physicalSize: CGSize {
        CGDisplayScreenSize(displayID)
    }
    
}

#endif
