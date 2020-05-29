//
// Presenter.swift
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

public protocol Presentable {
    
    associatedtype Delegate
    associatedtype DataSource
    associatedtype Map:Mapable
    
    var action:Actionable<Action>! {get set}
    var provider: Provider<Map.Data>! {get set}
    var map: Map! {get set}
    
     
    var delegate: Delegate {get}
    var dataSource: DataSource {get}
    
    func bind(_ provider:Map.Container) -> Map
}

public class Presenter<Delegate,DataSource,Map:Mapable>: NSObject, Presentable{
    

    public var action: Actionable<Action>!
    public var provider: Provider<Map.Data>!
    public var map: Map!
    
    public var delegate: Delegate {
       guard let delegate = self as? Delegate else {
           fatalError("delegate not seted properly")
       }
        
       return delegate
    }
    
    
    public var dataSource: DataSource {
        guard let dataSource = self as? DataSource else {
            fatalError("dataSource not seted properly")
        }
        
        return dataSource
    }
    
    
    public convenience init(provider:Provider<Map.Data>,action:Actionable<Action>) {
        self.init()
        self.provider = provider
        self.action = action
        self.map = Map()
    }
    
    @discardableResult
    open func bind(_ provider: Map.Container) -> Map {
        return self.map
    }
    
}




