//
//  MapaBancosCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 01/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit
import MapKit

var arrayMapaBancoAlimentos : [MapaBancosDeAlimentos] = []

class MapaBancosCell: FeedMapaCell {
    
    override func fetchAgenda() {
        
        activityIndicator.startAnimating()
        
        for direccionBanco in arrayContactosBancoAlimentos {
            
            guard let calle = direccionBanco.direccion!["calle"] as? NSString else { return }
            let numero = direccionBanco.direccion!["numero"] as? String
            let ciudad = direccionBanco.direccion!["cuidad"] as? String
            let estado = direccionBanco.direccion!["estado"] as? String
            let latitud = direccionBanco.direccion!["latitud"] as? NSString
            let longitud = direccionBanco.direccion!["longitud"] as? NSString
            let colonia = direccionBanco.direccion!["colonia"] as? String
            let cp = direccionBanco.direccion!["cp"] as? String
            
            guard let nombre = direccionBanco.nombre else { return }
            let nombreArr = nombre.components(separatedBy: " ")
            let segundaInicial = nombreArr.last?.first
            
            let iniciales = "\(String(describing: nombreArr[0].first!))\(String(describing: segundaInicial!))"  //.key.first
            
            self.contactos.append(Contacto(inicial: "\(iniciales.uppercased())", nombreContacto: direccionBanco.nombre, direccionContacto: "Calle: \(calle) #\(numero ?? "")", beneficiariosContacto: "CP: \(cp ?? "")", identificador: "MapaBancosAlimentos"))

            arrayMapaBancoAlimentos.append(MapaBancosDeAlimentos(calle: calle as String, numero: numero, ciudad: ciudad, estado: estado, latitud: latitud, longitud:longitud, colonia: colonia, cp: cp))


            let direccion = "Calle \(calle) # \(String(describing: numero!))\nColonia \(String(describing: colonia!))  C.P. \(String(describing: cp!))"

            guard let lat = latitud else { return }
            guard let lon = longitud else { return }
            
            self.addAnnotation(lat: lat, lon: lon, nombre: nombre, direccion: direccion, iniciales: iniciales)
            
            
        }
        
        activityIndicator.stopAnimating()
        
        self.collectionView.reloadData()
        
    }
    
}
