//
//  MapaAcopioCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 29/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit
import MapKit

var arrayMapaCentrosDeAcopio : [MapaBancosDeAlimentos] = []

class MapaAcopioCell: FeedMapaCell {
    
    override func fetchAgenda() {
        
        activityIndicator.startAnimating()
        
        for direccionCentroAcopio in arrayContactosCentrosAcopio {
            
            let dir = direccionCentroAcopio.bancosAlimentos!["direccion"] as? NSDictionary
            
            guard let calle = dir!["calle"] as? NSString else { return }
            let numero = dir!["numero"] as? String
            let ciudad = dir!["cuidad"] as? String
            let estado = dir!["estado"] as? String
            let latitud = dir!["latitud"] as? NSString
            let longitud = dir!["longitud"] as? NSString
            let colonia = dir!["colonia"] as? String
            let cp = dir!["cp"] as? String
            
            let nombre = direccionCentroAcopio.bancosAlimentos!["nombre"] as? String
            let nombreArr = nombre?.components(separatedBy: " ")
            let segundaInicial = nombreArr?.last?.first
            
            let iniciales = "\(String(describing: nombreArr![0].first!))\(String(describing: segundaInicial!))"  //.key.first
            
            self.contactos.append(Contacto(inicial: "\(iniciales.uppercased())", nombreContacto: nombre, direccionContacto: "Calle: \(calle) #\(numero ?? "")", beneficiariosContacto: "CP: \(cp ?? "")", identificador: "MapaBancosAlimentos"))
            
            arrayMapaCentrosDeAcopio.append(MapaBancosDeAlimentos(calle: calle as String, numero: numero, ciudad: ciudad, estado: estado, latitud: latitud, longitud:longitud, colonia: colonia, cp: cp))
            
            
            let direccion = "Calle \(calle) # \(String(describing: numero!))\nColonia \(String(describing: colonia!))  C.P. \(String(describing: cp!))"
            
            guard let lat = latitud else { return }
            guard let lon = longitud else { return }
            
            self.addAnnotation(lat: lat, lon: lon, nombre: nombre!, direccion: direccion, iniciales: iniciales)
            
            
        }
        
        activityIndicator.stopAnimating()
        
        self.collectionView.reloadData()
    }
    
}
