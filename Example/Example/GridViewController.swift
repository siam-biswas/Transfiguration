//
//  GridViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 26/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

class GridViewController: UICollectionViewController {
    
    let service = Transfigurator<Collection>(data: CountryService.objectList)

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white
       
        service.bind(collectionView).view{ (container, indexPath, data) in
            
            let view:ImageCell = container.dequeue(indexPath: indexPath)
            view.setupData(data: data[indexPath.row].image)
            return view
            
        }.scale { (container,indexPath,data) in
            
            if indexPath.row % 2 == 0 || indexPath.row % 5 == 0 || indexPath.row % 8 == 0 { return 2 }
            if indexPath.row % 3 == 0 || indexPath.row % 7 == 0 { return 4 }
            return 1

        }.selection { [weak self] (container,indexPath,data) in
            
            let details = DetailsViewController(data: data[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
    }

}


class ImageCell: UICollectionViewCell {
    
    
    private lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data:UIImage) {
        self.pictureView.image = data
    }
    
    func setupShadow(){
        pictureView.layer.cornerRadius = 8
               
               layer.cornerRadius = 8
               layer.backgroundColor = UIColor.white.cgColor
               layer.shadowColor = UIColor.black.cgColor
               layer.shadowOffset = CGSize(width: 0, height: 1.0)
               layer.shadowOpacity = 0.2
               layer.shadowRadius = 4
    }
    
    private func setupView() {
        
        backgroundColor = UIColor.white
       
        
        self.addSubview(pictureView)
        
    }
    
    private func setupLayout() {
        
        
        pictureView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pictureView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        pictureView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    
}


