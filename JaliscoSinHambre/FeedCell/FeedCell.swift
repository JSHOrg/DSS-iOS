//
//  FeedCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 03/04/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {  //lazy access self inside of this clousure
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.mainGreen()
        return activity
    }()
    
    let cellId = "cellId"
    
    let nombreContacto = "Santa María Tequepexpan"
    let direccionContacto = "C.P. 45340 Jalisco, México"
    let beneficiariosContacto = "65 beneficiarios"
    
    
    func fetchAgenda() {
        let firstCharecter = nombreContacto.first //.key.first
        
        for _ in 1...14 {
            contactos.append(Contacto(inicial: "\(firstCharecter!)", nombreContacto: nombreContacto, direccionContacto: direccionContacto, beneficiariosContacto: beneficiariosContacto, identificador: "FeedCell"))
        }
        
    }
    
    override func setupViews() {
        
        addSubview(collectionView)
        addSubview(activityIndicator)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        collectionView.register(ContactoCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchAgenda()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = contactos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print(contactos[indexPath.item].identificador!)
        
        let detalleBenefactorVC = DetalleBenefactorVC()
        let navController = UINavigationController(rootViewController: detalleBenefactorVC)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
        
    }
    
    func setupAgendaDetalleView(keyWindow: UIWindow) {
        
        let detalleAgendaFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.height)
        
        let detalle = DetalleContactosVC(frame: detalleAgendaFrame)
        
        keyWindow.addSubview(detalle)
    }
    
}

