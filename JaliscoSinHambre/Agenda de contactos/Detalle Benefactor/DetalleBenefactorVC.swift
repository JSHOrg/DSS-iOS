//
//  DetalleBenefactorVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 04/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class DetalleBenefactorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    let cellId = "cellId"
    var detalleBenefactorDict = [Benefactor]()
    
    var etiquetasArr = [String]()
    var infoBenefactorArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavigationController()
        setupDismissButtonWithTitle(title: "Detalle de benefactor")
        setupViews()
        fetchInfoBenefactor()
    }
    
    
    override func handleDismissView() {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    func fetchInfoBenefactor() {
        print(detalleBenefactorDict)
        
        etiquetasArr = ["Razón social", "RFC", "Teléfono", "Correo", "Calificación", "Fecha de registro", "Comentarios"]
        
        infoBenefactorArr = ["\(String(describing: (detalleBenefactorDict.first?.razonSocial)!))", "\(String(describing: (detalleBenefactorDict.first?.rfc)!))", "\(String(describing: (detalleBenefactorDict.first?.telefono)!))", "\(String(describing: (detalleBenefactorDict.first?.email)!))", "\(String(describing: (detalleBenefactorDict.first?.calificacion)!))", "\(String(describing: (detalleBenefactorDict.first?.fechaRegistro)!))", "\(String(describing: (detalleBenefactorDict.first?.comentarios)!))"]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupViews() {
        
        view.addSubview(separatorView)
        view.addSubview(collectionView)
        
        separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        collectionView.register(InfoContactoCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return etiquetasArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoContactoCell
        
        let attributeText = NSMutableAttributedString(string: etiquetasArr[indexPath.item], attributes: [NSAttributedStringKey.font: UIFont.robotoMediumStyle14, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)])
        
        attributeText.append(NSMutableAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        
        let detalle = infoBenefactorArr[indexPath.item]
        
        attributeText.append(NSMutableAttributedString(string: detalle, attributes: [NSAttributedStringKey.font: UIFont.robotoRegularStyle13, NSAttributedStringKey.foregroundColor: UIColor.mainBlack()]))
        
        cell.descriptionLabel.attributedText = attributeText
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
