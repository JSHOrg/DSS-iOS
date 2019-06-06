//
//  SalidaAlmacenCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 09/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class SalidaAlmacenCell: FeedCell {
    
    var salidaAlmacenDict = [SalidaAlmacen]()
    
    override func fetchAgenda() {
        
        activityIndicator.startAnimating()
        
        salidasAlmacenContactos.removeAll()
        
        apiConnector.fetchSalidaAlmacen(completionSucces: { (salidas) in
            DispatchQueue.main.async {
                
                var x = 0
                for _ in salidas {
                    let nombre = salidas[x].nombreUsuario
                    let nombreArr = nombre?.components(separatedBy: " ")
                    
                    let firstCharecter = "\(String(describing: nombreArr?[0].first ?? "-"))"
                    
                    guard let motivoSalida = salidas[x].motivo else { return }
                    guard let cantidadSalida = salidas[x].cantidad else { return }
                    
                    let motivo = "Motivo: \(String(describing: motivoSalida))"
                    let cantidad = "Cantidad: \(String(describing: cantidadSalida))"
                    
                    salidasAlmacenContactos.append(Contacto(inicial: firstCharecter.uppercased(), nombreContacto: nombre, direccionContacto: motivo, beneficiariosContacto: cantidad, identificador: "Salida Almacen"))
                    
                    x = x + 1
                }
                
                self.salidaAlmacenDict = salidas
                
                self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
            }
            
        }, completionError: {
            DispatchQueue.main.async {
                print("error salidas almacen")
                
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
                    errorMsg = "Error al cargar datos"
                }
                
                let alert = alertController.alertError(titulo: nil, mensaje: "\(errorMsg)")
                
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()
                
            }
        })
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return salidasAlmacenContactos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = salidasAlmacenContactos[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detalleTransferenciaVC = DetalleTransferenciaVC()
        
        detalleTransferenciaVC.detalleTransferenciaSalidaDict = [self.salidaAlmacenDict[indexPath.item]]
        
        let navController = UINavigationController(rootViewController: detalleTransferenciaVC)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
        
    }
    
    
}
