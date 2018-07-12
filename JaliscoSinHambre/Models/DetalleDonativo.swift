//
//  DetalleDonativo.swift
//  JaliscoSinHambre
//
//  Created by usuario on 09/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import Foundation

struct DetalleDonativo {
    
    //celda
    var nombreProducto : String?
    var fechaAcopio : String?
    var tipoTransporte : String?
    var nombreProcurador : String?
    
    //producto
    var cantidadKG : String?
    var fechaConsumoLimite : String?
    var cosechado : String?
    var pagoCosecha : String?
    var embalaje : String?
    var tipoEmbalaje : String?
    
    //Acopio
    var domicilioAcopio : String?
    var telefonoAcopio : String?
    var extensionAcopio : String?
    var celularAcopio : String?
    
    //Especificaciones
    var proveedorSugerido : String?
    var especificaciones : String?
    
    //procurador
    var correoProcurador : String?
    var telefonoProcurador : String?
    var celularProcurador : String?
    
}
