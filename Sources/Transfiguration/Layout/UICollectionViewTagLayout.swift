//
// UICollectionViewTagLayout.swift
// Transfiguration
//
// Copyright (c) 2020 Siam Biswas.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation
import UIKit

public class UICollectionViewTagLayout: UICollectionViewFlowLayout {
    
    public var itemHeight: CGFloat?
    
    
    func getHeight() -> CGFloat{
        
        guard let height = itemHeight else {
            guard let collectionView = collectionView else {
               return 0
            }
            
            let insets = collectionView.contentInset
            return collectionView.bounds.height - (insets.top + insets.bottom)
            
        }
        return height
        
    }
    
    func getMaxWidth(inset:UIEdgeInsets?) -> CGFloat{
        
        
        guard let collectionView = collectionView else {
            return 0
        }
            
        let insets = collectionView.contentInset
        var width = collectionView.bounds.width - (insets.left + insets.right)
        
        if let inset = inset{
            width = width - (inset.left + inset.right)
        }
        
        return width
            
        
    }
    
    public func calculateSize(view:UIView?,inset:UIEdgeInsets?) -> CGSize{
        
        var height = getHeight()
        
        if let inset = inset{
            height = height - (inset.top + inset.bottom)
        }
        
        guard let view = view else { return CGSize(width: height, height: height) }
        
    
        var referenceSize = UIView.layoutFittingCompressedSize
        referenceSize.height = height
        referenceSize.width = height
                      
        var size = view.systemLayoutSizeFitting(referenceSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
        
        if scrollDirection == .vertical, size.width > getMaxWidth(inset: inset){
            size.width = getMaxWidth(inset: inset)
        }
    
        
        return CGSize(width: size.width, height: height)
        
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = copy(super.layoutAttributesForElements(in: rect))
        
        guard scrollDirection == .vertical else{
            return attributes
        }

        var leftMargin:CGFloat = 20//sectionInset.left
           var maxY: CGFloat = -1.0
           attributes?.forEach { layoutAttribute in
               if layoutAttribute.frame.origin.y >= maxY {
                   leftMargin = 20//sectionInset.left
               }

               layoutAttribute.frame.origin.x = leftMargin

               leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
               maxY = max(layoutAttribute.frame.maxY , maxY)
           }

           return attributes
    }
    
    private func copy(_ layoutAttributesArray: [UICollectionViewLayoutAttributes]?) -> [UICollectionViewLayoutAttributes]? {
           return layoutAttributesArray?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
    }
    
}
    


