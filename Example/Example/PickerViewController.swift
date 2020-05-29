//
//  PickerViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 27/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

class PickerViewController: UIViewController {

    let service = Transfigurator<Picker>(data: CountryService.objectList)
    
    let pickerView:UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()

        service.bind(pickerView).title { container, indexPath, section in
            return section[indexPath.row].name
        }
    }
    
    func setupLayout(){
        view.backgroundColor = UIColor.white
        view.addSubview(pickerView)
        pickerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

}


