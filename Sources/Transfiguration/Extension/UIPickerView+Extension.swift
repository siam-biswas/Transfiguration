//
//  UIPickerView+Extension.swift
//  Transfiguration
//
//  Created by Md. Siam Biswas on 14/6/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit

private var key: Void? = nil

public extension UIPickerView{
    
    var transfigurable: Any? {
          get { return objc_getAssociatedObject(self, &key) ?? nil }
          set { objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    
    func bind<T:Sectionable>(_ data:T) -> PickerMapper<T>{
        
        let transfigurable = Transfigurable(data)
        let presenter:PickerPresenter<T> = PickerPresenter(provider: transfigurable.provider, action: transfigurable.action)
        transfigurable.presenter = presenter
        self.transfigurable = transfigurable
        return presenter.bind(self)
    }
    
    func bind<T:Sectionable>(_ data:Transfigurable<T>) -> PickerMapper<T>{
        let presenter:PickerPresenter<T> = PickerPresenter(provider: data.provider, action: data.action)
        data.presenter = presenter
        return presenter.bind(self)
    }
}
