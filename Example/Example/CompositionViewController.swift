//
//  CompositionViewController.swift
//  Example
//
//  Created by Md. Siam Biswas on 23/5/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Transfiguration

enum CompositionSections:Sectionable{
    
    case images
    case tags
    case articles([Country])
    
    var count:Int {
        switch self {
        case .images:
            return 1
        case .tags:
            return 1
        case .articles(let data):
            return data.count
        }
    }
}

class CompositionViewController: UITableViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        setupComposition()
    }
    
    func setupComposition(){
        
        let data = Transfigurable<CompositionSections>([.images,.tags,.articles(CountryService.getObjectList(prefix: "c"))])
        
        tableView.bind(data).view{ container, indexPath, data in
            
            switch data{
                
            case .images:
                let view:ImagesCell = container.dequeue()
                view.details = { [weak self] in self?.details(data: $0) }
                return view
            case .tags:
                let view:TagsCell = container.dequeue()
                view.details = { [weak self] in self?.details(data: $0) }
                return view
                
            case .articles(let data):
                let view:ArticleCell = container.dequeue()
                view.setupData(data: data[indexPath.row])
                return view
                
            }
            
        }.height { container, indexPath, data in
            
            switch data {
                
            case .articles:
                return UITableView.automaticDimension
            case .images:
                return 180
            case .tags:
                return 60
            }
            
        }.selection { [weak self] (container,indexPath,data) in
            
            switch data{
            case .articles(let data):
                self?.details(data: data[indexPath.row])
            default: break
            }
            
            
        }
        
    }
    
    func details(data:Country){
        let details = DetailsViewController(data: data)
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}


class TagsCell: UITableViewCell {
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewTagLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
      
    var details:((Country)->Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
        setupData()
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData() {
        
        
        collectionView.bind(CountryService.getObjectList(prefix: "a")).configure(TagCell.self){ view, container, indexPath, data in
        
            view.setupData(data: data[indexPath.item])
            
        }.sizingView{ container, indexPath, data in
            
            let view = TagCell.sizing
            view.setupData(data: data[indexPath.item])
            return view.providerView
            
        }.inset { (container,indexPath,data) in
            
            return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            
        }.selection { [weak self] (container,indexPath,data) in
            self?.details?(data[indexPath.item])
        }
        
        
        
        
    }
    
    private func setupView() {
        
        backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white
        self.addSubview(collectionView)
    }
    
    private func setupLayout() {
        
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
    }
    
    
}

class ImagesCell: UITableViewCell {
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    
    var details:((Country)->Void)?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
        setupData()
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData() {
        
       
        collectionView.bind(CountryService.getObjectList(prefix: "b")).view{ container, indexPath, data in
            
            let view:ImageCell = container.dequeue(indexPath: indexPath)
            view.setupData(data: data[indexPath.item].image)
            view.setupShadow()
            return view
            
        }.size { (container,indexPath,data) in
            
            let image = data[indexPath.item].image
            let ratio = image.size.width / image.size.height
            let height = container.frame.height - 20
            let width = height * ratio
            
            return CGSize(width: width, height: height)
            
        }.inset { (container,indexPath,data) in
            
            return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            
        }.selection { [weak self] (container,indexPath,data) in
            self?.details?(data[indexPath.item])
        }
        
        
    }
    
    private func setupView() {
        
        backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.white
        
        self.addSubview(collectionView)
    }
    
    private func setupLayout() {
        
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
    }
    
    
}



class ArticleCell: UITableViewCell {
    
    private let providerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data:Country) {
        
        self.titleLabel.text = data.name
        self.descriptionLabel.text = data.article
    }
    
    private func setupView() {
        
        selectionStyle = .none
        backgroundColor = UIColor.white
        
        providerView.layer.cornerRadius = 8
        providerView.layer.backgroundColor = UIColor.white.cgColor
        providerView.layer.shadowColor = UIColor.black.cgColor
        providerView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        providerView.layer.shadowOpacity = 0.2
        providerView.layer.shadowRadius = 4
        
        self.addSubview(providerView)
        providerView.addSubview(titleLabel)
        providerView.addSubview(descriptionLabel)
        
    }
    
    private func setupLayout() {
        
        
        providerView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        providerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        providerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        providerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: providerView.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -20).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: providerView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: providerView.rightAnchor, constant: -20).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: providerView.bottomAnchor, constant: -20).isActive = true
    }
    
    
}



