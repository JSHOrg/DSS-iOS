//
//  CentrosAcopioCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 29/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class CentrosAcopioCell: FeedCell {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactosAcopio.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = contactosAcopio[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(contactosBancos[indexPath.item].identificador!)
        
        identificadorAgenda = contactosAcopio[indexPath.item].identificador!
        
        indexContactos = indexPath.item
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            setupAgendaDetalleView(keyWindow: keyWindow)
            
        }
    }
    
}
