//
// Array+Extension.swift
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

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}

extension Array:Sectionable{
    
    public var header: String? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    public var footer: String? {
        get {
            return nil
        }
        set {
            
        }
    }
    
    
    
}

extension Array:Operatable{
    public var data: [Element] {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
}



public extension Array where Element:Identifiable{
    
    
    @discardableResult
    mutating func remove(_ element: Element) -> Int?{
        
        guard let index = self.firstIndex(of: element) else{
            return nil
        }
        self.remove(at: index)
        return index
    }
    
    @discardableResult
    mutating func remove(_ identifier: String?) -> Int?{
        
        guard identifier != nil else {
            return nil
        }
        
        guard let index = self.firstIndex(where: {$0.identifier == identifier}) else{
            return nil
        }
        self.remove(at: index)
        return index
    }
    
    @discardableResult
    mutating  func update(_ element:Element) -> Int?{
        
        guard let index = self.firstIndex(of: element) else{
            return nil
        }
        
        self[index] = element
        return index
    }
    
    @discardableResult
    mutating  func update(_ elements:[Element]) -> ([Int],[Element])?{
        var updates = [Int]()
        var inserts = [Element]()
        
        elements.forEach{ element in
            guard let index = self.update(element) else{
                inserts.append(element)
                return
            }
            updates.append(index)
        }
        
        return updates.isEmpty ? nil : (updates,inserts)
    }
    
    @discardableResult
    mutating func insert(_ elements:[Element]) -> [Int]{
        
        var index = [Int]()
        
        elements.forEach{ element in
            index.append(self.insert(element))
        }
        
        return index
    }
    
    @discardableResult
    mutating func insert(_ element:Element) -> Int{
        
        guard let priority = element.priority else {
            self.append(element)
            return self.count - 1
        }
        
        var returnIndex:Int?
        
        for (index,item) in self.enumerated(){
            guard let itemPriority = item.priority, priority < itemPriority  else {
                continue
            }
            
            self.insert(element, at: index)
            returnIndex = index
            break
        }
        
        
        guard let check = returnIndex else{
            self.append(element)
            return self.count - 1
        }
        
        return check
        
    }
}
