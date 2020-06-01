//
// Transfigurator.swift
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

public struct Transfigurator<Type:Adaptable> {
    
    var provider:Provider<Type.Section>
    var presenter:Type.Presenter
    var action : Actionable<Action> = Actionable()
    
    public var map:Type.Presenter.Map{
        return self.presenter.map
    }
    
    public subscript(section at: Int) -> Type.Section? {
        return provider.data[safeIndex: at]
    }
    
    public init(){
        self.provider = Provider(data: [])
        self.presenter = Type(provider: self.provider,action: self.action).presenter
    }
    
    public init(data:[Type.Section]){
        self.provider = Provider(data: data)
        self.presenter = Type(provider: self.provider,action: self.action).presenter
    }
    
    public init(data:Type.Section){
        self.provider = Provider(data: [data])
        self.presenter = Type(provider: self.provider,action: self.action).presenter
    }
   
    
    @discardableResult
    public func bind(_ provider: Type.Presenter.Map.Container) -> Type.Presenter.Map{
        return self.presenter.bind(provider)
    }
    
    public mutating func clear(){
        self.provider.data.removeAll()
        self.action.value = .reload
    }
    
    mutating func insert(sections:[Int] = [],indexPaths:[IndexPath] = [],animation:Bool,reload:Bool){
        self.action.value = reload ? .reload : .insert(sections,indexPaths,animation)
    }
    
    mutating func update(sections:[Int]  = [],indexPaths:[IndexPath] = [],animation:Bool,reload:Bool){
        self.action.value = reload ? .reload : .update(sections,indexPaths,animation)
    }
    
    mutating func delete(sections:[Int] = [],indexPaths:[IndexPath] = [],animation:Bool,reload:Bool){
        self.action.value = reload ? .reload : .delete(sections,indexPaths,animation)
    }
    
}

extension Transfigurator where Type.Section: Identifiable{
    
    
    public mutating func insert(section: Type.Section,animation:Bool = false,reload:Bool = false){
        if let update = self.provider.update(section){
            let sections =  [update]
            self.update(sections: sections, animation: animation, reload: reload)
            return
        }
        let sections = [self.provider.insert(section)]
        self.insert(sections: sections, animation: animation, reload: reload)
    }
    
    public mutating func insert(sections: [Type.Section],animation:Bool = true,reload:Bool = false){
          
        if let updates = self.provider.update(sections){
             self.update(sections: updates.0, animation: animation, reload: reload)
            
            if updates.1.count > 0{
                let sections = self.provider.insert(updates.1)
                 self.insert(sections: sections, animation: animation, reload: reload)
            }
            
            return
        }
       let sections = self.provider.insert(sections)
         self.insert(sections: sections, animation: animation, reload: reload)
          
    }
    
    public mutating func delete(section: Type.Section,animation:Bool = true,reload:Bool = false){
           
        guard let section = self.provider.remove(section) else { return }
        self.delete(sections: [section], animation: animation, reload: reload)
    }
    
    public mutating func delete(section identifier: String,animation:Bool = true,reload:Bool = false){
           
        guard let section = self.provider.remove(identifier) else { return }
        self.delete(sections: [section], animation: animation, reload: reload)
    }
}


extension Transfigurator where Type.Section: Operatable{
    
    public mutating func append(section: Type.Section,animation:Bool = false,reload:Bool = false){
        let sections = [self.provider.append(section)]
        self.insert(sections: sections, animation: animation, reload: reload)
    }
    
    public mutating func insert(section: Type.Section,at:Int?,animation:Bool = false,reload:Bool = false){
        let sections = [self.provider.insert(section, at: at)]
        self.insert(sections: sections, animation: animation, reload: reload)
    }
    
    public mutating func append(sections: [Type.Section],animation:Bool = true,reload:Bool = false){
        let sections = self.provider.append(contentsOf: sections)
        self.insert(sections: sections, animation: animation, reload: reload)
    }
    
    public mutating func update(section: Type.Section,at: Int,animation:Bool = true,reload:Bool = false){
        guard self.provider.update(section, at: at) else { return }
        self.delete(sections: [at], animation: animation, reload: reload)
    }
    
    public mutating func delete(at: Int,animation:Bool = true,reload:Bool = false){
        guard self.provider.remove(at: at) else { return }
        self.delete(sections: [at], animation: animation, reload: reload)
    }
    
    public mutating func append(item:Type.Section.T, section:Int,animation:Bool = true,reload:Bool = false){
         let indexPath = self.provider.append(item, section: section)
         self.insert(indexPaths: [indexPath], animation: animation, reload: reload)
    }
    
    public mutating func insert(item:Type.Section.T, at: Int?, section:Int,animation:Bool = true,reload:Bool = false){
        let indexPath = self.provider.insert(item, at: at, section: section)
        self.insert(indexPaths: [indexPath], animation: animation, reload: reload)
    }
    
    public mutating func update(item: Type.Section.T,at: Int, section:Int,animation:Bool = true,reload:Bool = false){
        guard let indexPath = self.provider.update(item, at: at, section: section) else { return }
        self.update(indexPaths: [indexPath], animation: animation, reload: reload)
    }

    public mutating func delete(at: Int, section:Int,animation:Bool = true,reload:Bool = false){
        guard let indexPath = self.provider.remove(at: at, section: section) else { return }
        self.delete(indexPaths: [indexPath], animation: animation, reload: reload)
    }
  
}

