//
// TableMapper.swift
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

public class TableMapper<Data:Sectionable>: Mapper<UITableViewCell,UITableView,Data>{
    
    public typealias ContentBool = (Container,IndexPath,Data) -> Bool
    public typealias ContentEditStyle = (Container,IndexPath,Data) -> UITableViewCell.EditingStyle
    public typealias ContentCommitEditStyle = (Container,IndexPath,Data,UITableViewCell.EditingStyle) -> Void

    
    var _canEdit:ContentBool?
    var _canMove:ContentBool?
    var _editStyle:ContentEditStyle?
    var _commitEditStyle:ContentCommitEditStyle?
    
    @discardableResult
    open func commitEditStyle(_ content:@escaping ContentCommitEditStyle) -> Self{
        _commitEditStyle = content
        return self
    }
    
    @discardableResult
    open func editStyle(_ content:@escaping ContentEditStyle) -> Self{
        _editStyle = content
        return self
    }
    
    @discardableResult
    open func canEdit(_ content:@escaping ContentBool) -> Self{
        _canEdit = content
        return self
    }
    
    @discardableResult
    open func canMove(_ content:@escaping ContentBool) -> Self{
        _canMove = content
        return self
    }
    
    @discardableResult
    open func view(_ content:@escaping ContentView) -> Self{
        _view = content
        return self
    }
    
    @discardableResult
    open func configure<T:UITableViewCell>(_ type:T.Type? = nil,content:@escaping (inout T,Container,IndexPath,Data) -> Void) -> Self{
        
        _view = { container,index,data in
            var view:T = container.dequeue()
            content(&view,container,index,data)
            return view
        }
        return self
    }
    
    
    @discardableResult
    open func selection(_ content:@escaping Content) -> Self{
        self._selection = content
        return self
    }
    
    @discardableResult
    open func height(_ content:@escaping ContentHeight) -> Self{
        self._height = content
        return self
    }
    
    @discardableResult
    open func footerHeight(_ content:@escaping ContentAccessoryHeight) -> Self{
        self._footerHeight = content
        return self
    }
    
    @discardableResult
    open func headerHeight(_ content:@escaping ContentAccessoryHeight) -> Self{
        self._headerHeight = content
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
    
}
