//
//  InfoContactoCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 03/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class InfoContactoCell: BaseCell {
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(descriptionLabel)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: descriptionLabel)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: descriptionLabel)
        
        
        
    }
}
