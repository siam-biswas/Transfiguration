//
//  GravityViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 26/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

class CardViewController: UICollectionViewController {
    
    let service = Transfigurator<Collection>(data: CountryService.objectList)

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
       
        service.bind(collectionView).view{ (container, indexPath, data) in
            
            let view:StackCell = container.dequeue(indexPath: indexPath)
            view.setupData(data: data[indexPath.row])
            return view
            
        }.selection { [weak self] (container,indexPath,data) in
            
            let details = DetailsViewController(data: data[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
    }

}


