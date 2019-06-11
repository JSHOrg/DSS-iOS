//
//  BancosCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 30/05/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

var indexContactos : Int?
var identificadorAgenda : String?

class BancosCell: FeedCell {
    
    override func fetchAgenda() {
        
        activityIndicator.startAnimating()
        
        contactosBancos.removeAll()
        contactosCentros.removeAll()
        contactosAcopio.removeAll()
        
        apiConnector.fetchAgendaContactos(completionSucces: {
            
            DispatchQueue.main.async {
                
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
                    } else {
                        errorMsg = "\(apiConnector.errorDescription!)"
                    }
                    
                } else {
                    print("Error al cargar agenda Bancos Alimentos 1")
                    errorMsg = "Error al cargar datos"
                }
                
                let alert = alertController.alertError(titulo: nil, mensaje: "\(errorMsg)")
                
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()
            }
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactosBancos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = contactosBancos[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(contactosBancos[indexPath.item].identificador!)
        
        identificadorAgenda = contactosBancos[indexPath.item].identificador!

        indexContactos = indexPath.item

        if let keyWindow = UIApplication.shared.keyWindow {

            setupAgendaDetalleView(keyWindow: keyWindow)

        }
        
    }
}
