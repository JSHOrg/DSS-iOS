//
//  EntradasAlmacenCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 09/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class EntradasAlmacenCell: FeedCell {
    
    var entradaAlmacenDict = [EntradaAlmacen]()

    var nombreContactoTransferencia = [String]()
    
    override func fetchAgenda() {
        
        activityIndicator.startAnimating()
        
        entradasAlmacenContactos.removeAll()
        nombreContactoTransferencia.removeAll()
        
        apiConnector.fetchEntradasAlmacen(completionSucces: { (entradas) in
            DispatchQueue.main.async {
                
                var x = 0
                for _ in entradas {
                    
                    guard let fecha = entradas[x].fechaEntrada else { return }
                    guard let cantidadKg = entradas[x].cantidadKg else { return }
                    guard let cantidadPza = entradas[x].cantidadPza else { return }
                    
                    let fechaEntrada = "Fecha: \(String(describing: fecha))"
                    let cantidad = "Cantidad KG: \(String(describing: cantidadKg))Kg Cantidad Pza: \(cantidadPza) Pza"
                    
                    guard let _links = entradas[x]._links else { return }
                    
                    apiConnector.fetchLinksProducto(links: _links, completionSucces: { (producto) in
                        DispatchQueue.main.async {
                            
                            let nombre = producto.0
                            let nombreArr = nombre.components(separatedBy: " ")
                            
                            let firstCharecter = "\(String(describing: nombreArr[0].first ?? "-"))"
                            
                            self.nombreContactoTransferencia.append(producto.5)
                            
                            entradasAlmacenContactos.append(Contacto(inicial: firstCharecter.uppercased(), nombreContacto: nombre, direccionContacto: fechaEntrada, beneficiariosContacto: cantidad, identificador: "Entrada Almacen"))
                            
                            self.collectionView.reloadData()
                            
                        }
                    }, completionError: {
                        DispatchQueue.main.async {
                            if apiConnector.errorDescription != nil {
                                print(apiConnector.errorDescription!)
                                
                            } else {
                                print("Error al cargar entrada almacen")
                            }
                        }
                    })
                    
                    
                    x = x + 1
                }
                
                self.entradaAlmacenDict = entradas
                
                self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
            }
        }) {
            DispatchQueue.main.async {
                print("error entradas almacen")
                
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
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entradasAlmacenContactos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = entradasAlmacenContactos[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detalleTransferenciaVC = DetalleTransferenciaVC()
        
        self.entradaAlmacenDict[indexPath.item].nombreProducto = entradasAlmacenContactos[indexPath.item].nombreContacto
        self.entradaAlmacenDict[indexPath.item].nombreUsuario = nombreContactoTransferencia[indexPath.item]
        
        detalleTransferenciaVC.detalleTransferenciaEntradaDict = [self.entradaAlmacenDict[indexPath.item]]
        
        let navController = UINavigationController(rootViewController: detalleTransferenciaVC)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
        
    }
    
}
