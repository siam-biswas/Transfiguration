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

indirect enum CompositionSections:Sectionable,Identifiable{
    
    var identifier: String{
        switch self {
        case .images:
            return "images"
        case .tags:
            return "tags"
        case .articles:
            return "articles"
        }
    }
    
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
    
    var service = Transfigurator<Table<CompositionSections>>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        setupComposition()
    }
    
    func setupComposition(){
        
        service.insert(section: .images)
        service.insert(section: .tags)
        service.insert(section: .articles(CountryService.getObjectList(prefix: "c")))
        
        
        service.bind(tableView).view{ container, index, section in
            
            switch section{
                
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
                view.setupData(data: data[index.row])
                return view
                
            }
            
        }.height { container, index, section in
            
            switch section {
                
            case .articles:
                return UITableView.automaticDimension
            case .images:
                return 180
            case .tags:
                return 60
            }
            
        }.selection { [weak self] (container,indexPath,section) in
            
            switch section{
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
    
    var service = Transfigurator<Collection>(data: [Country]())
    
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
        
        service.append(section: CountryService.getObjectList(prefix: "a"))
        
        service.bind(collectionView).view{ container, indexPath, section in
            
            let view:TagCell = container.dequeue(indexPath: indexPath)
            view.setupData(data: section[indexPath.item])
            return view
            
        }.sizingView{ container, indexPath, section in
            
            let view = TagCell.sizing
            view.setupData(data: section[indexPath.item])
            return view.providerView
            
        }.inset { (container,index,section) in
            
            return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            
        }.selection { [weak self] (provider,indexPath,section) in
            self?.details?(section[indexPath.item])
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
    
    var service = Transfigurator<Collection>(data: [Country]())
    
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
        
        service.append(section: CountryService.getObjectList(prefix: "b"))
        
        service.bind(collectionView).view{ provider, indexPath, section in
            
            let view:ImageCell = provider.dequeue(indexPath: indexPath)
            view.setupData(data: section[indexPath.item].image)
            view.setupShadow()
            return view
            
        }.size { (provider,indexPath,section) in
            
            let image = section[indexPath.item].image
            let ratio = image.size.width / image.size.height
            let height = provider.frame.height - 20
            let width = height * ratio
            
            return CGSize(width: width, height: height)
            
        }.inset { (provider,index,section) in
            
            return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            
        }.selection { [weak self] (provider,indexPath,section) in
            self?.details?(section[indexPath.item])
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



