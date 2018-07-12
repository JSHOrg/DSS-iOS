//
//  MenuBarCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 02/04/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class MenuBarCell: BaseCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.24)
        label.font = UIFont.robotoMediumStyle13
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let horizontalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override var isHighlighted: Bool {
        didSet {
            title.textColor = isHighlighted ? UIColor.rgb(red: 33, green: 150, blue: 83) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.24)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            title.textColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.24)
        }
    }
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    override func setupViews() {
//        super.setupViews()
        
        addSubview(title)
        addConstraintsWithFormat(format: "H:[v0(120)]", views: title)
        addConstraintsWithFormat(format: "V:[v0(32)]", views: title)
        
        addConstraint(NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
}
