//
//  ContactoCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 04/04/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class ContactoCell: BaseCell {
    
    var contacto: Contacto? {
        didSet{
            
            nombreContactoLabel.text = contacto?.nombreContacto
            direccionContactoLabel.text = contacto?.direccionContacto
            beneficiariosContactoLabel.text = contacto?.beneficiariosContacto
            iconLabel.text = contacto?.inicial
            
        }
    }
    
    let nombreContactoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        label.backgroundColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        label.font = UIFont.robotoMediumStyle14
        return label
    }()
    
    let direccionContactoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.54)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.54)
        label.font = UIFont.robotoRegularStyle13
        return label
    }()
    
    let beneficiariosContactoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.54)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.54)
        label.font = UIFont.robotoRegularStyle13
        label.numberOfLines = 0
        return label
    }()
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.rgb(red: 127, green: 127, blue: 127)
        label.textColor = UIColor.white
        label.font = UIFont.robotoLightStyle16
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            iconLabel.backgroundColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : UIColor.rgb(red: 127, green: 127, blue: 127)
            nombreContactoLabel.textColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : UIColor.rgb(red: 75, green: 75, blue: 75)
            backgroundColor = isHighlighted ? UIColor.rgb(red: 242, green: 242, blue: 242) : .clear
        }
    }
    
    override var isSelected: Bool {
        didSet {
            iconLabel.backgroundColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : UIColor.rgb(red: 127, green: 127, blue: 127)
            nombreContactoLabel.textColor = isSelected ? UIColor.rgb(red: 33, green: 150, blue: 83) : UIColor.rgb(red: 75, green: 75, blue: 75)
            backgroundColor = isSelected ? UIColor.rgb(red: 242, green: 242, blue: 242) : .clear
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(iconLabel)
        addSubview(nombreContactoLabel)
        addSubview(direccionContactoLabel)
        addSubview(beneficiariosContactoLabel)
        
        addConstraintsWithFormat(format: "H:|-21-[v0(40)]-22-[v1]-18-|", views: iconLabel, nombreContactoLabel)
        addConstraintsWithFormat(format: "V:|-24-[v0(40)]", views: iconLabel)
        
        addConstraintsWithFormat(format: "V:|-15-[v0(20)][v1(20)][v2]", views: nombreContactoLabel, direccionContactoLabel, beneficiariosContactoLabel)
        
        addConstraintsWithFormat(format: "H:|-21-[v0(40)]-22-[v1]-18-|", views: iconLabel, direccionContactoLabel)
        addConstraintsWithFormat(format: "H:|-21-[v0(40)]-22-[v1]-18-|", views: iconLabel, beneficiariosContactoLabel)
        
    }
}
