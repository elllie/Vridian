//
//  CategoryCollectionViewCell.swift
//  Vridian
//
//  Created by Eleanor on 2/3/19.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let picture: UIImageView
    let label: UILabel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        switch UIDevice().type {
        case .iPhone5, .iPhoneSE:
            picture = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        default:
            picture = UIImageView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        }
        switch UIDevice().type {
        case .iPhone5, .iPhoneSE:
            label = UILabel(frame: CGRect(x: 0, y: picture.frame.size.height, width: frame.size.width, height: 125))
        default:
            label = UILabel(frame: CGRect(x: 0, y: picture.frame.size.height, width: frame.size.width, height: 75))
        }
        super.init(frame: frame)
        // ... and then the rest of the code
        
        picture.contentMode = .scaleAspectFit
        contentView.addSubview(picture)
        
        
        label.font = UIFont(name: "Karla-Bold", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        contentView.addSubview(label)
    }
    
}
