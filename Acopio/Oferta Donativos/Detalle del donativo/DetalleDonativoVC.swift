//
//  DetalleDonativoVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 06/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class DetalleDonativoVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var seccionBar: SeccionBar = {
        let sb = SeccionBar()
        sb.detalleDonativoVC = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    let productoId = "productoId"
    let acopioId = "acopioId"
    let especificacionesId = "especificacionesId"
    let procuradorId = "procuradorId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Detalle del donativo")
        
        setupMenuBar()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 0 {
            identifier = productoId
        } else if indexPath.item == 1 {
            identifier = acopioId
        }else if indexPath.item == 2 {
            identifier = especificacionesId
        } else {
            identifier = procuradorId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        heightTopBar = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)! + 50 //UIApplication.shared.statusBarFrame.maxY + 44 + 50
        bottomBar = self.tabBarController?.tabBar.frame.height
        
        return CGSize(width: view.frame.width, height: view.frame.height - heightTopBar! - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
}
