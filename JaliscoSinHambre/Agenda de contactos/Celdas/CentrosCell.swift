//
//  CentrosCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 01/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit


class CentrosCell: FeedCell {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactosCentros.count
    } 
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = contactosCentros[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(contactosBancos[indexPath.item].identificador!)
        
        identificadorAgenda = contactosCentros[indexPath.item].identificador!
        
        indexContactos = indexPath.item
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            setupAgendaDetalleView(keyWindow: keyWindow)
            
        }
        
    }
    
}
