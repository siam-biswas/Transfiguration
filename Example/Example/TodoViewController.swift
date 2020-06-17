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
    
    var data = Transfigurable(["Todo 1","Todo 2","Todo 3"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
        tableView.bind(data).configure{ view, container, indexPath, data in
            
            view.textLabel?.text = data[indexPath.row]
            
        }.canEdit { container, indexPath, data in
            return true
        }.editStyle { container, indexPath, data in
            return .delete
        }.commitEditStyle { [weak self] container, indexPath, data, style in
    
            guard style == .delete else { return }
            self?.data.removeItem(at: indexPath.row, section: indexPath.section)
            
        }.headerHeight { container, indexPath, data in
            return 20
        }
        
    }
    
    @objc func add(){
        let count = data[section: 0]?.count ?? 0
        data.appendItem("Todo \(count + 1)", section: 0)
    }
    
}


