//
//  InicioVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 20/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class InicioVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var opcionesMenu = [MenuUsuario]()
    
    let menuUsuarioDict = ["Inicio" : "Inicio", "Agenda de contactos" : "Agenda", "Mapa" : "Mapa", "Acopio" : "Acopio"]
    
    let menuCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        let myCollectionView = UICollectionView(frame: CGRect(x: -240, y: 0, width: 240, height: (UIApplication.shared.keyWindow?.frame.height)!), collectionViewLayout: layout)
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.backgroundColor = UIColor.rgb(red: 250, green: 250, blue: 250)
        myCollectionView.isScrollEnabled = true
        myCollectionView.bounces = false
        myCollectionView.alpha = 0
        
        return myCollectionView
    }()
    
    let backgroundButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.frame.width)!, height: (UIApplication.shared.keyWindow?.frame.height)!)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.alpha = 0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        setCustomBackImage()
//        setupLeftTitleNav(title: "Inicio")
        setupRightNavItems()
        
        backgroundButton.addTarget(self, action: #selector(handleRegresar), for: .touchUpInside)
        
//        setupCollectionView()
        
//        for men in menuUsuarioDict {
//
//            opcionesMenu.append(MenuUsuario(title: men.key,icon: men.value))
//
//        }
    }
    
    func setupCollectionView() {
        
        self.menuCV.delegate = self
        self.menuCV.dataSource = self
        self.menuCV.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        self.menuCV.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = menuCV.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.menu = opcionesMenu[indexPath.item]
        cell.Icon.isSelected = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 48)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:view.frame.size.width, height: 81)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! HeaderCell
            header.header = Header(title: "Administrador")
            header.Icon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRegresar)))
            header.setNeedsLayout()
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //checar de nuevo cuando tenga el WebService
        
        if indexPath.row == 0 {
            handleRegresar()
            Switcher.updateRootVC(identifier: "agendaContactosVc")
        }
        
    }
    
    @objc func handleRegresar() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.backgroundButton.alpha = 0
            self.menuCV.alpha = 0
            
            self.menuCV.frame = CGRect(x: -240, y: 0, width: 240, height: (UIApplication.shared.keyWindow?.frame.height)!)
            
        }, completion: nil)
        
    }
    
    
    
}
