//
//  StackViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 26/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

class StackViewController: UICollectionViewController {
    
    let service = Transfigurator<Collection>(data: CountryService.objectList)

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white

       
        service.bind(collectionView).view{ container, indexPath, section in
            
            let view:StackCell = container.dequeue(indexPath: indexPath)
            view.setupData(data: section[indexPath.row])
            return view
            
        }.selection { [weak self] (container,indexPath,section) in
            
            let details = DetailsViewController(data: section[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
    }

}

class StackCell: UICollectionViewCell {
    
    
     let providerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.clipsToBounds = true
           return view
       }()
       
       private let titleLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.boldSystemFont(ofSize: 16)
           label.textAlignment = .left
           label.numberOfLines = 1
           label.lineBreakMode = .byTruncatingTail
           return label
       }()
       
        private let descriptionLabel: UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont.systemFont(ofSize: 14)
           label.textAlignment = .left
           label.numberOfLines = 1
           label.lineBreakMode = .byTruncatingTail
           return label
       }()
       
       private let pictureView: UIImageView = {
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
       
       func setupData(data:Country) {

           
           self.titleLabel.text = data.name
           self.descriptionLabel.text = data.details
           self.pictureView.image = data.image
           
       }
       
       private func setupView() {
           
           
           backgroundColor = UIColor.white
           providerView.layer.cornerRadius = 8
           layer.cornerRadius = 8
           layer.backgroundColor = UIColor.white.cgColor
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOffset = CGSize(width: 0, height: 1.0)
           layer.shadowOpacity = 0.2
           layer.shadowRadius = 4
           
           addSubview(providerView)
           providerView.addSubview(titleLabel)
           providerView.addSubview(descriptionLabel)
           providerView.addSubview(pictureView)
           
       }
       
       private func setupLayout() {
           
           providerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
           providerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
           providerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
           providerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
          
           pictureView.topAnchor.constraint(equalTo: providerView.topAnchor).isActive = true
           pictureView.leftAnchor.constraint(equalTo: providerView.leftAnchor).isActive = true
           pictureView.rightAnchor.constraint(equalTo: providerView.rightAnchor).isActive = true
        
           
           titleLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 20).isActive = true
           titleLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 20).isActive = true
           titleLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -20).isActive = true
           titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
           
           descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
           descriptionLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 20).isActive = true
           descriptionLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -20).isActive = true
           descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
           descriptionLabel.bottomAnchor.constraint(equalTo: providerView.bottomAnchor, constant: -20).isActive = true
           
       }
    

}

