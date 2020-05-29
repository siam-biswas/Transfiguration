//
// Section.swift
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

public protocol Sectionable{
    
    var header:String? { get set }
    var footer:String? { get set }
    var count:Int { get }
}

public extension Sectionable{
   var header: String?{
      get { return nil } set { }
   }
    
   var footer: String?{
      get { return nil } set { }
   }
}



public class Section<T>: Sectionable,Identifiable,Operatable{

    public var identifier: String
    public var priority: Int?
    
    public var header:String?
    public var footer:String?
    
    public var count: Int{
      return data.count
    }
    
    public var data: [T]
    
    public convenience init(identifier: String,data:[T]) {
        self.init(identifier: identifier,data: data, header: nil, footer: nil, priority: nil)
    }
    
    public convenience init(identifier: String,data:[T] = [],header:String?) {
       self.init(identifier: identifier,data: data, header: header, footer: nil, priority: nil)
    }
    
    public convenience init(identifier: String,data:[T] = [],header:String? = nil,footer:String?) {
       self.init(identifier: identifier,data: data, header: header, footer: footer, priority: nil)
    }
    
    public init(identifier: String,data:[T] = [],header:String? = nil,footer:String? = nil,priority: Int? = nil) {
        self.data = data
        self.header = header
        self.footer = footer
        self.identifier = identifier
        self.priority = priority
    }
    

}


