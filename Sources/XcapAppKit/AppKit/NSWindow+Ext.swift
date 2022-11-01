//
//  NSWindow+Ext.swift
//  
//
//  Created by scchn on 2022/10/5.
//

#if os(macOS)

import AppKit

extension NSWindow {
    
    public func endSheet(returnCode: NSApplication.ModalResponse? = nil) {
        if let returnCode = returnCode {
            sheetParent?.endSheet(self, returnCode: returnCode)
        } else {
            sheetParent?.endSheet(self)
        }
    }
    
}

#endif
