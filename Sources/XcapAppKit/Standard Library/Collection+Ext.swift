//
//  Collection+Ext.swift
//  
//
//  Created by scchn on 2022/9/30.
//

import Foundation

extension Collection {
    
    public func get(_ index: Index?) -> Element? {
        guard let index = index else {
            return nil
        }
        return self[index]
    }
    
    public func get<C: Collection>(_ indexes: C) -> [Element] where C.Element == Index {
        indexes.map { self[$0] }
    }
    
    public func indexes<T: Collection>(of elements: T) -> [Index] where Element: Equatable, T.Element == Element {
        elements.compactMap(firstIndex(of:))
    }
    
    public func indexes<C: Collection>(of collection: C, where predicate: (Element, C.Element) throws -> Bool) rethrows -> [Index] {
        try collection.compactMap { a in
            try firstIndex { e in
                try predicate(e, a)
            }
        }
    }
    
    public func filterNot(_ predicate: (Element) throws -> Bool) rethrows -> [Element] {
        try filter {
            try !predicate($0)
        }
    }
    
}
