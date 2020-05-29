//
// PickerMapper.swift
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

open class PickerMapper<Data:Sectionable>: Mapper<UIView,UIPickerView,Data>{
    
    public typealias ContentTitle = (Container,IndexPath,Data) -> String
    public typealias ContentAttributedTitle = (Container,IndexPath,Data) -> NSAttributedString
    
    var _title:ContentTitle?
    var _attributedTitle:ContentAttributedTitle?

    
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
    open func title(_ content:ContentTitle?) -> Self{
        self._title = content
        return self
    }
    
    @discardableResult
    open func attributedTitle(_ content:ContentAttributedTitle?) -> Self{
        self._attributedTitle = content
        return self
    }
}
