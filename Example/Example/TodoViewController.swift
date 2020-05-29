//
//  TodoViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 27/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration


class TodoViewController: UITableViewController {
    
    var service = Transfigurator<Table>(data: ["Todo 1","Todo 2","Todo 3"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        service.bind(tableView).view{ container, index, section in
            
            let view:UITableViewCell = container.dequeue()
            view.textLabel?.text = section[index.row]
            return view
            
        }.canEdit { container, index, section in
            return true
        }.editStyle { container, index, section in
            return .delete
        }.commitEditStyle { [weak self] container, index, section, style in
    
            guard style == .delete else { return }
            self?.service.delete(at: index.row, section: index.section)
            
        }.headerHeight { container, index, section in
            return 20
        }
        
    }
    
    @objc func add(){
        let count = service[section: 0]?.count ?? 0
        service.append(item: "Todo \(count + 1)", section: 0)
    }
    
}


