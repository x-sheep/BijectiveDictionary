//  =============================================================
//  File: BijectiveDictionary+Sequence.swift
//  Project: BijectiveDictionary
//  -------------------------------------------------------------
//  Created by Jacob Gelman on 07/29/2024
//  Copyright © 2024 Jacob Gelman. All rights reserved.
//  =============================================================

extension BijectiveDictionary: Sequence {

    /// A tuple containing an individual left-right pair.
    public typealias Element = (left: Left, right: Right)
    
    @frozen public struct Iterator {
        @usableFromInline
        internal var _ltrIterator: Dictionary<Left, Right>.Iterator
        
        @usableFromInline
        internal init(ltrIterator: Dictionary<Left, Right>.Iterator) {
            self._ltrIterator = ltrIterator
        }
    }
    
    @inlinable public func makeIterator() -> Iterator {
        Iterator(ltrIterator: _ltr.makeIterator())
    }
}

// These functions are hidden optional requirements of the Sequence protocol.
// The functions should return nil if they can't be implemented faster than O(*n*),
// but Dictionaries can work in O(1) time.
extension BijectiveDictionary {
    @inlinable @inline(__always)
    public func _customContainsEquatableElement(_ element: Element) -> Bool? {
        return contains(element)
    }

    @inlinable @inline(__always)
    public func _customIndexOfEquatableElement(_ element: Element) -> Index?? {
        return Optional(index(of: element))
    }

    @inlinable @inline(__always)
    public func _customLastIndexOfEquatableElement(_ element: Element) -> Index?? {
        return _customIndexOfEquatableElement(element)
    }
}

extension BijectiveDictionary.Iterator: IteratorProtocol {
    
    @inlinable public mutating func next() -> BijectiveDictionary.Element? {
        let element: (Left, Right)? = _ltrIterator.next()
        return element
    }
}

extension BijectiveDictionary.Iterator: Sendable
where Left: Sendable, Right: Sendable {}
