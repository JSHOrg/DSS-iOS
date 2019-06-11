//
//  AcopioVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 02/04/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class AcopioVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let acopioTitleArray = ["Solicitud de recolección", "Oferta de donativos", "Transferencia de productos", "Benefactores"]
    let acopioIconArray = ["solicitud", "donativos", "entradasYSalids", "Benefactores"]
    
    var acopio = [Acopio]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupLeftTitleNav(titleNav: "Acopio")
        setupCollectionView()
        
        var i = 0
        for aco in acopioTitleArray {

            acopio.append(Acopio(icon: acopioIconArray[i], title: aco))

            i = i + 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return acopio.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AcopioCell
        
        cell.acopio = acopio[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 94)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            let solicitudRecoleccionVC = SolicitudRecoleccionVC()
            
            navigationController?.pushViewController(solicitudRecoleccionVC, animated: true)
            
        } else if indexPath.item == 1 {
            
            let ofertaDonativoVC = OfertaDonativoVC()
            
            navigationController?.pushViewController(ofertaDonativoVC, animated: true)
            
        } else if indexPath.item == 2 {
            
            let transferenciaProductosVC = TransferenciaProductosVC()
            
            navigationController?.pushViewController(transferenciaProductosVC, animated: true)
            
        } else if indexPath.item == 3 {
            
            let benefactoresVC = BenefactoresVC()
            
            navigationController?.pushViewController(benefactoresVC, animated: true)
            
        }
        
    }
}
