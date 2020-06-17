//
//  SimpleViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 23/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

class SimpleViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.bind(CountryService.objectList).configure{ view, container, indexPath, data in
            
            view.textLabel?.text = data[indexPath.row].name
            view.accessoryType = .disclosureIndicator
            
        }.selection { [weak self] (container,indexPath,data) in
            
            let details = DetailsViewController(data: data[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
        

    }

}
