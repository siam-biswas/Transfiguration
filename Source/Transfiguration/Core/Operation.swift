//
// Operation.swift
// Transfiguration
//
// Copyright (c) 2020 Siam Biswas.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation



public protocol Operatable {
    associatedtype T
    
    var data: [T] { get set }
    
    subscript(_ at: Int) -> T { get set }
    
    mutating func append(_ newElement:T) -> Int
    mutating func insert(_ newElement:T, at:Int?) -> Int
    mutating func update(_ newElement:T, at:Int) -> Bool
    mutating func remove(at:Int) -> Bool

    mutating func append(contentsOf:[T]) -> [Int]
}

extension Operatable{
   
      public subscript(at: Int) -> T {
           get {
               return data[at]
           }
           set {
               _ = update(newValue, at: at)
           }
       }
       
       @discardableResult
       public mutating func append(_ newElement: T) -> Int {
           self.data.append(newElement)
           return data.count - 1
       }
       
       @discardableResult
       public mutating func insert(_ newElement: T, at: Int?) -> Int {
            guard let at = at, at < data.count else{
                return append(newElement)
            }
         
           self.data.insert(newElement, at: at)
           return at
       }
       
       @discardableResult
       public mutating func update(_ newElement: T, at: Int) -> Bool {
           guard data[safeIndex: at] != nil else { return false }
           data[at] = newElement
           return true
       }
       
       @discardableResult
       public mutating func remove(at: Int) -> Bool {
           guard data[safeIndex: at] != nil else { return false }
           data.remove(at: at)
           return true
       }
       
       @discardableResult
       public mutating func append(contentsOf: [T]) -> [Int] {
           var index = [Int]()
           contentsOf.forEach { newElement in
              index.append(self.append(newElement))
           }
           return index
       }
}

extension Operatable where T:Operatable{
    
    
    @discardableResult
    public mutating func append(_ newElement: T.T, section:Int) -> IndexPath {
        let row = self.data[section].append(newElement)
        return IndexPath(row: row, section: section)
    }
    
    @discardableResult
    public mutating func append(contentsOf: [T.T], section:Int) -> [IndexPath] {
        let rows = self.data[section].append(contentsOf: contentsOf)
        return rows.compactMap{IndexPath(row: $0, section: section)}
    }
    
    @discardableResult
    public mutating func insert(_ newElement: T.T, at: Int?, section:Int) -> IndexPath {
        let row = self.data[section].insert(newElement, at: section)
        return IndexPath(row: row, section: section)
    }
    
    @discardableResult
    public mutating func update(_ newElement: T.T, at: Int, section:Int) -> IndexPath? {
        guard data[section].update(newElement, at: at) else{
            return nil
        }
        return IndexPath(row: at, section: section)
    }
    
    @discardableResult
    public mutating func remove(at: Int, section:Int) -> IndexPath? {
        guard data[section].remove(at: at) else{
            return nil
        }
        return IndexPath(row: at, section: section)
    }
}




extension Operatable where T:Identifiable{
    
    @discardableResult
    public mutating func remove(_ element: T) -> Int?{
        return self.data.remove(element)
    }
    
    @discardableResult
    public mutating func remove(_ identifier: String?) -> Int?{
        return self.data.remove(identifier)
    }
    
    @discardableResult
    public mutating func update(_ element:T) -> Int?{
        return self.data.update(element)
    }
    
    @discardableResult
    public mutating func update(_ elements:[T]) -> ([Int],[T])?{
        return self.data.update(elements)
    }
    
    @discardableResult
    public mutating func insert(_ elements:[T]) -> [Int]{
        return self.data.insert(elements)
    }
    
    @discardableResult
    public mutating func insert(_ element:T) -> Int{
        return self.data.insert(element)
    }
}

