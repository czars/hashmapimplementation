//
//  main.swift
//
//  Created by Steven Curtis on 26/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

// Array implementation
//class MyHashMap {
//    var arr : [Int] = []
//    /** Initialize your data structure here. */
//    init() {
//
//    }
//
//    /** value will always be non-negative. */
//    func put(_ key: Int, _ value: Int) {
//        if (arr.count - 1) >= key {
//            arr[key] = value
//        } else {
//            arr.reserveCapacity(key + 1)
//            for _ in arr.count-1..<key-1{
//                arr.append(-1)
//            }
//            arr.append(value)
//            print (arr)
//        }
//    }
//
//    /** Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key */
//    func get(_ key: Int) -> Int {
//        if(arr.count - 1) >= key {
//            return arr[key]
//        }
//        return -1
//    }
//
//    /** Removes the mapping of the specified value key if this map contains a mapping for the key */
//    func remove(_ key: Int) {
//        if(arr.count - 1) >= key {
//            arr[key] = -1
//        }
//    }
//}

struct Element {
    var key: Int
    var value: Int
}
// Implementation
class MyHashMap {
    
    var buckets : [[Element]] = [[]]
    
    /** Initialize your data structure here. */
    init() {
        buckets = [Array(repeating: Element(key: -1, value: -1), count: 2)]
    }
    
    var currentLoadFactor: Double {
        return Double ( buckets.flatMap{$0}.filter{$0.key != -1}.count ) / Double(buckets.count)
    }
    
    func resize() {
        if currentLoadFactor > 0.9 {
            // double the capacity
            let extraBuckets : [[Element]] = [Array(repeating: Element(key: -1, value: -1), count: buckets.count)]
            buckets += extraBuckets
        } else {
            if currentLoadFactor < 0.4 {
                // remove blank buckets
                hashmap.buckets.removeAll(where: { $0.contains(where: { $0.key == -1 })})
                resize()
            }
        }
    }
    
    /** value will always be non-negative. */
    func put(_ key: Int, _ value: Int) {
        remove(key)
        let position = abs(key.hashValue) % buckets.count
        buckets[position].append(Element(key: key, value: value))
    }
    
    /** Returns the value to which the specified key is mapped, or -1 if this map contains no mapping for the key */
    func get(_ key: Int) -> Int {
        let position = abs(key.hashValue) % buckets.count
        return buckets[position].first{ $0.key == key }?.value ?? -1
    }
    
    /** Removes the mapping of the specified value key if this map contains a mapping for the key */
    func remove(_ key: Int) {
        let position = abs(key.hashValue) % buckets.count
        buckets[position].removeAll(where: { $0.key == key })
    }
}

var hashmap = MyHashMap()
hashmap.put(1, 1)
hashmap.put(2, 1)

print ( hashmap.get(1) ) // 1

print ( hashmap.get(3) ) // -1
hashmap.put(2, 1)
print ( hashmap.get(2) ) // 1
hashmap.remove(2)
print ( hashmap.get(2) ) // -1

//var hashmap = MyHashMap()
//hashmap.remove(14)
//hashmap.get(4)
//hashmap.put(7, 3)
//hashmap.put(11, 1)
//hashmap.put(12, 1)
//hashmap.get(7)
//hashmap.put(1, 19)
//hashmap.put(0, 3)
//hashmap.put(1, 8)
//hashmap.put(2, 6)


