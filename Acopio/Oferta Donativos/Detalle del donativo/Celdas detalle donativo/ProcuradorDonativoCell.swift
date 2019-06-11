//
//  ProcuradorDonativoCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 07/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class ProcuradorDonativoCell: FeedDetalleDonativoCell {
    
    override func fetchDetalleDonativo() {
        
        etiquetasArr = ["Nombre del procurador", "Correo electrónico", "Teléfono", "Celular"]
        
        infoDonativoArr = ["\(detalleDonativoDict.first?.nombreProcurador ?? "")", "\(detalleDonativoDict.first?.correoProcurador ?? "")", "\(detalleDonativoDict.first?.telefonoProcurador ?? "")", "\(detalleDonativoDict.first?.celularProcurador ?? "")"]
        
    }
    
}
