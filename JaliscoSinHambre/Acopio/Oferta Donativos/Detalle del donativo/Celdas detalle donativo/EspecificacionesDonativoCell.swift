//
//  EspecificacionesDonativoCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 07/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class EspecificacionesDonativoCell: FeedDetalleDonativoCell {
   
    override func fetchDetalleDonativo() {
        etiquetasArr = ["Tipo de transporte", "Especificaciones generales"]
        
        infoDonativoArr = ["\(detalleDonativoDict.first?.tipoTransporte ?? "")", "\(detalleDonativoDict.first?.especificaciones ?? "")"]
        
    }
}
