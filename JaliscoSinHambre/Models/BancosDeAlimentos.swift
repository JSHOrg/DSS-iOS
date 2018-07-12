//
//  BancosDeAlimentos.swift
//  JaliscoSinHambre
//
//  Created by usuario on 01/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import Foundation

struct BancosDeAlimentos {
    
    var nombre : String?
    var razonSocial : String?
    var calificacion : String?
    var habilitado : Bool?
    var telefono : String?
    var email : String?
    var _links : NSDictionary?
    var direccion : NSDictionary?
    
}

struct MapaBancosDeAlimentos {
    
    var calle : String?
    var numero : String?
    var ciudad : String?
    var estado : String?
    var latitud : NSString?
    var longitud : NSString?
    var colonia : String?
    var cp : String?
    
}
