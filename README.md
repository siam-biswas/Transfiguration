# Transfiguration

![Platform](https://img.shields.io/badge/platforms-iOS%208.0-F28D00.svg)
![UITableView](https://img.shields.io/badge/UITableView%20-F28D00.svg)
![UICollectionView](https://img.shields.io/badge/UICollectionView%20-F28D00.svg)
![UIPickerView](https://img.shields.io/badge/UIPickerView%20-F28D00.svg)


#### Mystical way to transform your data into reusable view in Swift


##### Transfiguration is a solution for creating data driven iOS applications with minimal block of codes. It helps you to represent your data set with reusable views like UITableView, UICollectionView or UIPickerView with minimum effort.



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





## Usage

Start with defining a `Transfigurator` service as an instance variable with a container type and an Array of your data


```swift
class ViewController: UITableViewController{

   let service = Transfigurator<Table>(data: ["A","B","C",.....])

}
```

Then all you have to do is bind this with your container and attach the view configurations with closures 

```swift

service.bind(tableView).view{ container,indexPath,data in
    
    let view:UITableViewCell = container.dequeue()
    view.textLabel?.text = data[indexPath.row]
    return view
    
}.selection { [weak self] container,indexPath,data in

    print(data[indexPath.row])
    
}
         
```

Here you see we initialize the view with  `container.dequeue()` method. Which first registered you cell with the container & then return a reusable instance with default identifier. 

## Transfigurator

Its the core service for Transfiguration which contains all the major functionalities like binding , provider, presenter , mapper and data operations (insert/update/delete)


## Section

It basically holds you single type of data set. By default Array with any type of data is work as a section in `Transfiguration`, but you can also use the Section object with identifier,priority,header and footer to get full control. Also you can make your custom section by conforming to the `Sectionable`, `Identifiable` & `Operatable` protocols.

```swift

let section = Section(identifier: "a", data: ["A","B","C"])
         
```

## Mapper

Its where you will find all the closures related to you containers cell configuration like viewing, sizing , selecting etc. When you bind the Transfigurator service with your container it returns the associated mapper and also every mapper funtion returns `Self` instance so that you can chain your configurations. If you are not a fan of chaining then you can always use the `map` object from service to access the `Mapper`.

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

| Supported Containers Type    |
| ----------------------------------| 
| `Table`                                   |
| `Collection`                        | 
| `Picker`                                | 


## Custom Layouts 



Transfiguration comes with some cool custom layouts for UICollectionView. If you already have experience working with UICollectionView , then you must know that how hard it is to represent dynamic sizeable views with it. Now with these custom layouts and a default sizing configuration provided by Transfiguration, working with Collections will be much easy and fun. Checkout the Example files for the demostration of custom layouts.

| Layouts                                                            |
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





