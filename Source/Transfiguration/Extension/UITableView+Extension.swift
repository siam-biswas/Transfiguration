//
// UITableView+Extension.swift
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

public extension UITableView{
    
    func dequeue<T:UITableViewCell>(identifier:String? = nil,register:Bool = true) -> T{
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier ?? T.identifier) as? T else{
            self.register(T.self, forCellReuseIdentifier: identifier ?? T.identifier)
            return register ? dequeue(identifier: identifier,register: false) : T()
        }
        return cell
    }
    
    func add(sections:IndexSet?,indexPaths:[IndexPath]?,animation:Bool = true){
        
        if animation { self.beginUpdates() }
        
        if let indexPaths = indexPaths,indexPaths.count > 0{
            self.insertRows(at: indexPaths, with: .bottom)
        }
        
        if let sections = sections,sections.count > 0{
            self.insertSections(sections, with: .bottom)
        }
        
        if animation { self.endUpdates() }
        
    }
    
    func delete(sections:IndexSet?,indexPaths:[IndexPath]?,animation:Bool = true){
        
        if animation { self.beginUpdates() }
        
        if let indexPaths = indexPaths,indexPaths.count > 0{
            self.deleteRows(at: indexPaths, with: .top)
        }
        
        if let sections = sections,sections.count > 0{
            self.deleteSections(sections, with: .top)
        }
        
        if animation { self.endUpdates() }
    }
    
    func update(sections:IndexSet?,indexPaths:[IndexPath]?,animation:Bool = true){
        
        if animation { self.beginUpdates() }
        
        if let indexPaths = indexPaths,indexPaths.count > 0{
            self.reloadRows(at: indexPaths, with: .automatic)
        }
        
        if let sections = sections,sections.count > 0{
            self.reloadSections(sections, with: .automatic)
        }
        
        if animation { self.endUpdates() }
        
    }
}
