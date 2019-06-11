//
//  FeedDetalleDonativoCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 07/07/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class FeedDetalleDonativoCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    var etiquetasArr = [String]()
    var infoDonativoArr = [String]()
    
    func fetchDetalleDonativo() {
        
        etiquetasArr = ["Producto", "Peso", "Fecha límite de consumo", "Cosechado", "Pago por cosecha", "Embalaje", "Tipo de embalaje"]
        
        infoDonativoArr = ["\(detalleDonativoDict.first?.nombreProducto ?? "")", "\(detalleDonativoDict.first?.cantidadKG ?? "") Kg", "\(detalleDonativoDict.first?.fechaConsumoLimite ?? "")", "\(detalleDonativoDict.first?.cosechado ?? "")", "\(detalleDonativoDict.first?.pagoCosecha ?? "")", "\(detalleDonativoDict.first?.embalaje ?? "")", "\(detalleDonativoDict.first?.tipoEmbalaje ?? "")"]
        
    }
    
    override func setupViews() {
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(InfoContactoCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchDetalleDonativo()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return etiquetasArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoContactoCell
        
        let attributeText = NSMutableAttributedString(string: etiquetasArr[indexPath.item], attributes: [NSAttributedString.Key.font: UIFont.robotoMediumStyle14, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2941176471, green: 0.2941176471, blue: 0.2941176471, alpha: 1)])
        
        attributeText.append(NSMutableAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        let detalle = infoDonativoArr[indexPath.item]
        
        attributeText.append(NSMutableAttributedString(string: detalle, attributes: [NSAttributedString.Key.font: UIFont.robotoRegularStyle13, NSAttributedString.Key.foregroundColor: UIColor.mainBlack()]))
        
        cell.descriptionLabel.attributedText = attributeText
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

