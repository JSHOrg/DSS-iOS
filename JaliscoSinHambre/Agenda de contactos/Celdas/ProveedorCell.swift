//
//  ProveedorCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 10/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class ProveedorCell: FeedCell {
    
    var detalleProveedorDict = [Proveedor]()
    
    override func fetchAgenda() {
        
        activityIndicator.startAnimating()
        
        detalleProveedoresContactos.removeAll()
        
        apiConnector.fetchProveedores(completionSucces: { (proveedor) in
            DispatchQueue.main.async{
                
                self.detalleProveedorDict = proveedor
                
                for pro in proveedor {
                    
                    let nombreArr = pro.nombreProveedor?.components(separatedBy: " ")
                    
                    let inicialNombre = nombreArr?.first?.first
                    let inicialApellido = nombreArr?.last?.first
                    
                    let firstCharecter = "\(String(describing: inicialNombre!))\(String(describing: inicialApellido!))"
                    
                    detalleProveedoresContactos.append(Contacto(inicial: "\(firstCharecter.uppercased())", nombreContacto: pro.nombreProveedor, direccionContacto: "Correo: \(pro.correoContactoProveedor ?? "")", beneficiariosContacto: "Tel: \(pro.telefonoContactoProveedor ?? "")", identificador: "Proveedor"))
                }
                
                self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
            }
                
        }) {
            DispatchQueue.main.async{
                print("error proveedores")
                
                var errorMsg = ""
                
                if apiConnector.errorDescription != nil {
                    print(apiConnector.errorDescription!)
                    
                    let loginController = LoginVC()
                    let navController = UINavigationController(rootViewController: loginController)
                    UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
                    
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
        return detalleProveedoresContactos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = detalleProveedoresContactos[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(contactosBancos[indexPath.item].identificador!)
        
        let detalleProveedorVC = DetalleProveedorVC()
        detalleProveedorVC.detalleProveedorDict = [detalleProveedorDict[indexPath.item]]
        
        let navController = UINavigationController(rootViewController: detalleProveedorVC)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
        
    }
    
}
