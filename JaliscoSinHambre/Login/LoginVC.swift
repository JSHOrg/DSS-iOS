//
//  LoginVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 13/10/17.
//  Copyright © 2017 Ulab. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    let jaliscoSinHambreIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cuentaTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nombre de usuario"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle16
        return textField
    }()
    
    let contraseñaTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Contraseña"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle16
        return textField
    }()
    
    let iniciarSesionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("INICIAR SESIÓN", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor.rgb(red: 33, green: 150, blue: 83)
        button.titleLabel?.font = UIFont.robotoMediumStyle14
        button.layer.cornerRadius = 2
        button.clipsToBounds = true
        return button
    }()
    
    let olvideContraseñaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Olvidé mi contraseña", for: .normal)
        button.titleLabel?.font = UIFont.robotoRegularStyle13
        button.setTitleColor(#colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.isHidden = true                  //    *******
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.mainGreen()
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = true
        
        //prubea
        setupViews()
        observeKeyboardNotifications()
        
    }

}

