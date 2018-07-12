//
//  MenuCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 21/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    var menu: MenuUsuario? {
        didSet{
            
            Title.text = menu?.title
            
            if let icon = menu?.icon {
                Icon.setImage(UIImage(named: icon)?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
        }
    }
    
    let Icon: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
        button.isEnabled = false
        return button
    }()
    
    let Title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
        label.font = UIFont.robotoMediumStyle14
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            Title.textColor = isHighlighted ? UIColor.rgb(red: 33, green: 150, blue: 83) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
            Icon.tintColor = isHighlighted ? UIColor.rgb(red: 33, green: 150, blue: 83) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
            backgroundColor = isHighlighted ? UIColor.rgb(red: 242, green: 242, blue: 242) : UIColor.rgb(red: 250, green: 250, blue: 250)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            Title.textColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
            Icon.tintColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
            backgroundColor = isSelected ? UIColor.rgb(red: 242, green: 242, blue: 242) : UIColor.rgb(red: 250, green: 250, blue: 250)
        }
    }
    
    override func setupViews() {
        
        addSubview(Icon)
        addSubview(Title)
        
        addConstraintsWithFormat(format: "H:|-24-[v0(24)]-24-[v1]-24-|", views: Icon, Title)
        addConstraintsWithFormat(format: "V:|-12-[v0(24)]", views: Icon)
        
        addConstraintsWithFormat(format: "V:|-15-[v0(24)]", views: Title)
        
    }
    
}
