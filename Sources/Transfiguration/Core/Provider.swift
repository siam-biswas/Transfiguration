//
// Provider.swift
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
import CoreGraphics

public protocol Providable{
    
    associatedtype Section:Sectionable
    
    var data:[Section] { get set}
    var count:Int { get }
    
    subscript(count at: Int) -> Int { get }
    subscript(header at: Int) -> String? { get set }
    subscript(footer at: Int) -> String? { get set }
}

public class Provider<T:Sectionable>: Providable,Operatable{
    
    public var data =  [T]()
    
    public var count: Int{
        return self.data.count
    }
    
    init(data:[T]){
        self.data = data
    }
    
    public subscript(count at: Int) -> Int {
        guard let section = data[safeIndex: at] else { return 0 }
        return section.count
    }
    
    public subscript(header at: Int) -> String? {
        get {
            return data[safeIndex: at]?.header
        }
        set {
            guard data[safeIndex: at] != nil else { return }
            data[at].header = newValue
        }
    }
    
    public subscript(footer at: Int) -> String? {
        get {
            return data[safeIndex: at]?.footer
        }
        set {
            guard data[safeIndex: at] != nil else { return }
            data[at].footer = newValue
        }
    }
    
}



