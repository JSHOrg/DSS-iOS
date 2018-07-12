//
//  MapaVC+Extension.swift
//  JaliscoSinHambre
//
//  Created by usuario on 02/04/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit
import MapKit

extension MapaVC {
    
    func setupMenuBar() {
        
        labelNames = ["BANCO DE ALIMENTOS", "CENTROS COMUNITARIOS", "CENTROS DE ACOPIO"]
        
        view.addSubview(menuBar)
        view.addSubview(collectionView)

        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        
        collectionView.register(MapaAcopioCell.self, forCellWithReuseIdentifier: acopioCell)
        collectionView.register(MapaCentrosCell.self, forCellWithReuseIdentifier: centrosCell)
        collectionView.register(MapaBancosCell.self, forCellWithReuseIdentifier: bancosCell)
        
        view.addSubview(separatorView)
        separatorView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        view.addConstraintsWithFormat(format: "V:[v0]", views: collectionView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        collectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition(), animated: true)
        
        print("mapa")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
    }
    
}
