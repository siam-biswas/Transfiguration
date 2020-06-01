//
// TablePresenter.swift
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

public class TablePresenter<Section: Sectionable>: Presenter<UITableViewDelegate,UITableViewDataSource,TableMapper<Section>>, UITableViewDataSource,UITableViewDelegate{
    
    fileprivate let queue = DispatchQueue(label: "sync.operation.table", attributes: .concurrent)

    public convenience init(provider:Provider<Section>,action:Actionable<Action>) {
        self.init()
        self.provider = provider
        self.action = action
        self.map = TableMapper()
    }
    
    public override func bind(_ provider:UITableView) -> Map{


        provider.delegate = self.delegate
        provider.dataSource = self.dataSource
        
        self.action.bind(observer: { [weak self] value in
            self?.queue.sync { [weak self] in
               self?.providerOperation(value: value, provider: provider)
            }
        })
        
        
       
        return self.map
    }
    
    func providerOperation(value:Action,provider:UITableView){
       
            switch value{
               case .reload:
                   provider.reloadData()
               case let .update(sections,indexPaths,animation):
                   provider.update(sections: IndexSet(sections), indexPaths: indexPaths,animation: animation)
               case let .delete(sections,indexPaths,animation):
                   provider.delete(sections: IndexSet(sections), indexPaths: indexPaths,animation: animation)
               case let .insert(sections,indexPaths,animation):
                   provider.add(sections: IndexSet(sections), indexPaths: indexPaths,animation: animation)
            }
        
    }
    

    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.provider.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.provider[header: section]
    }
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionData = self.provider.data[safeIndex: section] else{
            return nil
        }
        guard let view = map._header?(tableView,section,self.provider[header: section],sectionData) else{
            return nil
        }
         return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let data = self.provider.data[safeIndex: section] else{
            return CGFloat.zero
        }
    
        guard let height = map._headerHeight?(tableView,section,data) else{
            guard self.provider[header: section] != nil else {
                return CGFloat.zero
            }
            return UITableView.automaticDimension
        }
        return height
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.provider[footer: section]
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let sectionData = self.provider.data[safeIndex: section] else{
            return nil
        }
        guard let view = map._footer?(tableView,section,self.provider[footer: section],sectionData) else{
            return nil
        }
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let data = self.provider.data[safeIndex: section] else{
            return CGFloat.zero
        }
        guard let height = map._footerHeight?(tableView,section,data) else{
            guard self.provider[footer: section] != nil else {
                return CGFloat.zero
            }
            return UITableView.automaticDimension
        }
        return height
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.provider[count: section]
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return CGFloat.zero
        }
        guard let height = map._height?(tableView,indexPath,section) else{
            return UITableView.automaticDimension
        }
        return height
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            fatalError("Invalid section")
        }

        guard let view = map._view?(tableView,indexPath,section) else{
            fatalError("Cell is not configured")
        }
       
        return  view
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return
        }
        map._selection?(tableView,indexPath, section)
    }
    
    
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return
        }
        map._commitEditStyle?(tableView,indexPath, section,editingStyle)
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return false
        }
        return map._canEdit?(tableView,indexPath, section) ?? false
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return false
        }
        return map._canMove?(tableView,indexPath, section) ?? false
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return .none
        }
        return map._editStyle?(tableView,indexPath, section) ?? .none
    }
    
    
}
