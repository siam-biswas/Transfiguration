//
// PickerPresenter.swift
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

public class PickerPresenter<Section: Sectionable>: Presenter<UIPickerViewDelegate,UIPickerViewDataSource,PickerMapper<Section>>,
UIPickerViewDelegate,UIPickerViewDataSource{
    
    fileprivate let queue = DispatchQueue(label: "sync.operation.picker", attributes: .concurrent)

    convenience init(provider:Provider<Section>) {
        self.init()
        self.provider = provider
    }
    
    public override func bind(_ provider:UIPickerView) -> Map{


        provider.delegate = self.delegate
        provider.dataSource = self.dataSource
        
        self.action.bind(observer: { [weak self] value in
            self?.queue.sync { [weak self] in
               self?.providerOperation(value: value, provider: provider)
            }
        })
        
        
       
        return self.map
    }
    
    func providerOperation(value:Action,provider:UIPickerView){
          
               switch value{
                  case .reload,.delete,.insert:
                      provider.reloadAllComponents()
                  case let .update(sections,_,_):
                      sections.forEach{ provider.reloadComponent($0)}
               }
           
       }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.provider.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.provider[count: component]
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        guard let section = self.provider.data[safeIndex: component] else{
            return CGFloat.zero
        }
        guard let size = map._size?(pickerView,IndexPath(row: 0, section: component),section) else{
            return 40
        }
        return size.height
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let section = self.provider.data[safeIndex: component] else{
            return
        }
        map._selection?(pickerView,IndexPath(row: row, section: component), section)
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let section = self.provider.data[safeIndex: component] else{
            return nil
        }
        
        return map._title?(pickerView,IndexPath(row: row, section: component), section)
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        guard let section = self.provider.data[safeIndex: component] else{
            return nil
        }
        guard let attributed = map._attributedTitle?(pickerView,IndexPath(row: row, section: component), section) else{
            guard let title = map._title?(pickerView,IndexPath(row: row, section: component), section) else{
                return nil
            }
            return NSAttributedString(string: title)
        }
        return attributed
        
    }
    

}
