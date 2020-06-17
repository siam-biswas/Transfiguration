//
// CollectionMapper.swift
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


open class CollectionMapper<Data:Sectionable>: Mapper<UICollectionViewCell,UICollectionView,Data>{
    
    public typealias ContentInset = (Container,Int,Data) -> UIEdgeInsets
    public typealias ContentSizingView = (Container,IndexPath,Data) -> UIView
    public typealias ContentScale = (Container,IndexPath,Data) -> UInt
    
    var _inset:ContentInset?
    var _sizingView:ContentSizingView?
    var _scale:ContentScale?
    
    @discardableResult
    open func view(_ content:@escaping ContentView) -> Self{
        _view = content
        return self
    }
    
    @discardableResult
    open func configure<T:UICollectionViewCell>(_ type:T.Type? = nil,content:@escaping (inout T,Container,IndexPath,Data) -> Void) -> Self{

           _view = { container,index,data in
               var view:T = container.dequeue(indexPath: index)
               content(&view,container,index,data)
               return view
           }
           return self
       }
    
    @discardableResult
    open func sizingView(_ content:@escaping ContentSizingView) -> Self{
        _sizingView = content
        return self
    }
    
    @discardableResult
    open func scale(_ content:@escaping ContentScale) -> Self{
        _scale = content
        return self
    }
    
    
    @discardableResult
    open func selection(_ content:@escaping Content) -> Self{
        self._selection = content
        return self
    }
    
    @discardableResult
    open func size(_ content:@escaping ContentSize) -> Self{
        self._size = content
        return self
    }
    
    @discardableResult
    open func header(_ content:@escaping ContentAccessoryView) -> Self{
        self._header = content
        return self
    }
    
    @discardableResult
    open func footer(_ content:@escaping ContentAccessoryView) -> Self{
        self._footer = content
        return self
    }
    
    
    @discardableResult
    open func inset(_ content:ContentInset?) -> Self{
        self._inset = content
        return self
    }
}
