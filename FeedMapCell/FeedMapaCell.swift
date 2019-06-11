//
//  FeedMapaCell.swift
//  JaliscoSinHambre
//
//  Created by usuario on 01/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit
import MapKit

class FeedMapaCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let mapView = MKMapView()
    
    lazy var collectionView: UICollectionView = {  //lazy access self inside of this clousure
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
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
    
    let cellId = "cellId"
    
    let nombreContacto = "Santa María Tequepexpan"
    let direccionContacto = "C.P. 45340 Jalisco, México"
    let beneficiariosContacto = "65 beneficiarios"
    
    var contactos = [Contacto]()
    
    func fetchAgenda() {
        let firstCharecter = nombreContacto.first //.key.first
        
        for _ in 1...14 {
            contactos.append(Contacto(inicial: "\(firstCharecter!)", nombreContacto: nombreContacto, direccionContacto: "Calle: \(direccionContacto)", beneficiariosContacto: "CP: \(beneficiariosContacto)", identificador: "FeedCell"))
        }
        
    }
    
    override func setupViews() {
        
        setupMapView()
        fetchAgenda()
        
    }
    
    func setupMapView() {
        
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        //        mapView.center = view.center
        
        addSubview(mapView)
        addSubview(collectionView)
        addSubview(activityIndicator)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: mapView)
        addConstraintsWithFormat(format: "V:|[v0][v1(180)]|", views: mapView, collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        collectionView.register(ContactoCell.self, forCellWithReuseIdentifier: cellId)
        
        mapView.register(AnnotationMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
    }
    
    func addAnnotation(lat: NSString, lon: NSString, nombre: String, direccion: String, iniciales: String) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: (lat.doubleValue), longitude: (lon.doubleValue))
        let mitAnnotation = centroAnnotation(coordinate: annotation.coordinate, title: nombre, subtitle: direccion, iniciales: iniciales)
    
        self.mapView.addAnnotation(mitAnnotation)
        
        //zoom in map
        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ContactoCell
        
        cell.nombreContactoLabel.backgroundColor = .clear
        cell.direccionContactoLabel.backgroundColor = .clear
        cell.beneficiariosContactoLabel.backgroundColor = .clear
        
        cell.contacto = contactos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let identificador = self.contactos[indexPath.item].identificador!
        
        print(identificador)
        
        var coordinate = CLLocationCoordinate2D()
        
        if identificador == "MapaBancosAlimentos" {
            guard let lat = arrayMapaBancoAlimentos[indexPath.item].latitud else { return }
            guard let lon = arrayMapaBancoAlimentos[indexPath.item].longitud else { return }
            coordinate = CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: lon.doubleValue)
            
        } else if identificador == "MapaCentrosComunitarios" {
            guard let lat = arrayMapaCentrosComunitarios[indexPath.item].latitud else { return }
            guard let lon = arrayMapaCentrosComunitarios[indexPath.item].longitud else { return }
            coordinate = CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: lon.doubleValue)
            
        } else {
            guard let lat = arrayMapaCentrosDeAcopio[indexPath.item].latitud else { return }
            guard let lon = arrayMapaCentrosDeAcopio[indexPath.item].longitud else { return }
            coordinate = CLLocationCoordinate2D(latitude: lat.doubleValue, longitude: lon.doubleValue)
            
        }
        
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15))
        
        self.mapView.setRegion(region, animated: true)
    }
    
}
