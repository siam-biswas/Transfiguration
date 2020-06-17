# Transfiguration

![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
![CocoaPods](https://img.shields.io/cocoapods/v/Transfiguration.svg) 
![Platform](https://img.shields.io/badge/platforms-iOS%208.0-F28D00.svg)
![UITableView](https://img.shields.io/badge/UITableView%20-F28D00.svg)
![UICollectionView](https://img.shields.io/badge/UICollectionView%20-F28D00.svg)
![UIPickerView](https://img.shields.io/badge/UIPickerView%20-F28D00.svg)


### Mystical way to transform data into reusable view in Swift


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
    <img src="todo.GIF" width="260"/>
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


### Scenario One

Lets say you have an array with alphabets and you want to represent them in `UITableView`. 
For doing that with `Transfiguration` all you have to do is bind your data with your tableView and attach the view configurations with closures.

```swift
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.bind(["A","B","C"]).configure{ view, container, indexPath, data in
            view.textLabel?.text = data[indexPath.row].name
        }

    }

}

```

### Scenario Two

Now you want to represent your alphabets array with `UICollectionView`. 
The necceserry step is pretty much same as the previous with an aditional mentioning of your custom `View Type` and size configuration

```swift

class CustomCell : UICollectionViewCell { ... }

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       collectionView.bind(["A","B","C"]).configure(CustomCell.self){ view, container, indexPath, data in
            view.setupData(data: data[indexPath.row])
        }.size{ container, indexPath, data in
            return CGSize(width: 100, height: 100)
        }

    }

}

```

### Scenario Three

Now finally you have a `UIPickerView` and you want to populate that with your alphabets array. Lets see the way to do it.

```swift

pickerView.bind(["A","B","C"]).title{ container, indexPath, data in
    return data[indexPath.row]
}

```

These are the very basic usage of `Transfiguration`. For getting idea about some more complex scenarios please check the Example files. 


## Transfigurable

By wrapping your data with `Transfigurable`, you can access all available data operations. It basically sets an observer for your data operations  so that you never have to call the `reloadData()`  or relevent functios from your view layer. You can also controll animations and force reload while executing this operations.

| Available Operations                 |
| ------------------------------------| 
| `Append Section`                   | 
| `Insert Section`                   | 
| `Update Section`                  |
| `Remove Section`                  | 
| `Append Item`                       | 
| `Insert Item`                       | 
| `Update Item`                       |
| `Delete Item`                       | 
| `Clear All`                          | 



## Sectionable

The data holder you are binding with your list or grid view must be conformed by `Sectionable`. You can make your custom sections by conforming to the `Sectionable`  protocol. Also for composing different types of data section you can use `Ènum`.

```swift
class CustomSection: Sectionable {

    var header:String?
    var footer:String?
    var count: Int
    
}
```

```swift
enum CompositionSections: Sectionable {
   case image,video,text
}
```

## Operatable

`Operatable` gives your `Sectionable`  data some ability for data operations like append, insert, update & remove.


```swift
class CustomSection: Sectionable,Operatable { 
   var data: [String]
}
```

```swift
enum CompositionSections: Sectionable,Operatable { .... }
```

## Identifiable

By conforming to `Identifiable` your  `Sectionable`  data  can gets a unique identity and priority for precise data operations. 


```swift
class CustomSection: Sectionable,Operatable,Identifiable {
    var identifier: String
    var priority: Int?
}
```

```swift
enum CompositionSections: Sectionable,Operatable,Identifiable { .... }
```


## Custom Layouts 

Transfiguration comes with some cool custom layouts for `UICollectionView`.

| Available Layouts                                            |
| --------------------------------------------------- | 
| `UICollectionViewWaterfallLayout`       |
| `UICollectionViewTagLayout`                   | 
| `UICollectionViewStackLayout`              | 
| `UICollectionViewCardLayout`                |
| `UICollectionViewGridLayout`                | 

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

Checkout the Example files for the demostration of all custom layouts.


## Dynamic Sizing

If you already have experience working with `UICollectionView` , then you must know that how hard it is to represent dynamic sizeable views with it. Now with a default sizing configuration provided by Transfiguration, working with Collections will be much easy and fun.

```swift

collectionView.bind(["A","B","C"]).configure(CustomCell.self){ view, container, indexPath, data in

    view.setupData(data: data[indexPath.row])

}.sizingView{ container, indexPath, data in
    
    let view = CustomCell.sizing
    view.setupData(data: data[indexPath.row])
    return view.contanerView
        
}

```

While using the `sizing` configuration , please ensure that your view has all required auto layout setup for dynamic height or width. Also it is recommended to use a Static instance of your dynamic cell for better performance.


## Installation

### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `Transfiguration` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
    pod 'Transfiguration'
end
```

### Carthage 

You can use [Carthage](https://github.com/Carthage/Carthage) to install `Transfiguration` by adding it to your `Cartfile`:

```
github "siam-biswas/Transfiguration"
```

If you use Carthage to build your dependencies, make sure you have added `Transfiguration.framework` to the "Linked Frameworks and Libraries" section of your target, and have included them in your Carthage framework copying build phase.

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Transfiguration` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/siam-biswas/Transfiguration.git", from: "2.0.0"),
    ]
)
```

### Manually

To use this library in your project manually you may:  

1. for Projects, just drag all the (.swift) files from (Source\Transfiguration) to the project tree
2. for Workspaces, include the whole Transfiguration.xcodeproj




## License

This project is licensed under the terms of the MIT license. See the LICENSE file for details.
