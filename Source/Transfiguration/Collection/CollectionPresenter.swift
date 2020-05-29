//
// CollectionPresenter.swift
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

public class CollectionPresenter<Section:Sectionable>: Presenter<UICollectionViewDelegate,UICollectionViewDataSource,CollectionMapper<Section>>,
UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    fileprivate let queue = DispatchQueue(label: "sync.operation.collection", attributes: .concurrent)
    
    convenience init(provider:Provider<Section>) {
        self.init()
        self.provider = provider
    }
    
    public override func bind(_ provider:UICollectionView) -> Map{
        
        provider.delegate = self.delegate
        provider.dataSource = self.dataSource
        
        _ = provider.numberOfSections
        
        
        self.action.bind(observer: { [weak self] (value) in
            self?.queue.sync { [weak self] in
                self?.providerOperation(value: value, provider: provider, animation: true)
            }
        })
        
        if let layout = provider.collectionViewLayout as? UICollectionViewWaterfallLayout {
            layout._sizingView = { [weak self] provider,indexPath in
                guard let section = self?.provider.data[safeIndex: indexPath.section] else{ return nil }
                return self?.map._sizingView?(provider,indexPath,section)
            }
        }
        
        
        if let layout = provider.collectionViewLayout as? UICollectionViewTagLayout {
            map._size = { [weak self] provider,indexPath,section in
                return layout.calculateSize(view: self?.map._sizingView?(provider,indexPath,section), inset: self?.map._inset?(provider,indexPath.section,section))
            }
        }
        
        if provider.collectionViewLayout is UICollectionViewCardLayout {
            
            provider.isPagingEnabled = true
            provider.showsHorizontalScrollIndicator = false
            provider.showsVerticalScrollIndicator = false
            
        }
        
        
        
        if let layout = provider.collectionViewLayout as? UICollectionViewGridLayout {
            layout.scaleBlock = { [weak self] provider,indexPath in
                guard let section = self?.provider.data[safeIndex: indexPath.section] else{ return 1 }
                return self?.map._scale?(provider,indexPath,section) ?? 1
            }
        }
        
        return self.map
    }
    
    func providerOperation(value:Action,provider:UICollectionView,animation:Bool){
        
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
    
    func dynamicHeight(container:UICollectionView,section:Int,data:Section,view:UIView) -> CGSize{
        
        var width = container.bounds.width - (container.contentInset.left + container.contentInset.right)
        
        if let inset = map._inset?(container, section, data){
            width = width - (inset.left + inset.right)
        }
        
        var referenceSize = UIView.layoutFittingCompressedSize
        referenceSize.width = width
        
        return view.systemLayoutSizeFitting(referenceSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
    
    func dynamicWidth(container:UICollectionView,section:Int,data:Section,view:UIView) -> CGSize{
        
        var height = container.bounds.width - (container.contentInset.top + container.contentInset.bottom)
        
        if let inset = map._inset?(container, section, data){
            height = height - (inset.top + inset.bottom)
        }
        
        var referenceSize = UIView.layoutFittingCompressedSize
        referenceSize.height = height
        
        return view.systemLayoutSizeFitting(referenceSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.provider[count: section]
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            fatalError("Invalid section")
        }
        
        guard let view = map._view?(collectionView,indexPath,section) else{
            fatalError("Cell is not configured")
        }
        
        return  view
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return
        }
        map._selection?(collectionView,indexPath, section)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let section = self.provider.data[safeIndex: indexPath.section] else{
            return CGSize.zero
        }
        guard let size = map._size?(collectionView,indexPath,section) else{
            
            guard let view = map._sizingView?(collectionView,indexPath,section),let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else{
                return CGSize.zero
            }
            
            if layout.scrollDirection == .vertical {
                return dynamicHeight(container: collectionView, section: indexPath.section, data: section, view: view)
            }else{
                return dynamicWidth(container: collectionView, section: indexPath.section, data: section, view: view)
            }
           
        }
        return size
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let data = self.provider.data[safeIndex: section] else{
            return UIEdgeInsets.zero
        }
        guard let size = map._inset?(collectionView,section,data) else{
            return UIEdgeInsets.zero
        }
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            guard let sectionData = self.provider.data[safeIndex: indexPath.section],let view = map._header?(collectionView,indexPath.section,self.provider[header: indexPath.section],sectionData) as? UICollectionReusableView else{
                return UICollectionReusableView()
            }
            
            return view
        }else if kind == UICollectionView.elementKindSectionFooter{
            guard let sectionData = self.provider.data[safeIndex: indexPath.section],let view = map._footer?(collectionView,indexPath.section,self.provider[header: indexPath.section],sectionData) as? UICollectionReusableView else{
                return UICollectionReusableView()
            }
            
            return view
        }else{
            return UICollectionReusableView()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let data = self.provider.data[safeIndex: section] else{
            return CGSize.zero
        }
        
        guard let size = map._footerSize?(collectionView,section,data) else{
            guard self.provider[header: section] != nil else {
                return CGSize.zero
            }
            return CGSize.zero
        }
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let data = self.provider.data[safeIndex: section] else{
            return CGSize.zero
        }
        
        guard let size = map._headerSize?(collectionView,section,data) else{
            guard self.provider[header: section] != nil else {
                return CGSize.zero
            }
            return CGSize.zero
        }
        return size
    }
    
}


