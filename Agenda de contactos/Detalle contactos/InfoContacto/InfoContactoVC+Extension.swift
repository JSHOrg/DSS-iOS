//
//  InfoContactoVC+Extension.swift
//  JaliscoSinHambre
//
//  Created by usuario on 03/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension InfoContactoVC {
    
    func setupViews() {
        
        addSubview(navigationView)
        addSubview(separatorView)
        
        let height = heightTopBar! - 50
        
        print("altura \(UIScreen.main.nativeBounds.height)")  //24 puntos de diferecia
        
        navigationView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: height).isActive = true
        navigationView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        navigationView.addSubview(dismissViewButton)
        navigationView.addSubview(nombreBanco)
        
        if UIScreen.main.nativeBounds.height == 2436 {  //its iphone X
            dismissViewButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor, constant: 20).isActive = true
            nombreBanco.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor, constant: 20).isActive = true
        } else {
            dismissViewButton.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor, constant: 10).isActive = true
            nombreBanco.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor, constant: 10).isActive = true
        }
        
        dismissViewButton.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 10).isActive = true
        dismissViewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dismissViewButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        nombreBanco.leftAnchor.constraint(equalTo: dismissViewButton.rightAnchor, constant: -15).isActive = true
        nombreBanco.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nombreBanco.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        collectionView.register(InfoContactoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    @objc func handleDismissView(){
        self.removeFromSuperview()
    }
    
}
