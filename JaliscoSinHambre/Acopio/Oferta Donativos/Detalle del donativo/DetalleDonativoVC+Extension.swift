//
//  DetalleDonativoVC+Extension.swift
//  JaliscoSinHambre
//
//  Created by usuario on 07/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension DetalleDonativoVC {
    
    func setupMenuBar() {
        
        secciones = ["PRODUCTO", "ACOPIO","ESPECIFICACIONES", "PROCURADOR"]
        
        view.addSubview(seccionBar)
        view.addSubview(collectionView)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: seccionBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: seccionBar)
        
        seccionBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        collectionView.register(FeedDetalleDonativoCell.self, forCellWithReuseIdentifier: productoId)
        collectionView.register(AcopioDonativoCell.self, forCellWithReuseIdentifier: acopioId)
        collectionView.register(EspecificacionesDonativoCell.self, forCellWithReuseIdentifier: especificacionesId)
        collectionView.register(ProcuradorDonativoCell.self, forCellWithReuseIdentifier: procuradorId)
        
        view.addSubview(separatorView)
        separatorView.topAnchor.constraint(equalTo: seccionBar.bottomAnchor, constant: 0).isActive = true
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
        
        seccionBar.collectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
        seccionBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        
        print("detalle donativo")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        seccionBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4

    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        print("index - \(index)")
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        seccionBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .centeredHorizontally)
        
    }
   
}

