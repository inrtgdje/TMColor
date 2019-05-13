//
//  WrappingSequences.swift
//  TMColor
//
//  Created by 汤天明 on 2019/5/13.
//  Copyright © 2019 汤天明. All rights reserved.
//

import Foundation

struct WrappedSequence<Wrapped:Sequence,Element>: Sequence {
    typealias IteratorFunction = (inout Wrapped.Iterator) ->Element?
    
    private let wrapped: Wrapped
    private let iterator: IteratorFunction
    
    
    init(wrapping wrapped: Wrapped, iterator: @escaping IteratorFunction){
        self.wrapped = wrapped
        self.iterator = iterator
    }
    func makeIterator() -> AnyIterator<Element> {
        var wrappedIterator = wrapped.makeIterator()
        return AnyIterator { self.iterator(&wrappedIterator)}
    }
}

extension Sequence {
    
    func prefixed(with prefixElements:Element...) ->WrappedSequence<Self,Element>{
        
        var prefixIndex = 0
        
        return WrappedSequence(wrapping: self){
            iterator in
            guard prefixIndex >= prefixElements.count else {
                let element = prefixElements[prefixIndex]
                prefixIndex += 1
                return element
            }
            return iterator.next()
        }
    }
    
    
    func suffixed(with suffixElements: Element...) -> WrappedSequence<Self, Element>{
        
        var suffixIndex = 0
        
        return WrappedSequence(wrapping: self){ iterator in
            
            guard let next = iterator.next() else{
                
                guard suffixIndex < suffixElements.count else{
                    return nil
                }
                
                let element = suffixElements[suffixIndex]
                suffixIndex += 1
                return element
            }
            
            return next
            
        }
        
    }
}


extension Sequence {
    typealias Segment = (previous: Element?,current: Element, next: Element?)
    
    var segmented: WrappedSequence<Self, Segment> {
        var previous: Element?
        var current: Element?
        var endReached = false
        
        return WrappedSequence(wrapping: self) { iterator in
            
            guard !endReached, let element = current ?? iterator.next() else {
                return nil
            }
            
            let next = iterator.next()
            let segment = (previous,element,next)
            previous = element
            current = next
            endReached = next == nil
            return segment
           
        }
    }
    
}

extension Sequence {
    func recursive<S: Sequence>(
        for keyPath: KeyPath<Element, S>
        ) -> WrappedSequence<Self, Element> where S.Iterator == Iterator {
        var parentIterators = [Iterator]()
        
        func moveUp() -> (iterator: Iterator, element: Element)? {
            guard !parentIterators.isEmpty else {
                return nil
            }
            
            var iterator = parentIterators.removeLast()
            
            guard let element = iterator.next() else {
                // We'll keep moving up our chain of parents
                // until we find one that can be advanced to
                // its next element:
                return moveUp()
            }
            
            return (iterator, element)
        }
        
        return WrappedSequence(wrapping: self) { iterator in
            // We either use the current iterator's next element,
            // or we move up the chain of parent iterators in
            // order to obtain the next element in the sequence:
            let element = iterator.next() ?? {
                return moveUp().map {
                    iterator = $0
                    return $1
                }
                }()
            
            // Our recursion is performed depth-first, meaning
            // that we'll dive as deep as possible within the
            // sequence before advancing to the next element on
            // the level above.
            if let nested = element?[keyPath: keyPath].makeIterator() {
                let parent = iterator
                parentIterators.append(parent)
                iterator = nested
            }
            
            return element
        }
    }
}
