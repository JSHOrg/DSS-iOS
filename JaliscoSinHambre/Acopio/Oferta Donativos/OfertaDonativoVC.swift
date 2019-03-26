//
//  OfertaDonativoVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 06/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

var detalleDonativoDict = [DetalleDonativo]()
var indexDonativo : Int?

class OfertaDonativoVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.mainGreen()
        return activity
    }()
    
    let cellId = "cellId"
    var detalleDonativo = [DetalleDonativo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Oferta de donativos")
        setupViews()
        
    }
    
    func fetchDonativos() {
        
        activityIndicator.startAnimating()
        
        detalleDonativoContactos.removeAll()
        
        apiConnector.fetchOfertaDonativo(completionSucces: { (detalleDonativo) in
            DispatchQueue.main.async{
               
                self.detalleDonativo = detalleDonativo
                
                for donativo in detalleDonativo {
                    
                    let firstCharecter = donativo.nombreProducto?.first
                    
                    detalleDonativoContactos.append(Contacto(inicial: "\(firstCharecter!)", nombreContacto: donativo.nombreProducto, direccionContacto: "Fecha acopio: \(donativo.fechaAcopio ?? "")", beneficiariosContacto: "Transporte: \(donativo.tipoTransporte ?? "")\nProcurador: \(donativo.nombreProcurador ?? "")", identificador: "Donativo"))
                }
                
                self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
            }
        }) {
            DispatchQueue.main.async {
                
                var errorMsg = ""
                
                if apiConnector.errorDescription != nil {
                    print(apiConnector.errorDescription!)
                    errorMsg = apiConnector.errorDescription ?? "Error"
                    
                    if apiConnector.errorDescription == "invalid_token" {
                        let loginController = LoginVC()
                        let navController = UINavigationController(rootViewController: loginController)
                        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
                    }
                    
                } else {
                    print("Error al cargar oferta donativo")
                    errorMsg = "Error al cargar datos"
                }
                
                let alert = alertController.alertError(titulo: nil, mensaje: "\(errorMsg)")
                
                self.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detalleDonativoContactos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = detalleDonativoContactos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        indexDonativo = indexPath.item
        
        let detalleDonativoVC = DetalleDonativoVC()
        detalleDonativoDict = [detalleDonativo[indexPath.item]]
        navigationController?.pushViewController(detalleDonativoVC, animated: true)
        
    }
    
}
