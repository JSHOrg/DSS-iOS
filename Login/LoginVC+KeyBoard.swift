//
//  LoginVC+KeyBoard.swift
//  JaliscoSinHambre
//
//  Created by usuario on 20/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension LoginVC {
    
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func KeyboardHide() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    @objc func KeyboardShow() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == cuentaTextField {
            contraseñaTextField.becomeFirstResponder()
        } else if textField == contraseñaTextField {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    //tocar cualquier lado quita el teclado, solo que en este caso en dentro de la celda y no en la vista completa
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == contraseñaTextField {
            textField.text = ""
        }
    }
    
}
