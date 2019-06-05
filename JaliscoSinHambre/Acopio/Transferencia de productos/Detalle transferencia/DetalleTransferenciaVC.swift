//
//  DetalleTransferenciaVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 05/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class DetalleTransferenciaVC: DetalleBenefactorVC {
    
    var detalleTransferenciaEntradaDict = [EntradaAlmacen]()
    var detalleTransferenciaSalidaDict = [SalidaAlmacen]()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Detalle de transferencia")
        setupViews()
        fetchInfoBenefactor()
    }
    
    override func fetchInfoBenefactor() {
        
        if !detalleTransferenciaEntradaDict.isEmpty {
            
            etiquetasArr = ["Nombre", "Dirección", "Teléfono", "Fecha de entrada", "Producto ", "Cantidad", "Unidad", "Descripción", "Peso unitario", "Peso total"]
            
            infoBenefactorArr = ["\(detalleTransferenciaEntradaDict.first?.nombreUsuario! ?? "-")", "\(detalleTransferenciaEntradaDict.first?.direccionUsuario ?? "-")", "\(detalleTransferenciaEntradaDict.first?.telefonoUsuario ?? "-")", "\(detalleTransferenciaEntradaDict.first?.fechaEntrada! ?? "-")", "\(detalleTransferenciaEntradaDict.first?.nombreProducto! ?? "-")", "\(detalleTransferenciaEntradaDict.first?.cantidadKg! ?? "-") Kg", "\(detalleTransferenciaEntradaDict.first?.cantidadPza! ?? "-") Pza", "\(detalleTransferenciaEntradaDict.first?.comentarios! ?? "-")", "\(detalleTransferenciaEntradaDict.first?.pesoUnitario! ?? Float(0.0)) Kg", "\(detalleTransferenciaEntradaDict.first?.pesoTotal! ?? 0) Kg"]
        } else {
            
            etiquetasArr = ["Nombre", "Motivo", "Cantidad", "Fecha de salida"]
            
            infoBenefactorArr = ["\(detalleTransferenciaSalidaDict.first?.nombreUsuario! ?? "-")", "\(detalleTransferenciaSalidaDict.first?.motivo! ?? "-")", "\(detalleTransferenciaSalidaDict.first?.cantidad ?? "-")", "\(detalleTransferenciaSalidaDict.first?.fechaSalida! ?? "-")"]
        }
        
    }
    
    override func handleDismissView() {
        //procede de un present
        dismiss(animated: true, completion: nil)
    }
}

