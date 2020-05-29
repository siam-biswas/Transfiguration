//
//  ViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 14/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import UIKit
import Transfiguration



class ViewController: UITableViewController {
    
    let service = Transfigurator<Table>(data: Type.allCases)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transfiguration"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.tableFooterView = UIView()
        
        service.bind(tableView).view{ container, indexPath, data in
            
            let view:UITableViewCell = container.dequeue()
            view.textLabel?.text = data[indexPath.row].title
            view.accessoryType = .disclosureIndicator
            return view
            
        }.selection { [weak self] container,indexPath,data in
            data[indexPath.row].select(from: self)
        }
        
    }
    
}


enum Type:CaseIterable{
    
    case simple,group,waterfall,stack,grid,tag,card,compound,picker,todo
    
    var title:String{
        switch self {
        case .simple:
            return "Simple"
        case .stack:
            return "Stack"
        case .waterfall:
            return "Waterfall"
        case .compound:
            return "Composition"
        case .grid:
            return "Grid"
        case .tag:
            return "Tag"
        case .card:
            return "Card"
        case .group:
            return "Group"
        case .picker:
            return "Picker"
        case .todo:
            return "Todo"
        }
    }
    
    func navigate(_ from:UIViewController?,to:UIViewController){
      to.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      from?.navigationController?.pushViewController(to, animated: true)
    }
    
    
    func select(from:UIViewController?){
        switch self {
        case .simple:
            let controller = SimpleViewController()
            controller.title = self.title
            navigate(from, to: controller)
            
        case .group:
            let style:()->UITableView.Style = { if #available(iOS 13.0, *) { return .insetGrouped } else { return .grouped } }
            let controller = GroupViewController(style: style())
            controller.title = self.title
            navigate(from, to: controller)
            
        case .stack:
            let layout = UICollectionViewStackLayout()
            let controller = StackViewController(collectionViewLayout: layout)
            controller.title = self.title
            navigate(from, to: controller)
            
        case .waterfall:
            let layout = UICollectionViewWaterfallLayout()
            layout.numberOfColumns = 2
            let controller = WaterfallViewController(collectionViewLayout: layout)
            controller.title = self.title
            navigate(from, to: controller)
        
        case .compound:
            let controller = CompositionViewController()
            controller.title = self.title
            navigate(from, to: controller)
            
        case .grid:
            let layout = UICollectionViewGridLayout()
            let controller = GridViewController(collectionViewLayout: layout)
            controller.title = self.title
            navigate(from, to: controller)
            
        case .tag:
            let layout = UICollectionViewTagLayout()
            layout.scrollDirection = .vertical
            layout.itemHeight = 60
            let controller = TagViewController(collectionViewLayout: layout)
            controller.title = self.title
            navigate(from, to: controller)
            
        case .card:
            let layout = UICollectionViewCardLayout()
            let controller = CardViewController(collectionViewLayout: layout)
            controller.title = self.title
            navigate(from, to: controller)
            
        case .picker:
            let controller = PickerViewController()
            controller.title = self.title
            navigate(from, to: controller)
            
        case .todo:
            let style:()->UITableView.Style = { if #available(iOS 13.0, *) { return .insetGrouped } else { return .grouped } }
            let controller = TodoViewController(style: style())
            controller.title = self.title
            navigate(from, to: controller)
            
        }
    }
}





