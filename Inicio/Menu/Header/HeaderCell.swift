//
//  HeaderCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 21/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    
    var header: Header? {
        didSet{
            
            Title.text = header?.title
            
        }
    }
    
    let Icon: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setImage(UIImage(named: "BackButton"), for: .normal)
        button.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
        return button
    }()
    
    let Title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8700000048)
        label.font = UIFont.robotoMediumStyle20
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = #colorLiteral(red: 0.9802859426, green: 0.9804533124, blue: 0.9802753329, alpha: 1)
        
        addSubview(Icon)
        addSubview(Title)
        addSubview(separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: separatorView)
        
        addConstraintsWithFormat(format: "H:|-18-[v0(40)]-14-[v1]-20-|", views: Icon, Title)
        addConstraintsWithFormat(format: "V:|-33-[v0(40)]", views: Icon)
        
        addConstraintsWithFormat(format: "V:|-38-[v0(30)]", views: Title)
        
    }
    
}

