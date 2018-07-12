//
//  AgendaContactosVC.swift
//  JaliscoSinHambre
//
//  Created by usuario on 23/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

var indexScroll = 0

var heightTopBar : CGFloat? //UIApplication.shared.statusBarFrame.maxY + 44 + 50
var bottomBar : CGFloat?

class AgendaContactosVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let bancosCell = "bancosCell"
    let centrosCell = "centrosCell"
    let acopioCell = "acopioCell"
    let benefactoresCell = "benefactoresCell"
    let proveedoresCell = "proveedoresCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.white
        cv.isPagingEnabled = true
        cv.dataSource = self
        cv.delegate = self
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 151, green: 151, blue: 151)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var seccionBar: SeccionAgendaBar = {
        let sb = SeccionAgendaBar()
        sb.agendaVC = self
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLeftTitleNav(titleNav: "Agenda de contactos")
        
        setupNavigationController()
        setupMenuBar()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //jugar con el index del scroll para saber que arreglo cargar       ****
        let identifier: String
        
        if indexPath.item == 0 {
            identifier = bancosCell
        } else if indexPath.item == 1 {
            identifier = centrosCell
        } else if indexPath.item == 2 {
            identifier = acopioCell
        } else if indexPath.item == 3 {
            identifier = benefactoresCell
        } else {
            identifier = proveedoresCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        heightTopBar = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)! + 50 //UIApplication.shared.statusBarFrame.maxY + 44 + 50
        bottomBar = self.tabBarController?.tabBar.frame.height
        
        print(heightTopBar, bottomBar!)
        return CGSize(width: view.frame.width, height: view.frame.height - heightTopBar! - bottomBar!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}
