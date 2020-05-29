//
// Mapper.swift
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
import UIKit

public protocol Mapable {
    
    associatedtype View
    associatedtype Container
    associatedtype Data:Sectionable
    
    init()
}

open class Mapper<View,Container,Data:Sectionable>:Mapable{

    public typealias ContentView = (Container,IndexPath,Data) -> View
    public typealias ContentAccessoryView = (Container,Int,String?,Data) -> UIView?
    public typealias Content = (Container,IndexPath,Data) -> Void
    public typealias ContentSize = (Container,IndexPath,Data) -> CGSize
    public typealias ContentHeight = (Container,IndexPath,Data) -> CGFloat
    public typealias ContentAccessorySize = (Container,Int,Data) -> CGSize
    public typealias ContentAccessoryHeight = (Container,Int,Data) -> CGFloat
    
    var _selection:Content?
    var _height:ContentHeight?
    var _size:ContentSize?
    var _view:ContentView?
    
    var _header:ContentAccessoryView?
    var _headerSize:ContentAccessorySize?
    var _headerHeight:ContentAccessoryHeight?
    
    var _footer:ContentAccessoryView?
    var _footerSize:ContentAccessorySize?
    var _footerHeight:ContentAccessoryHeight?
    
    
    required public init() { }
    
}


