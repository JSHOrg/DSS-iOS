//
//  DetalleProveedorVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 10/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class DetalleProveedorVC: DetalleBenefactorVC {
    
    var detalleProveedorDict = [Proveedor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Detalle de proveedor")
        setupViews()
        fetchInfoBenefactor()
    }
    
    override func fetchInfoBenefactor() {
        etiquetasArr = ["Proveedor", "Nombre", "Apellido", "Teléfono", "Extensión", "Celular", "Correo electrónico"]
        
        infoBenefactorArr = ["\(detalleProveedorDict.first?.nombreProveedor ?? "")", "\(detalleProveedorDict.first?.nombreContactoProveedor ?? "")", "\(detalleProveedorDict.first?.apellidoContactoProveedor ?? "")", "\(detalleProveedorDict.first?.telefonoContactoProveedor ?? "")", "\(detalleProveedorDict.first?.extensionContactoProveedor ?? "")", "\(detalleProveedorDict.first?.celularContactoProveedor ?? "")", "\(detalleProveedorDict.first?.correoContactoProveedor ?? "")"]
        
    }
    
}
