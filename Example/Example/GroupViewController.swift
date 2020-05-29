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

    var service = Transfigurator<Table<Section<Country>>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.insert(section: Section(identifier: "a", data: CountryService.getObjectList(prefix: "a"), header: "Country with \"A\""))
        service.insert(section: Section(identifier: "b", data: CountryService.getObjectList(prefix: "b"), header: "Country with \"B\""))
        service.insert(section: Section(identifier: "c", data: CountryService.getObjectList(prefix: "c"), header: "Country with \"C\""))
        service.insert(section: Section(identifier: "d", data: CountryService.getObjectList(prefix: "d"), header: "Country with \"D\""))

        service.bind(tableView).view{ container, index, section in
            
            let view:UITableViewCell = container.dequeue()
            view.textLabel?.text = section[index.row].name
            view.accessoryType = .disclosureIndicator
            return view
            
        }.selection { [weak self] (container,index,section) in
            
            let details = DetailsViewController(data: section[index.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
        

    }

}
