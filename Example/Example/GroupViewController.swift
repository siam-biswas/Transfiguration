//
//  GroupViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 27/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

class GroupViewController: UITableViewController {


    override func viewDidLoad() {
       super.viewDidLoad()
        
       var data = Transfigurable<Section<Country>>()
    
        
       data.append(Section(identifier: "a", data: CountryService.getObjectList(prefix: "a"), header: "Country with \"A\""))
       data.append(Section(identifier: "b", data: CountryService.getObjectList(prefix: "b"), header: "Country with \"B\""))
       data.append(Section(identifier: "c", data: CountryService.getObjectList(prefix: "c"), header: "Country with \"C\""))
       data.append(Section(identifier: "d", data: CountryService.getObjectList(prefix: "d"), header: "Country with \"D\""))

       tableView.bind(data).configure{ view, container, indexPath, section in
        
            view.textLabel?.text = section[indexPath.row].name
            view.accessoryType = .disclosureIndicator
    
        }.selection { [weak self] (container,indexPath,section) in
            
            let details = DetailsViewController(data: section[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
        

    }

}
