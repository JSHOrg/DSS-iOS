//
//  AcopioDonativoCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 07/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class AcopioDonativoCell: FeedDetalleDonativoCell {
    
    
    override func fetchDetalleDonativo() {
        etiquetasArr = ["Fecha de acopio", "Domicilio del acopio", "Teléfono", "Extensión", "Celular"]
        
        infoDonativoArr = ["\(detalleDonativoDict.first?.fechaAcopio ?? "")", "\(detalleDonativoDict.first?.domicilioAcopio ?? "")", "\(detalleDonativoDict.first?.telefonoAcopio ?? "")", "\(detalleDonativoDict.first?.extensionAcopio ?? "")", "\(detalleDonativoDict.first?.celularAcopio ?? "")"]
        
    }
}
