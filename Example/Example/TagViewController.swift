//
//  TagViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 26/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

class TagViewController: UICollectionViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white

       
        collectionView.bind(CountryService.objectList).configure(TagCell.self){ view, container, indexPath, data in
        
            view.setupData(data: data[indexPath.row])
            
        }.sizingView{ container, indexPath, data in
            
            let view = TagCell.sizing
            view.setupData(data: data[indexPath.row])
            return view.providerView
            
        }.inset { (container,indexPath,data) in
            
            return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
            
        }.selection { [weak self] (container,indexPath,data) in
            
            let details = DetailsViewController(data: data[indexPath.row])
            self?.navigationController?.pushViewController(details, animated: true)
            
        }
        
    }

}


class TagCell: UICollectionViewCell {
    
    static let sizing = TagCell(frame: CGRect.zero)
    
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
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    var pictureHeight:NSLayoutConstraint?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data:Country) {
        
        self.titleLabel.text = data.name
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
    }
    
    private func setupLayout() {
        
        providerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        providerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        providerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        providerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: providerView.topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -5).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: providerView.bottomAnchor, constant: -5).isActive = true
        
    }
    
    
}
