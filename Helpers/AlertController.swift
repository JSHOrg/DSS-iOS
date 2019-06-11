//
//  AlertController.swift
//  JaliscoSinHambre
//
//  Created by usuario on 23/05/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

let alertController = AlertController()

class AlertController {
    
    var mensajeError : String?
    
    //MARK: Alerta error
    func alertError(titulo: String?, mensaje: String) -> UIAlertController {
        
        self.mensajeError = mensaje
        
        print(mensajeError!)
        let alertController = UIAlertController(title: titulo, message: mensajeError, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print("OK")
            
        }
        
        alertController.addAction(okAction)
        
        return alertController
    }
    
    //MARK: Alerta Aceptar/Cancelar
    func alertAceptarCancelar(mensaje: String, btnAceptar: String, btnCancelar: String) -> UIAlertController {
        
        self.mensajeError = mensaje
        
        print(mensajeError!)
        
        let alertController = UIAlertController(title: nil, message: mensajeError, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print("OK")
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.destructive) { (result : UIAlertAction) -> Void in
            print("cancel")
            
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    
}
