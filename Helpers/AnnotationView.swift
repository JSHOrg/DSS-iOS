//
//  AnnotationView.swift
//  JaliscoSinHambre
//
//  Created by usuario on 06/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit
import MapKit

//AnnotationView
final class centroAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var iniciales: String?
    var title: String?
    var subtitle: String?
    let discipline: String
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, iniciales: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.iniciales = iniciales
        self.discipline = "prueba"
        
        super.init()
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
    
    var imageName: String? {
        if discipline == "prueba" { return "Notificaciones" }
        return "Menu"
    }
    
    var markerTintColor: UIColor  {
        return .mainGreen()
    }
}

class AnnotationMarkerView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? centroAnnotation else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
//            mapsButton.setBackgroundImage(UIImage(named: "Buscar"), for: UIControlState())        //Icono de annotation
//            mapsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleNavegacion2)))
            
            rightCalloutAccessoryView = mapsButton
            
            markerTintColor = annotation.markerTintColor
            glyphText = annotation.iniciales
            
            //            if let imageName = annotation.imageName {
            //                glyphImage = UIImage(named: imageName)
            //            } else {
            //                glyphImage = nil
            //            }
            
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = UIFont.robotoRegularStyle13
            detailLabel.text = annotation.subtitle
            detailCalloutAccessoryView = detailLabel
            
        }
        
    }
    
    @objc func handleNavegacion2() {
        print("mapa annotation")
    }
    
}
