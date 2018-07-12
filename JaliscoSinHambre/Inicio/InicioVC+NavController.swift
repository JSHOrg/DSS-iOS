//
//  InicioVC+NavController.swift
//  JaliscoSinHambre
//
//  Created by usuario on 20/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension InicioVC {
    
    func setupLeftTitleNav(title: String) {
        
        let titleLabel = UILabel()
        titleLabel.text = "   \(title)"
        titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.87)
        titleLabel.font = UIFont.robotoMediumStyle20
        titleLabel.textAlignment = .left
        titleLabel.sizeToFit()
        
        let firstButton = UIButton(type: .system)
//        firstButton.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        firstButton.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        
        let tituloItem = UIBarButtonItem(customView: titleLabel)
        let opcionesItem = UIBarButtonItem(customView: firstButton)
        
        self.navigationItem.setLeftBarButtonItems([opcionesItem, tituloItem], animated: false)
        
//        setupMenu()
        
    }
    
    func setupMenu() {
        
        if let window = UIApplication.shared.keyWindow {

            window.addSubview(self.backgroundButton)
            window.addSubview(self.menuCV)
        }
        
    }
    
    
    func setupRightNavItems() {
        
        let firstButton = UIButton()
        firstButton.frame = CGRect(x: 0, y: 0, width: 35, height: 20)
        firstButton.setImage(#imageLiteral(resourceName: "Notificaciones"), for: .normal)
        firstButton.addTarget(self, action: #selector(handleNotificaciones), for: .touchUpInside)
        
        let secondButton = UIButton()
        secondButton.frame = CGRect(x: 0, y: 0, width: 35, height: 20)
        secondButton.setImage(#imageLiteral(resourceName: "More"), for: .normal)
        secondButton.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
        
        
        let notificacionBtn: UIBarButtonItem = UIBarButtonItem(customView: firstButton)
        let moreBtn: UIBarButtonItem = UIBarButtonItem(customView: secondButton)
        
        self.navigationItem.setRightBarButtonItems([moreBtn, notificacionBtn], animated: false)
        
    }
    
    @objc func handleMenuInicio() {

//        self.performSegue(withIdentifier: "segueMenu", sender: self)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            self.backgroundButton.alpha = 1
            self.menuCV.alpha = 1

            self.menuCV.frame = CGRect(x: 0, y: 0, width: 240, height: (UIApplication.shared.keyWindow?.frame.height)!)

//            let navBarHeight = self.view.safeAreaInsets.top
//
//            self.backgroundButton.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: (UIApplication.shared.keyWindow?.frame.width)!, height: (UIApplication.shared.keyWindow?.frame.height)!)

        }, completion: nil)
        
    }
    
    @objc func handleNotificaciones() {
        self.performSegue(withIdentifier: "segueNotificaciones", sender: self)
    }
    
    @objc func handleMore() {
        
        let alert = UIAlertController(title: nil, message: "Más opciones", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Acerca de", style: .default, handler: { (action) in
            print("Acerca de")
        }))
        
        alert.addAction(UIAlertAction(title: "Aviso de privacidad", style: .default, handler: { (action) in
            print("Aviso de privacidad")
        }))
        
        alert.addAction(UIAlertAction(title: "Soporte", style: .default, handler: { (action) in
            print("Soporte")
        }))
        
        alert.addAction(UIAlertAction(title: "Cerrar sesión", style: .destructive, handler: { (action) in
            self.cerrarSesionAlertInicio()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            print("Cancelar")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func cerrarSesionAlertInicio() {
        
        let alertController = UIAlertController(title: "Cerrar sesión", message: "¿Está seguro de cerrar sesión?", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
            Switcher.updateRootVC(identifier: "loginVc")
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("cancelar")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
