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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
       
        collectionView.bind(CountryService.objectList).configure(StackCell.self){ (view, container, indexPath, data) in
            
            view.setupData(data: data[indexPath.row])
            
        }.selection { [weak self] (container,indexPath,data) in
            
            let details = DetailsViewController(data: data[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
    }

}


