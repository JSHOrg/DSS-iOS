//
//  DetalleSolicitudVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 09/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class DetalleSolicitudVC: DetalleBenefactorVC {
    
    var detalleSolicitudRecoleccionDict = [SolicitudRecoleccion]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Detalle de solicitud")
        setupViews()
        fetchInfoBenefactor()
    }
    
    override func fetchInfoBenefactor() {
        etiquetasArr = ["Empresa", "Domicilio", "Ciudad", "Nombre de contacto", "Tipo de producto", "Cantidad", "Fecha de recolección", "Hora de recolección", "Tipo de vehículo", "Nombre de quien entrega", "Nombre de quien recibe"]
        
        infoBenefactorArr = ["\(detalleSolicitudRecoleccionDict.first?.nombreEmpresa ?? "")", "\(detalleSolicitudRecoleccionDict.first?.domicilioEmpresa ?? "")", "\(detalleSolicitudRecoleccionDict.first?.ciudadRecoleccion ?? "")", "\(detalleSolicitudRecoleccionDict.first?.nombreContacto ?? "")", "\(detalleSolicitudRecoleccionDict.first?.tipoProducto ?? "")", "\(detalleSolicitudRecoleccionDict.first?.cantidadProducto ?? "")", "\(detalleSolicitudRecoleccionDict.first?.fechaRecoleccion ?? "")", "\(detalleSolicitudRecoleccionDict.first?.horaRecoleccion ?? "")", "\(detalleSolicitudRecoleccionDict.first?.tipoVehiculo ?? "")", "\(detalleSolicitudRecoleccionDict.first?.nombreEntrega ?? "")", "\(detalleSolicitudRecoleccionDict.first?.nombreContacto ?? "")"]
    }
    
}
