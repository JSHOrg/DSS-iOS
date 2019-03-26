//
//  BenefactoresVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 04/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class BenefactoresVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {  //lazy access self inside of this clousure
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.color = UIColor.mainGreen()
        return activity
    }()
    
    let agregarBenefactorBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.5882352941, blue: 0.3254901961, alpha: 1)
        button.layer.cornerRadius = 28
        button.setImage(UIImage(named: "Agregar"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Benefactores")
        setupViews()
    }
    
    func fetchBenefactores() {
        
        activityIndicator.startAnimating()
        
        contactoBenefactor.removeAll()
        
        apiConnector.fetchBenefactores(completionSucces: { (benefactor) in
            DispatchQueue.main.async{
                
                detalleBenefactor = benefactor
                
                for ben in benefactor {
                    
                    let firstCharecter = "\(String(describing: ben.razonSocial?.first ?? "-"))"
                    
                    contactoBenefactor.append(Contacto(inicial: "\(firstCharecter)", nombreContacto: ben.razonSocial!, direccionContacto: "Correo: \(ben.email ?? "")", beneficiariosContacto: "Registrado: \(ben.fecha ?? "-")", identificador: "Benefactor"))
                }
                
                self.activityIndicator.stopAnimating()
                
                self.collectionView.reloadData()
                
            }
        }) {
            DispatchQueue.main.async {
                
                print("error benefactores")
                
                var errorMsg = ""
                
                if apiConnector.errorDescription != nil {
                    print(apiConnector.errorDescription!)
                    errorMsg = apiConnector.errorDescription ?? "Error"
                    
                    if apiConnector.errorDescription == "invalid_token" {
                        let loginController = LoginVC()
                        let navController = UINavigationController(rootViewController: loginController)
                        UIApplication.shared.keyWindow?.rootViewController?.present(navController, animated: true, completion: nil)
                    }
                    
                } else {
                    errorMsg = "Error al cargar datos"
                }
                
                let alert = alertController.alertError(titulo: nil, mensaje: "\(errorMsg)")
                
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
                self.activityIndicator.stopAnimating()
            }
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactoBenefactor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = contactoBenefactor[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let detalleBenefactorVC = DetalleBenefactorVC()
//        detalleBenefactorVC.detalleBenefactorDict = [detalleBenefactor[indexPath.item]]
//        navigationController?.pushViewController(detalleBenefactorVC, animated: true)

        let detalleBenefactorVC = AñadirBenefactorVC()
        detalleBenefactorVC.titleNavBar = "Detalle benefactor"
        detalleBenefactorVC.detalleBenefactor = detalleBenefactor[indexPath.row]
        navigationController?.pushViewController(detalleBenefactorVC, animated: true)

    }
    
}
