//
//  InfoContactoVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 03/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

var infoContactoDict : NSDictionary?

class InfoContactoVC: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
        
    let dismissViewButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "Regresar"), for: .normal)
        button.tintColor = UIColor.mainBlack()
        button.addTarget(self, action: #selector(handleDismissView), for: .touchUpInside)
        return button
    }()
    
    let navigationView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9763854146, green: 0.9765252471, blue: 0.9763546586, alpha: 1)
        return view
    }()
    
    let nombreBanco : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.robotoMediumStyle20
        label.textColor = UIColor.mainBlack()
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupTitle()
        setupViews()
    }
    
    var etiquetasArr = ["Centro", "Nombre", "Apellido", "Teléfono", "Extensión", "Celular", "Correo electrónico"]
    var infoContactoArr = [String]()
    var centro : String?
    
    func setupTitle() {
        
        if identificadorAgenda == "BancosAlimentos" {
            guard let nombre = contactosBancos[indexContactos!].nombreContacto else { return }
            self.nombreBanco.text = nombre
            centro = nombre
        } else if identificadorAgenda == "CentrosComunitarios" {
            guard let nombre = contactosCentros[indexContactos!].nombreContacto else { return }
            self.nombreBanco.text = nombre
            centro = nombre
        } else {
            guard let nombre = contactosAcopio[indexContactos!].nombreContacto else { return }
            self.nombreBanco.text = nombre
            centro = nombre
        }
        
        infoContactoArr = ["\(String(describing: centro!))", "\(String(describing: (infoContactoDict!["nombre"] as? String)!))", "\(String(describing: (infoContactoDict!["apellido"] as? String)!))", "\(String(describing: (infoContactoDict!["telefono"] as? String)!))", "\(String(describing: (infoContactoDict!["extension"] as? Int)!))", "\(String(describing: (infoContactoDict!["celular"] as? String)!))", "\(String(describing: (infoContactoDict!["email"] as? String)!))"]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return etiquetasArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoContactoCell
        
        let attributeText = NSMutableAttributedString(string: etiquetasArr[indexPath.item], attributes: [NSAttributedStringKey.font: UIFont.robotoMediumStyle14, NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)])
        
        attributeText.append(NSMutableAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        
        let detalle = infoContactoArr[indexPath.item]
        
        attributeText.append(NSMutableAttributedString(string: detalle, attributes: [NSAttributedStringKey.font: UIFont.robotoRegularStyle13, NSAttributedStringKey.foregroundColor: UIColor.mainBlack()]))
        
        cell.descriptionLabel.attributedText = attributeText
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
