//
//  DetalleContactosVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 06/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class DetalleContactosVC: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let dismissViewButton : UIButton = {
       let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "Regresar"), for: .normal)
        button.tintColor = UIColor.mainBlack()
        button.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
        return button
    }()
    
    let nombreBanco : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.robotoMediumStyle20
        label.textColor = UIColor.mainBlack()
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    let navigationView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9763854146, green: 0.9765252471, blue: 0.9763546586, alpha: 1)
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
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.mainGreen()
        return activity
    }()
    
    let cellId = "cellId"
    
    var detalleContactos = [Contacto]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        if identificadorAgenda == "BancosAlimentos" {
            guard let nombre = contactosBancos[indexContactos!].nombreContacto else { return }
            self.nombreBanco.text = nombre
        } else if identificadorAgenda == "CentrosComunitarios" {
            guard let nombre = contactosCentros[indexContactos!].nombreContacto else { return }
            self.nombreBanco.text = nombre
        } else {
            guard let nombre = contactosAcopio[indexContactos!].nombreContacto else { return }
            self.nombreBanco.text = nombre
        }
        
        setupViews()
        fetchContactos()
        
    }
    
    func fetchContactos() {
        
        activityIndicator.startAnimating()
        
        var url = ""
        
        if identificadorAgenda == "BancosAlimentos" {
            let direccionBanco = arrayContactosBancoAlimentos[indexContactos!]
            print(arrayContactosBancoAlimentos[indexContactos!])
            guard let direccion = direccionBanco._links!["contacto"] as? NSDictionary else { return }
            guard let href = direccion["href"] as? String else { return }
            url = href
        } else if identificadorAgenda == "CentrosComunitarios" {
            let direccionBanco = arrayContactosCentrosComunitarios[indexContactos!]
            guard let direccion = direccionBanco._links!["contacto"] as? NSDictionary else { return }
            guard let href = direccion["href"] as? String else { return }
            url = href
        } else {
            let direccionBanco = arrayContactosCentrosAcopio[indexContactos!]
            guard let direccion = direccionBanco._links!["contacto"] as? NSDictionary else { return }
            guard let href = direccion["href"] as? String else { return }
            url = href
        }
        
        apiConnector.fetchContactoBanco(urlContactoBanco: url, completionSucces: { (contactos) in
            
            DispatchQueue.main.async {
                
                infoContactoDict = contactos
                
                guard let nombre = contactos["nombre"] as? String else { return }
                guard let apellido = contactos["apellido"] as? String else { return }
                
                let nombreValidado = nombre.isEmpty ? "" : "\(nombre.first!)"
                let apellidoValidado = apellido.isEmpty ? "" : "\(apellido.first!)"
                
                let iniciales = "\(nombreValidado)\(apellidoValidado)"
                
                let nombreCompleto = "\(String(describing: nombre)) \(String(describing: apellido))"
                
                guard let email = contactos["email"] as? String else { return }
                
                let correo = "Correo: \(email)"
                
                guard let telefono = contactos["telefono"] as? String else { return }
                guard let ext = contactos["extension"] as? Int else { return }
                
                let telefonoExt = "Tel: \(telefono) Ext: \(ext)"
                
                self.detalleContactos.append(Contacto(inicial: iniciales.uppercased(), nombreContacto: nombreCompleto, direccionContacto: correo, beneficiariosContacto: telefonoExt, identificador: "ContactoPorBanco"))
                
                self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
            }
            
        }) {
            
            DispatchQueue.main.async {
                
                var errorMsg = ""
                
                if apiConnector.errorDescription != nil {
                    print(apiConnector.errorDescription!)
                    
                } else {
                    print("Error al cargar detalle contacto")
                    errorMsg = "Error al cargar datos"
                }
                
                let alert = alertController.alertError(titulo: nil, mensaje: "\(errorMsg)")
                
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detalleContactos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = detalleContactos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            setupInfoContactoView(keyWindow: keyWindow)
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

