//
//  Extensions.swift
//  JaliscoSinHambre
//
//  Created by usuario on 20/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

extension UITextField {
    
    func underlined() {
        
        let userBorder = CALayer()
        userBorder.frame = CGRect(x: 0, y: 39, width: 460, height: 2)
        userBorder.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0.12).cgColor
        self.layer.addSublayer(userBorder)
        self.layer.masksToBounds = true
        
    }
    
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainGreen() -> UIColor {
        return UIColor.rgb(red: 33, green: 150, blue: 83)
    }
    
    static func mainBlack() -> UIColor {
        return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5427011986)
    }
}

extension UIFont {
    
    class var robotoRegularStyle13: UIFont {
        return UIFont(name: "Roboto-Regular", size: 13.0)!
    }
    
    class var robotoRegularStyle16: UIFont {
        return UIFont(name: "Roboto-Regular", size: 16.0)!
    }
    
    class var robotoMediumStyle13: UIFont {
        return UIFont(name: "Roboto-Medium", size: 13.0)!
    }
    
    class var robotoMediumStyle14: UIFont {
        return UIFont(name: "Roboto-Medium", size: 14.0)!
    }
    
    class var robotoMediumStyle20: UIFont {
        return UIFont(name: "Roboto-Medium", size: 20.0)!
    }
    
    class var robotoLightStyle16: UIFont {
        return UIFont(name: "Roboto-Light", size: 16.0)!
    }
    
}

extension UIViewController {
    
    func setupNavigationController() {
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = UIColor.rgb(red: 249, green: 249, blue: 249)
        
        setupSafeAreaView()
    }
    
    func setCustomBackImage() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupSafeAreaView() {
        
        let safeAreaView = UIView(frame:CGRect(x: 0,y: 0, width: self.view.frame.width, height: 44))
        safeAreaView.backgroundColor = UIColor.rgb(red: 249, green: 249, blue: 249)
        self.view.addSubview(safeAreaView)
        
    }
    
    //setup title NavigationController
    func setupLeftTitleNav(titleNav: String) {
        let firstButton = UIButton(type: .system)
        firstButton.setImage(#imageLiteral(resourceName: "More"), for: .normal)
        firstButton.tintColor = UIColor.mainBlack()
        let attributedText = NSMutableAttributedString(string: "     \(titleNav)", attributes: [NSAttributedString.Key.font: UIFont.robotoMediumStyle20, NSAttributedString.Key.foregroundColor: UIColor.mainBlack()])
        firstButton.setAttributedTitle(attributedText, for: .normal)
        firstButton.frame = CGRect(x: 0, y: 0, width: 35, height: 20)
        firstButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        
        let titleItem = UIBarButtonItem(customView: firstButton)
        
        self.navigationItem.setLeftBarButtonItems([titleItem], animated: false)
    }
    
    //setup Back Button NavigationController
    func setupBackButton() {
        let firstButton = UIButton(type: .system)
        firstButton.setImage(#imageLiteral(resourceName: "Regresar"), for: .normal)
        firstButton.tintColor = UIColor.mainBlack()
        firstButton.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
        
        let titleItem = UIBarButtonItem(customView: firstButton)
        
        self.navigationItem.setLeftBarButtonItems([titleItem], animated: false)
    }
    
    func setupDismissButtonWithTitle(title: String) {
        
        let firstButton = UIButton(type: .system)
        firstButton.setImage(#imageLiteral(resourceName: "BackButton"), for: .normal)
        let attributedText = NSMutableAttributedString(string: "     \(title)", attributes: [NSAttributedString.Key.font: UIFont.robotoMediumStyle20, NSAttributedString.Key.foregroundColor: UIColor.mainBlack()])
        firstButton.setAttributedTitle(attributedText, for: .normal)
        firstButton.tintColor = UIColor.mainBlack()
        firstButton.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
        
        let titleItem = UIBarButtonItem(customView: firstButton)
        
        self.navigationItem.setLeftBarButtonItems([titleItem], animated: false)
    }
    
    @objc func handleDismissView(){
        navigationController?.popViewController(animated: true) //pushView
        self.dismiss(animated: true, completion: nil)           //present
        
    }
    
    @objc func handleMenu() {
        
        let alert = UIAlertController(title: nil, message: "Más opciones", preferredStyle: .actionSheet)
        
//        alert.addAction(UIAlertAction(title: "Acerca de", style: .default, handler: { (action) in
//            print("Acerca de")
//        }))
//        
//        alert.addAction(UIAlertAction(title: "Aviso de privacidad", style: .default, handler: { (action) in
//            print("Aviso de privacidad")
//        }))
//        
//        alert.addAction(UIAlertAction(title: "Soporte", style: .default, handler: { (action) in
//            print("Soporte")
//        }))
        
        alert.addAction(UIAlertAction(title: "Cerrar sesión", style: .destructive, handler: { (action) in
            self.cerrarSesionAlert()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
            print("Cancelar")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func cerrarSesionAlert() {
        
        let alertController = UIAlertController(title: "Cerrar sesión", message: "¿Está seguro de cerrar sesión?", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.destructive) { (result : UIAlertAction) -> Void in
           
            //whats happens? we need to present some kind of login controller
            let loginController = LoginVC()
            let navController = UINavigationController(rootViewController: loginController)
            self.present(navController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            print("cancelar")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //setup right button items
    func setupRightButtonItemNav() {
        
        let firstButton = UIButton(type: .system)
        firstButton.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        firstButton.setImage(#imageLiteral(resourceName: "Buscar"), for: .normal)
        firstButton.addTarget(self, action: #selector(handleBuscar), for: .touchUpInside)
        
        let buscarBtn: UIBarButtonItem = UIBarButtonItem(customView: firstButton)
        
        self.navigationItem.setRightBarButtonItems([buscarBtn], animated: false)
        
    }
    
    @objc func handleBuscar() {
        print("Buscar")
    }
    
}

