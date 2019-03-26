//
//  AñadirBenefactorVC+Extension.swift
//  JaliscoSinHambre
//
//  Created by usuario on 10/31/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension AñadirBenefactorVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupViews() {
        
        razonSocialTextField.delegate = self
        nombreContactoTextField.delegate = self
        domicilioTextField.delegate = self
        ciudadTextField.delegate = self
        coloniaTextField.delegate = self
        estadoTextField.delegate = self
        codigoPostalTextField.delegate = self
        telefonoTextField.delegate = self
        correoTextField.delegate = self
        
        view.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 44).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(separatorView)
        
        separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: screenWidth, height: screenHeight))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        
        view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 1).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        scrollView.contentSize = CGSize(width: screenWidth, height: 800)
        
        scrollView.addSubview(razonSocialLabel)
        scrollView.addSubview(razonSocialTextField)
        scrollView.addSubview(nombreContactoLabel)
        scrollView.addSubview(nombreContactoTextField)
        scrollView.addSubview(domicilioLabel)
        scrollView.addSubview(domicilioTextField)
        scrollView.addSubview(ciudadLabel)
        scrollView.addSubview(ciudadTextField)
        scrollView.addSubview(coloniaLabel)
        scrollView.addSubview(coloniaTextField)
        scrollView.addSubview(estadoLabel)
        scrollView.addSubview(estadoTextField)
        scrollView.addSubview(codigoPostalLabel)
        scrollView.addSubview(codigoPostalTextField)
        scrollView.addSubview(telefonoLabel)
        scrollView.addSubview(telefonoTextField)
        scrollView.addSubview(correoLabel)
        scrollView.addSubview(correoTextField)
        
        
        razonSocialLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 34).isActive = true
        razonSocialLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 23).isActive = true
        razonSocialLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -23).isActive = true
        razonSocialLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        razonSocialTextField.topAnchor.constraint(equalTo: razonSocialLabel.bottomAnchor, constant: 1).isActive = true
        razonSocialTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 23).isActive = true
        razonSocialTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -23).isActive = true
        razonSocialTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nombreContactoLabel.topAnchor.constraint(equalTo: razonSocialTextField.bottomAnchor, constant: 16).isActive = true
        nombreContactoLabel.leadingAnchor.constraint(equalTo: razonSocialTextField.leadingAnchor, constant: 0).isActive = true
        nombreContactoLabel.trailingAnchor.constraint(equalTo: razonSocialTextField.trailingAnchor, constant: 0).isActive = true
        nombreContactoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nombreContactoTextField.topAnchor.constraint(equalTo: nombreContactoLabel.bottomAnchor, constant: 1).isActive = true
        nombreContactoTextField.leadingAnchor.constraint(equalTo: nombreContactoLabel.leadingAnchor, constant: 0).isActive = true
        nombreContactoTextField.trailingAnchor.constraint(equalTo: nombreContactoLabel.trailingAnchor, constant: 0).isActive = true
        nombreContactoTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nombreContactoLabel.topAnchor.constraint(equalTo: razonSocialTextField.bottomAnchor, constant: 16).isActive = true
        nombreContactoLabel.leadingAnchor.constraint(equalTo: razonSocialTextField.leadingAnchor, constant: 0).isActive = true
        nombreContactoLabel.trailingAnchor.constraint(equalTo: razonSocialTextField.trailingAnchor, constant: 0).isActive = true
        nombreContactoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nombreContactoTextField.topAnchor.constraint(equalTo: nombreContactoLabel.bottomAnchor, constant: 1).isActive = true
        nombreContactoTextField.leadingAnchor.constraint(equalTo: nombreContactoLabel.leadingAnchor, constant: 0).isActive = true
        nombreContactoTextField.trailingAnchor.constraint(equalTo: nombreContactoLabel.trailingAnchor, constant: 0).isActive = true
        nombreContactoTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        domicilioLabel.topAnchor.constraint(equalTo: nombreContactoTextField.bottomAnchor, constant: 16).isActive = true
        domicilioLabel.leadingAnchor.constraint(equalTo: nombreContactoTextField.leadingAnchor, constant: 0).isActive = true
        domicilioLabel.trailingAnchor.constraint(equalTo: nombreContactoTextField.trailingAnchor, constant: 0).isActive = true
        domicilioLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        domicilioTextField.topAnchor.constraint(equalTo: domicilioLabel.bottomAnchor, constant: 1).isActive = true
        domicilioTextField.leadingAnchor.constraint(equalTo: domicilioLabel.leadingAnchor, constant: 0).isActive = true
        domicilioTextField.trailingAnchor.constraint(equalTo: domicilioLabel.trailingAnchor, constant: 0).isActive = true
        domicilioTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ciudadLabel.topAnchor.constraint(equalTo: domicilioTextField.bottomAnchor, constant: 16).isActive = true
        ciudadLabel.leadingAnchor.constraint(equalTo: domicilioTextField.leadingAnchor, constant: 0).isActive = true
        ciudadLabel.trailingAnchor.constraint(equalTo: domicilioTextField.trailingAnchor, constant: 0).isActive = true
        ciudadLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        ciudadTextField.topAnchor.constraint(equalTo: ciudadLabel.bottomAnchor, constant: 1).isActive = true
        ciudadTextField.leadingAnchor.constraint(equalTo: ciudadLabel.leadingAnchor, constant: 0).isActive = true
        ciudadTextField.trailingAnchor.constraint(equalTo: ciudadLabel.trailingAnchor, constant: 0).isActive = true
        ciudadTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        coloniaLabel.topAnchor.constraint(equalTo: ciudadTextField.bottomAnchor, constant: 16).isActive = true
        coloniaLabel.leadingAnchor.constraint(equalTo: ciudadTextField.leadingAnchor, constant: 0).isActive = true
        coloniaLabel.trailingAnchor.constraint(equalTo: ciudadTextField.trailingAnchor, constant: 0).isActive = true
        coloniaLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        coloniaTextField.topAnchor.constraint(equalTo: coloniaLabel.bottomAnchor, constant: 1).isActive = true
        coloniaTextField.leadingAnchor.constraint(equalTo: coloniaLabel.leadingAnchor, constant: 0).isActive = true
        coloniaTextField.trailingAnchor.constraint(equalTo: coloniaLabel.trailingAnchor, constant: 0).isActive = true
        coloniaTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        estadoLabel.topAnchor.constraint(equalTo: coloniaTextField.bottomAnchor, constant: 16).isActive = true
        estadoLabel.leadingAnchor.constraint(equalTo: coloniaTextField.leadingAnchor, constant: 0).isActive = true
        estadoLabel.trailingAnchor.constraint(equalTo: coloniaTextField.trailingAnchor, constant: 0).isActive = true
        estadoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        estadoTextField.topAnchor.constraint(equalTo: estadoLabel.bottomAnchor, constant: 1).isActive = true
        estadoTextField.leadingAnchor.constraint(equalTo: estadoLabel.leadingAnchor, constant: 0).isActive = true
        estadoTextField.trailingAnchor.constraint(equalTo: estadoLabel.trailingAnchor, constant: 0).isActive = true
        estadoTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        codigoPostalLabel.topAnchor.constraint(equalTo: estadoTextField.bottomAnchor, constant: 16).isActive = true
        codigoPostalLabel.leadingAnchor.constraint(equalTo: estadoTextField.leadingAnchor, constant: 0).isActive = true
        codigoPostalLabel.trailingAnchor.constraint(equalTo: estadoTextField.trailingAnchor, constant: 0).isActive = true
        codigoPostalLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        codigoPostalTextField.topAnchor.constraint(equalTo: codigoPostalLabel.bottomAnchor, constant: 1).isActive = true
        codigoPostalTextField.leadingAnchor.constraint(equalTo: codigoPostalLabel.leadingAnchor, constant: 0).isActive = true
        codigoPostalTextField.trailingAnchor.constraint(equalTo: codigoPostalLabel.trailingAnchor, constant: 0).isActive = true
        codigoPostalTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        telefonoLabel.topAnchor.constraint(equalTo: codigoPostalTextField.bottomAnchor, constant: 16).isActive = true
        telefonoLabel.leadingAnchor.constraint(equalTo: codigoPostalTextField.leadingAnchor, constant: 0).isActive = true
        telefonoLabel.trailingAnchor.constraint(equalTo: codigoPostalTextField.trailingAnchor, constant: 0).isActive = true
        telefonoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        telefonoTextField.topAnchor.constraint(equalTo: telefonoLabel.bottomAnchor, constant: 1).isActive = true
        telefonoTextField.leadingAnchor.constraint(equalTo: telefonoLabel.leadingAnchor, constant: 0).isActive = true
        telefonoTextField.trailingAnchor.constraint(equalTo: telefonoLabel.trailingAnchor, constant: 0).isActive = true
        telefonoTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        correoLabel.topAnchor.constraint(equalTo: telefonoTextField.bottomAnchor, constant: 16).isActive = true
        correoLabel.leadingAnchor.constraint(equalTo: telefonoTextField.leadingAnchor, constant: 0).isActive = true
        correoLabel.trailingAnchor.constraint(equalTo: telefonoTextField.trailingAnchor, constant: 0).isActive = true
        correoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        correoTextField.topAnchor.constraint(equalTo: correoLabel.bottomAnchor, constant: 1).isActive = true
        correoTextField.leadingAnchor.constraint(equalTo: correoLabel.leadingAnchor, constant: 0).isActive = true
        correoTextField.trailingAnchor.constraint(equalTo: correoLabel.trailingAnchor, constant: 0).isActive = true
        correoTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        view.addSubview(agregarBenefactorBtn)
        
        agregarBenefactorBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        agregarBenefactorBtn.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        agregarBenefactorBtn.heightAnchor.constraint(equalToConstant: 56).isActive = true
        agregarBenefactorBtn.widthAnchor.constraint(equalToConstant: 56).isActive = true
        
        agregarBenefactorBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBenefactor)))
        
        if titleNavBar == "Añadir benefactor" {
            agregarBenefactorBtn.setImage(UIImage(named: "AceptarActualizacion"), for: .normal)
        } else {
            agregarBenefactorBtn.setImage(UIImage(named: "Editar"), for: .normal)
            
            print("benefactor id", detalleBenefactor.id)
            razonSocialTextField.text = detalleBenefactor.razonSocial
            nombreContactoTextField.text = detalleBenefactor.nombreContacto
            domicilioTextField.text = detalleBenefactor.domicilio
            ciudadTextField.text = detalleBenefactor.ciudad
            coloniaTextField.text = detalleBenefactor.colonia
            estadoTextField.text = detalleBenefactor.estado
            codigoPostalTextField.text = detalleBenefactor.cp
            telefonoTextField.text = detalleBenefactor.telefono
            correoTextField.text = detalleBenefactor.email
            
        }
        
    }
    
    @objc func handleBenefactor() {
        
        activityIndicator.startAnimating()
        
        guard let razonSocial = razonSocialTextField.text else { return }
        guard let nombreContacto = nombreContactoTextField.text else { return }
        guard let domicilio = domicilioTextField.text else { return }
        guard let ciudad = ciudadTextField.text else { return }
        guard let colonia = coloniaTextField.text else { return }
        guard let estado = estadoTextField.text else { return }
        guard let codigoPostal = codigoPostalTextField.text else { return }
        guard let telefono = telefonoTextField.text else { return }
        guard let correo = correoTextField.text else { return }
        
        if (razonSocial == "") || (nombreContacto == "") || (domicilio == "") || (ciudad == "") || (colonia == "") || (estado == "") || (codigoPostal == "") || (telefono == "") || (correo == "") {
            
            let alert = alertController.alertError(titulo: nil, mensaje: "Campos vacíos")
            self.present(alert, animated: true, completion: nil)
            self.activityIndicator.stopAnimating()
            
            return
        }
        
        if titleNavBar == "Añadir benefactor" {
            
            apiConnector.newBenefactores(id: 0, calle: domicilio, numero: "", ciudad: ciudad, estado: estado, colonia: colonia, cp: codigoPostal, razonSocial: razonSocial, edad: "", nombre: nombreContacto, telefono: telefono, correo: correo, completionSucces: {
                DispatchQueue.main.async{
                    print("entra")
                    
                    self.activityIndicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                }
            }, completionError: { (error) in
                DispatchQueue.main.async{
                    
                    print("error agregar beneficiario")
                    
                    let alert = alertController.alertError(titulo: nil, mensaje: "\(error)")
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    self.activityIndicator.stopAnimating()
                }
            })
            
        } else {
            
            apiConnector.editBenefactores(id: detalleBenefactor.id!, calle: domicilio, numero: "", ciudad: ciudad, estado: estado, colonia: colonia, cp: codigoPostal, razonSocial: razonSocial, edad: "", nombre: nombreContacto, telefono: telefono, correo: correo, completionSucces: {
                
                DispatchQueue.main.async{
                    print("entra")
                    
                    self.activityIndicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                }
                
            }) { error in
                
                DispatchQueue.main.async{
                    
                    print("error editar beneficiario")
                    
                    let alert = alertController.alertError(titulo: nil, mensaje: "\(error)")
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    self.activityIndicator.stopAnimating()
                }
            }
            
        }
        
    }
    
}
