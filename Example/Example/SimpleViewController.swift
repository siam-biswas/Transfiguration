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

    let service = Transfigurator<Table>(data: CountryService.objectList)

    override func viewDidLoad() {
        super.viewDidLoad()

        service.bind(tableView).view{ container, indexPath, data in
            
            let view:UITableViewCell = container.dequeue()
            view.textLabel?.text = data[indexPath.row].name
            view.accessoryType = .disclosureIndicator
            return view
            
        }.selection { [weak self] (container,indexPath,data) in
            
            let details = DetailsViewController(data: data[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
        

    }

}
