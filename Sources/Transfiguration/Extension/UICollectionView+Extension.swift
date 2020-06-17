//
// UICollectionView+Extension.swift
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

private var key: Void? = nil

public extension UICollectionView{
    
    var transfigurable: Any? {
          get { return objc_getAssociatedObject(self, &key) ?? nil }
          set { objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    func bind<T:Sectionable>(_ data:T) -> CollectionMapper<T>{
        
        let transfigurable = Transfigurable(data)
        let presenter:CollectionPresenter<T> = CollectionPresenter(provider: transfigurable.provider, action: transfigurable.action)
        transfigurable.presenter = presenter
        self.transfigurable = transfigurable
        return presenter.bind(self)
    }
    
    func bind<T:Sectionable>(_ data:Transfigurable<T>) -> CollectionMapper<T>{
           let presenter:CollectionPresenter<T> = CollectionPresenter(provider: data.provider, action: data.action)
           data.presenter = presenter
           return presenter.bind(self)
       }
    
    func dequeue<T:UICollectionViewCell>(indexPath:IndexPath,identifier:String? = nil,register:Bool = true) -> T{
        self.register(T.self, forCellWithReuseIdentifier: identifier ?? T.identifier)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier:  identifier ?? T.identifier, for: indexPath) as? T else{
            return T()
        }
        return cell
    }
    
    func add(sections:IndexSet?,indexPaths:[IndexPath]?,animation:Bool){
        
        if animation{
            self.performBatchUpdates({
                self.add(sections: sections, indexPaths: indexPaths)
            })
        }
        
        self.add(sections: sections, indexPaths: indexPaths)
        
    }
    
    func add(sections:IndexSet?,indexPaths:[IndexPath]?){
        
        if let indexPaths = indexPaths,indexPaths.count > 0{
            self.insertItems(at: indexPaths)
        }
        
        if let sections = sections,sections.count > 0{
            self.insertSections(sections)
        }
        
    }
    
    func delete(sections:IndexSet?,indexPaths:[IndexPath]?,animation:Bool){
        
        if animation{
            self.performBatchUpdates({
                self.delete(sections: sections, indexPaths: indexPaths)
            })
        }
        
        self.delete(sections: sections, indexPaths: indexPaths)
        
    }
    
    func delete(sections:IndexSet?,indexPaths:[IndexPath]?){
        
        
        if let indexPaths = indexPaths,indexPaths.count > 0{
            self.deleteItems(at: indexPaths)
        }
        
        if let sections = sections,sections.count > 0{
            self.deleteSections(sections)
        }
        
    }
    
    func update(sections:IndexSet?,indexPaths:[IndexPath]?,animation:Bool){
        
        
        if animation{
            self.performBatchUpdates({
                self.update(sections: sections, indexPaths: indexPaths)
            })
        }
        
        self.update(sections: sections, indexPaths: indexPaths)
        
        
    }
    
    func update(sections:IndexSet?,indexPaths:[IndexPath]?){
        
        
        if let indexPaths = indexPaths,indexPaths.count > 0{
            self.reloadItems(at: indexPaths)
        }
        
        if let sections = sections,sections.count > 0{
            self.reloadSections(sections)
        }
        
        
    }
}


