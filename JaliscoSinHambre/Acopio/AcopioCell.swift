//
//  AcopioCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 22/05/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class AcopioCell: BaseCell {
    
    var acopio: Acopio? {
        didSet {
            
            acopioTitle.text = acopio?.title
            
            if let icon = acopio?.icon {
                acopioIcon.image = UIImage(named: icon)
            }
        }
    }
    
    let acopioIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.rgb(red: 127, green: 127, blue: 127)
        return imageView
    }()
    
    let acopioTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " "
        label.textColor = UIColor.mainBlack()
        label.font = UIFont.robotoMediumStyle14
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            acopioIcon.tintColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : UIColor.rgb(red: 127, green: 127, blue: 127)
            acopioTitle.textColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : UIColor.mainBlack()
            backgroundColor = isSelected ? UIColor.rgb(red: 242, green: 242, blue: 242) : .clear
        }
    }
    
    override func setupViews() {
        
        backgroundColor = .white
        
        addSubview(acopioIcon)
        addSubview(acopioTitle)
        
        addConstraint(NSLayoutConstraint(item: acopioIcon, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 24))
        addConstraint(NSLayoutConstraint(item: acopioIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: acopioTitle, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraintsWithFormat(format: "H:|-27-[v0(24)]-32-[v1]-27-|", views: acopioIcon, acopioTitle)
    }
    
}
