//
//  BenefactoresVC+Extension.swift
//  JaliscoSinHambre
//
//  Created by usuario on 10/31/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension BenefactoresVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        
        fetchBenefactores()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupViews() {
        
        agregarBenefactorBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAgregarBenefactor)))
        
        view.addSubview(separatorView)
        view.addSubview(collectionView)
        view.addSubview(agregarBenefactorBtn)
        
        separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        agregarBenefactorBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        agregarBenefactorBtn.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        agregarBenefactorBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        agregarBenefactorBtn.widthAnchor.constraint(equalToConstant: 56).isActive = true
        
        view.addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        collectionView.register(ContactoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    
    
    @objc func handleAgregarBenefactor() {
        
        let añadirBenefactorVC = AñadirBenefactorVC()
        añadirBenefactorVC.titleNavBar = "Añadir benefactor"
        navigationController?.pushViewController(añadirBenefactorVC, animated: true)
        
    }
    
}
