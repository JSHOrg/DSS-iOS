//
//  MapaVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 02/04/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit
import MapKit

class MapaVC: UIViewController, MKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let acopioCell = "acopioCell"
    let bancosCell = "bancosCell"
    let centrosCell = "centrosCell"

    let mapView = MKMapView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        
        return cv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.mapaVC = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLeftTitleNav(titleNav: "Mapa")
//        setupRightButtonItemNav()
        
        setupNavigationController()
        setupMenuBar()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier: String
        
        if indexPath.item == 0 {
            identifier = bancosCell
        } else if indexPath.item == 1 {
            identifier = centrosCell
        } else {
            identifier = acopioCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightTopBar = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)! + 50 //UIApplication.shared.statusBarFrame.maxY + 44 + 50
        let bottomBar = self.tabBarController?.tabBar.frame.height
        
        print(heightTopBar, bottomBar!)
        return CGSize(width: view.frame.width, height: view.frame.height - heightTopBar - bottomBar!)
//        return CGSize(width: view.frame.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
