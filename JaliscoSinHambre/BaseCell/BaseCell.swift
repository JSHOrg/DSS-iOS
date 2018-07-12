//
//  BaseCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 21/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "V:[v0(0.5)]|", views: separatorView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BaseCell {
    
    func fetchData() {
        
        
    }
    
}
