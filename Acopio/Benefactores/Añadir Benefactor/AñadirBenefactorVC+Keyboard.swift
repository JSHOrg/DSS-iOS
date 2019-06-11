//
//  AñadirBenefactorVC+Keyboard.swift
//  JaliscoSinHambre
//
//  Created by usuario on 10/31/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension AñadirBenefactorVC {
    
    func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func KeyboardHide(notification:NSNotification) {
        
        let userInfo = notification.userInfo!
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            let contentInset:UIEdgeInsets = UIEdgeInsets.zero
            self.scrollView.contentInset = contentInset
        }
        
    }
    
    @objc func KeyboardShow(notification:NSNotification) {
        
        let userInfo = notification.userInfo!
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animationDuration) {
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            self.scrollView.contentInset.bottom = keyboardFrame.size.height + 40
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    //tocar cualquier lado quita el teclado, solo que en este caso en dentro de la celda y no en la vista completa
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
