# Transfiguration

![Platform](https://img.shields.io/badge/platforms-iOS%208.0-F28D00.svg)
![UITableView](https://img.shields.io/badge/UITableView%20-F28D00.svg)
![UICollectionView](https://img.shields.io/badge/UICollectionView%20-F28D00.svg)
![UIPickerView](https://img.shields.io/badge/UIPickerView%20-F28D00.svg)


### Mystical way to transform your data into reusable view in Swift


#### Transfiguration is a solution for creating data driven iOS applications with minimal block of codes. It helps you to represent your data set with reusable views like UITableView, UICollectionView or UIPickerView with minimum effort.



<table>
  <tr>
    <th>
      <img src="simple.GIF" width="260"/>
    </th>
    <th>
    <img src="waterfall.GIF" width="260"/>
    </th>
    <th>
    <img src="grid.GIF" width="260"/>
    </th>
    <th>
    <img src="card.GIF" width="260"/>
    </th>
  </tr>
</table>



<table>
  <tr>
    <th>
      <img src="picker.GIF" width="260"/>
    </th>
    <th>
    <img src="tag.GIF" width="260"/>
    </th>
    <th>
    <img src="stack.GIF" width="260"/>
    </th>
    <th>
    <img src="composition.GIF" width="260"/>
    </th>
  </tr>
</table>





## Usage

Lets say you have an array with alphabets and you want to represent them in `UITableView`. 

For doing that with `Transfigurstion` start with defining a `Transfigurator` service as an instance variable with a `Table` adapter and your array. Then all you have to do is bind this with your container and attach the view configurations with closures.

```swift
class ViewController: UITableViewController {
    
    let service = Transfigurator<Table>(data:  ["A","B","C",.....])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.bind(tableView).view{ container, indexPath, data in
            
            let view:UITableViewCell = container.dequeue()
            view.textLabel?.text = data[indexPath.row]
            return view
            
        }
    }
    
}
```

Whats happening here is , when you bind the `Transfigurator` with `tableView`, it autimatically manage the datasource and delegate methods inside and also set an observer for your data operations so that you never have to call the `tableView.reloadData()` again !

Here you see we initialize the cell with  `container.dequeue()` method. Which first registered you cell with the container & then return a reusable instance with a default identifier. 

## Transfigurator

Its the core service for `Transfiguration` which contains all the major functionalities like binding, mapping and data operations. You can also controll whether to animate the data operations while presenting.

| Core Features                           |
| ------------------------------------| 
| `Bind with container`         |
| `Map view configurations` | 
| `Insert Section`                   | 
| `Update Section`                  |
| `Delete Section`                  | 
| `Insert Item`                       | 
| `Update Item`                       |
| `Delete Item`                       | 
| `Clear All`                          | 



## Section

It basically holds a single type of data set. By default Array with any type of data is work as a section in `Transfiguration`, but you can also use the Section object with identifier,priority,header and footer to get full control. You can make your custom section by conforming to the `Sectionable`, `Identifiable` & `Operatable` protocols as per your needs. Also for composing different types of data section you can use `Ènum`.

```swift

let section = ["A","B","C"]
         
```

```swift

let section = Section(identifier: "a", data: ["A","B","C"], header: "some header", footer: "some footer", priority: 0)
         
```

```swift

class CustomSection: Sectionable,Identifiable,Operatable{

    var identifier: String
    var priority: Int?

    var header:String?
    var footer:String?

    var count: Int
    var data: [String]
    
}
         
```

```swift

enum CompositionSections:Sectionable,Identifiable{
    
    case images
    case tags
    case articles([String])
    
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
         
```

## Mapper

Its where you will find all the closures related to you containers cell configuration like viewing, sizing , selecting etc. When you bind the ``Transfigurator`` service with your container it returns the associated mapper and also every mapper funtion returns `Self` instance so that you can chain your configurations. If you are not a fan of chaining then you can always use the `map` object from `Transfigurator` to access the `Mapper`.

```swift

service.bind(tableView).view{ ... }.selection { ... }

service.map.view { ... }

service.map.height { ... }

service.map.size { ... }

service.map.selection { ... }
         
```

## Provider

Provider holds all type of data that you are going to use. It contains the array of sections and helps `Transfigurator` to execute the operations.


## Presenter

Presenter is where you containers actual datasource & delegate functions are implemented. It holds the `Mapper` object and also creates the link between your data operation & presenting operation.


## Adapter

It contains the provider and presenter and work as a type definition for supported containers.

| Adapters           |
| ------------------| 
| `Table`             |
| `Collection`  | 
| `Picker`          | 


## Custom Layouts 



Transfiguration comes with some cool custom layouts for UICollectionView. If you already have experience working with UICollectionView , then you must know that how hard it is to represent dynamic sizeable views with it. Now with these custom layouts and a default sizing configuration provided by Transfiguration, working with Collections will be much easy and fun. Checkout the Example files for the demostration of custom layouts.



```swift

let layout = UICollectionViewWaterfallLayout()
layout.numberOfColumns = 2
let viewController = UICollectionViewController(collectionViewLayout: layout)
         
```

```swift

let layout = UICollectionViewTagLayout()
layout.scrollDirection = .horizontal
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         
```

```swift

transfigurator.bind(collectionView).view{ container, indexPath, data in
    
    let view:CustomCell = container.dequeue(indexPath: indexPath)
    view.setupData(data: data[indexPath.item])
    return view
    
}.sizingView{ container, indexPath, data in
    
    let view = CustomCell.staticSizingInstance
    view.setupData(data: data[indexPath.item])
    return view.sizingView
    
}
         
```


While using the `sizing` configuration , please ensure that your view has all required auto layout setup for dynamic height or width. Also it is recommended to use a Static instance of your dynamic cell for better performance.


| Available Layouts                                            |
| --------------------------------------------------- | 
| `UICollectionViewWaterfallLayout`       |
| `UICollectionViewTagLayout`                   | 
| `UICollectionViewStackLayout`              | 
| `UICollectionViewCardLayout`                |
| `UICollectionViewGridLayout`                | 

## Installation

### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `Transfiguration` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
    pod 'Transfiguration', :git => 'https://github.com/siam-biswas/Transfiguration.git'
end
```

### Manually

To use this library in your project manually you may:  

1. for Projects, just drag all the (.swift) files from (Source\Transfiguration) to the project tree
2. for Workspaces, include the whole Transfiguration.xcodeproj




## License

This project is licensed under the terms of the MIT license. See the LICENSE file for details.
