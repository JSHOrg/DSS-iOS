//
//  MapaCentrosCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 05/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit
import MapKit

var arrayMapaCentrosComunitarios : [MapaBancosDeAlimentos] = []

class MapaCentrosCell: FeedMapaCell {
    
    override func fetchAgenda() {
        
        activityIndicator.startAnimating()
        
        for direccionCentroComunitario in arrayContactosCentrosComunitarios {
            
            guard let calle = direccionCentroComunitario.direccion!["calle"] as? NSString else { return }
            let numero = direccionCentroComunitario.direccion!["numero"] as? String
            let ciudad = direccionCentroComunitario.direccion!["cuidad"] as? String
            let estado = direccionCentroComunitario.direccion!["estado"] as? String
            let latitud = direccionCentroComunitario.direccion!["latitud"] as? NSString
            let longitud = direccionCentroComunitario.direccion!["longitud"] as? NSString
            let colonia = direccionCentroComunitario.direccion!["colonia"] as? String
            let cp = direccionCentroComunitario.direccion!["cp"] as? String
            
            guard let nombre = direccionCentroComunitario.nombre else { return }
            let nombreArr = nombre.components(separatedBy: " ")
            let segundaInicial = nombreArr.last?.first
            
            let iniciales = "\(String(describing: nombreArr[0].first!))\(String(describing: segundaInicial!))"  //.key.first
            
            self.contactos.append(Contacto(inicial: "\(iniciales.uppercased())", nombreContacto: direccionCentroComunitario.nombre, direccionContacto: "Calle: \(calle) #\(numero ?? "")", beneficiariosContacto: "CP: \(cp ?? "")", identificador: "MapaBancosAlimentos"))
            
            arrayMapaCentrosComunitarios.append(MapaBancosDeAlimentos(calle: calle as String, numero: numero, ciudad: ciudad, estado: estado, latitud: latitud, longitud:longitud, colonia: colonia, cp: cp))
            
            
            let direccion = "Calle \(calle) # \(String(describing: numero!))\nColonia \(String(describing: colonia!))  C.P. \(String(describing: cp!))"
            
            guard let lat = latitud else { return }
            guard let lon = longitud else { return }
            
            self.addAnnotation(lat: lat, lon: lon, nombre: nombre, direccion: direccion, iniciales: iniciales)
            
            
        }
        
        activityIndicator.stopAnimating()
        
        self.collectionView.reloadData()
        
    }
    
}
