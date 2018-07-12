//
//  SolicitudRecoleccionVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 09/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class SolicitudRecoleccionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.mainGreen()
        return activity
    }()
    
    let cellId = "cellId"
    var detalleSolicitudDict = [SolicitudRecoleccion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Solicitud de recolección")
        setupViews()
    }
    
    var tipoProducto = [String]()
    var cantidadkg = [String]()
    var tipoUnidad = [String]()
    var domicilioAcopio = [String]()
    var ciudadAcopio = [String]()
    
    func fetchSolicitudRecoleccion() {
        
        activityIndicator.startAnimating()
        
        detalleSolicitudRecoleccionContactos.removeAll()
        tipoProducto.removeAll()
        cantidadkg.removeAll()
        tipoUnidad.removeAll()
        domicilioAcopio.removeAll()
        ciudadAcopio.removeAll()
        
        apiConnector.fetchSolicitudRecoleccion(completionSucces: { (solicitudRecoleccion) in
            DispatchQueue.main.async{
                
                self.detalleSolicitudDict = solicitudRecoleccion
                
                for recoleccion in solicitudRecoleccion {
                    
                    
                    guard let _links = recoleccion._links else { return }
                    
                    apiConnector.fetchLinksProducto(links: _links, completionSucces: { (producto) in
                        DispatchQueue.main.async {
                            
                            let firstCharecter = recoleccion.nombreEmpresa?.first
                            
                            self.tipoProducto.append(producto.0)
                            self.cantidadkg.append(producto.1)
                            self.tipoUnidad.append(producto.2)
                            self.domicilioAcopio.append(producto.3)
                            self.ciudadAcopio.append(producto.4)
                            
                            detalleSolicitudRecoleccionContactos.append(Contacto(inicial: "\(firstCharecter!)", nombreContacto: recoleccion.nombreEmpresa, direccionContacto: "Fecha recolección: \(recoleccion.fechaRecoleccion ?? "")", beneficiariosContacto: "Producto: \(self.tipoProducto.last ?? "")", identificador: "Solicitud recoleccion"))
                            
                            
                            self.collectionView.reloadData()
                            
                        }
                    }, completionError: {
                        DispatchQueue.main.async {
                            if apiConnector.errorDescription != nil {
                                print(apiConnector.errorDescription!)
                                
                            } else {
                                print("Error al cargar entrada almacen")
                            }
                        
                            self.activityIndicator.stopAnimating()
                            
                        }
                    })
                    
                    
                }
                
                self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
            }
        }) {
            
            DispatchQueue.main.async {
                
                var errorMsg = ""
                
                if apiConnector.errorDescription != nil {
                    print(apiConnector.errorDescription!)
                    
                    let loginController = LoginVC()
                    let navController = UINavigationController(rootViewController: loginController)
                    UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
                    
                } else {
                    print("Error al cargar solicitud de recoleccion")
                    errorMsg = "Error al cargar datos"
                }
                
                let alert = alertController.alertError(titulo: nil, mensaje: "\(errorMsg)")
                
                self.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()
                
            }

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detalleSolicitudRecoleccionContactos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = detalleSolicitudRecoleccionContactos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detalleSolicitudVC = DetalleSolicitudVC()
        
        self.detalleSolicitudDict[indexPath.item].tipoProducto = tipoProducto[indexPath.item]
        self.detalleSolicitudDict[indexPath.item].cantidadProducto = cantidadkg[indexPath.item]
        self.detalleSolicitudDict[indexPath.item].tipoVehiculo = tipoUnidad[indexPath.item]
        self.detalleSolicitudDict[indexPath.item].domicilioEmpresa = domicilioAcopio[indexPath.item]
        self.detalleSolicitudDict[indexPath.item].ciudadRecoleccion = ciudadAcopio[indexPath.item]
        
        detalleSolicitudVC.detalleSolicitudRecoleccionDict = [self.detalleSolicitudDict[indexPath.item]]
        
        navigationController?.pushViewController(detalleSolicitudVC, animated: true)
        
    }
    
    
}
