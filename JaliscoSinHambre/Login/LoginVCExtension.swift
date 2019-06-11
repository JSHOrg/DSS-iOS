//
//  LoginVCExtension.swift
//  JaliscoSinHambre
//
//  Created by usuario on 20/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension LoginVC {
    
    func setupViews() {
        
        iniciarSesionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleIngresar)))
        olvideContraseñaButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOlvideContraseña)))
        
        cuentaTextField.delegate = self
        contraseñaTextField.delegate = self
        
        cuentaTextField.text = "superAdmin"
        contraseñaTextField.text = "pass1"
        
        view.addSubview(jaliscoSinHambreIcon)
        view.addSubview(cuentaTextField)
        view.addSubview(contraseñaTextField)
        view.addSubview(iniciarSesionButton)
        view.addSubview(olvideContraseñaButton)
        view.addSubview(activityIndicator)
        
        jaliscoSinHambreIcon.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        jaliscoSinHambreIcon.heightAnchor.constraint(equalToConstant: 160).isActive = true
        jaliscoSinHambreIcon.widthAnchor.constraint(equalToConstant: 230).isActive = true
        jaliscoSinHambreIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56).isActive = true
        
        cuentaTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 13).isActive = true
        cuentaTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -13).isActive = true
        cuentaTextField.topAnchor.constraint(equalTo: jaliscoSinHambreIcon.bottomAnchor, constant: 53).isActive = true
        cuentaTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        contraseñaTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 13).isActive = true
        contraseñaTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -13).isActive = true
        contraseñaTextField.topAnchor.constraint(equalTo: cuentaTextField.bottomAnchor, constant: 17).isActive = true
        contraseñaTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        iniciarSesionButton.topAnchor.constraint(equalTo: contraseñaTextField.bottomAnchor, constant: 43).isActive = true
        iniciarSesionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 13).isActive = true
        iniciarSesionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -13).isActive = true
        iniciarSesionButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        olvideContraseñaButton.topAnchor.constraint(equalTo: iniciarSesionButton.bottomAnchor, constant: 44).isActive = true
        olvideContraseñaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 99).isActive = true
        olvideContraseñaButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -99).isActive = true
        olvideContraseñaButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        activityIndicator.topAnchor.constraint(equalTo: iniciarSesionButton.bottomAnchor, constant: 44).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    @objc func handleIngresar() {
        
        iniciarSesionButton.isEnabled = false
        iniciarSesionButton.backgroundColor = UIColor.rgb(red: 33, green: 150, blue: 83).withAlphaComponent(0.5)
        
        if (!(cuentaTextField.text?.isEmpty)!) && (!(contraseñaTextField.text?.isEmpty)!) {
            
            activityIndicator.startAnimating()
            
            apiConnector.iniciarSesion(username: cuentaTextField.text!, password: contraseñaTextField.text!, completionSucces: {
                DispatchQueue.main.async{
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
                    
                    mainTabBarController.setupViewControllers()
                    
                    self.activityIndicator.stopAnimating()
                    
                    self.iniciarSesionButton.isEnabled = true
                    self.iniciarSesionButton.backgroundColor = UIColor.rgb(red: 33, green: 150, blue: 83).withAlphaComponent(1)
                    
                    self.dismiss(animated: true, completion: nil)
                }
            }) {
                DispatchQueue.main.async{
                    print("Problemas al ingresar")
                    let alert = alertController.alertError(titulo: nil, mensaje: "Datos no válidos")
                    self.present(alert, animated: true, completion: nil)
                    
                    self.iniciarSesionButton.isEnabled = true
                    self.iniciarSesionButton.backgroundColor = UIColor.rgb(red: 33, green: 150, blue: 83).withAlphaComponent(1)
                    
                    self.activityIndicator.stopAnimating()
                }
                
            }
            
        } else {
            
            print("Campos vacíos")
            let alert = alertController.alertError(titulo: nil, mensaje: "Favor de ingresar usuario y/o contraseña")
            self.present(alert, animated: true, completion: nil)
            
            self.iniciarSesionButton.isEnabled = true
            self.iniciarSesionButton.backgroundColor = UIColor.rgb(red: 33, green: 150, blue: 83).withAlphaComponent(1)
            
        }
        
    }
    
    @objc func handleOlvideContraseña(){
        print("Olvidé mi contraseña")
    }
    
}
