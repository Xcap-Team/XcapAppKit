//
//  Dictionary+Ext.swift
//  
//
//  Created by scchn on 2022/10/5.
//

import Foundation

extension Dictionary {
    
    public func updated(value: Value?, forKey key: Key) -> Dictionary<Key, Value> {
        var dict = self
        dict[key] = value
        return dict
    }
    
    public func transformingKeys<K: Hashable>(_ transform: (Key) throws -> K?) rethrows -> Dictionary<K, Value> {
        try keys.reduce([K: Value]()) { dict, old in
            guard let new = try transform(old) else {
                return dict
            }
            return dict.updated(value: self[old], forKey: new)
        }
    }
    
    public func transformingKeys<K: Hashable>(_ transform: (Key) throws -> K) rethrows -> Dictionary<K, Value> {
        try keys.reduce([K: Value]()) { dict, old in
            let new = try transform(old)
            return dict.updated(value: self[old], forKey: new)
        }
    }
    
}
