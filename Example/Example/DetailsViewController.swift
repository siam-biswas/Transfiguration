//
//  DetailsViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 26/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    private let providerView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
     private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let articleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var data:Country?
    
    convenience init(data:Country) {
        self.init()
        self.data = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        setupData(data: data)
    }
    
    
    var pictureHeight:NSLayoutConstraint?
    
   
    
    func setupData(data:Country?) {

        guard let data = data else { return }
        
        title = data.name
        
        self.titleLabel.text = data.name
        self.descriptionLabel.text = data.details
        self.articleLabel.text = data.article
        self.pictureView.image = data.image
        
        let ratio = data.image.size.width / data.image.size.height
        pictureHeight?.constant = 200 * ratio
    }
    
    private func setupView() {
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(providerView)
        providerView.addSubview(titleLabel)
        providerView.addSubview(descriptionLabel)
        providerView.addSubview(articleLabel)
        providerView.addSubview(pictureView)
        
    }
    
    private func setupLayout() {
        
        providerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        providerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        providerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        providerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
        pictureView.centerXAnchor.constraint(equalTo: providerView.centerXAnchor).isActive = true
        pictureView.topAnchor.constraint(equalTo: providerView.topAnchor).isActive = true
        pictureView.leftAnchor.constraint(equalTo: providerView.leftAnchor).isActive = true
        pictureView.rightAnchor.constraint(equalTo: providerView.rightAnchor).isActive = true
        pictureHeight = pictureView.heightAnchor.constraint(equalToConstant: 200)
        pictureHeight?.isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: providerView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        descriptionLabel.centerXAnchor.constraint(equalTo: providerView.centerXAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -20).isActive = true
        
        articleLabel.centerXAnchor.constraint(equalTo: providerView.centerXAnchor).isActive = true
        articleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        articleLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 20).isActive = true
        articleLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -20).isActive = true
        articleLabel.bottomAnchor.constraint(equalTo: providerView.bottomAnchor, constant: -20).isActive = true
        
    }
    

}
