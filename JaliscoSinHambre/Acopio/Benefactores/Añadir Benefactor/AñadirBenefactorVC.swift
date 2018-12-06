//
//  AñadirBenefactorVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 10/29/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class AñadirBenefactorVC: UIViewController, UITextFieldDelegate {
    
    var detalleBenefactor = Benefactor()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var scrollView: UIScrollView!
    let screensize: CGRect = UIScreen.main.bounds
    var screenWidth = CGFloat()
    var screenHeight = CGFloat()
    
    let razonSocialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Razón social"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let razonSocialTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Razón social"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let nombreContactoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nombre de contacto"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let nombreContactoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nombre de contacto"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let domicilioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Domicilio"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let domicilioTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Domicilio"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let ciudadLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ciudad"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let ciudadTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Ciudad"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let coloniaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Colonia"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let coloniaTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Colonia"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let estadoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Estado"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let estadoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Estado"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let codigoPostalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Código Postal"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let codigoPostalTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Código Postal"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let telefonoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Teléfono"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let telefonoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Teléfono"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let correoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Correo electrónico"
        label.font = UIFont.robotoMediumStyle14
        label.textColor = UIColor.rgb(red: 75, green: 75, blue: 75)
        return label
    }()
    
    let correoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Correo electrónico"
        textField.underlined()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont.robotoRegularStyle13
        return textField
    }()
    
    let agregarBenefactorBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 1)
        button.layer.cornerRadius = 28
        button.tintColor = .white
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.mainGreen()
        return activity
    }()
    
    var titleNavBar : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        screenWidth = screensize.width
        screenHeight = screensize.height
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: titleNavBar ?? "Benefactor")
        setupViews()
        observeKeyboardNotifications()
    }
    
   
}
