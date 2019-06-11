//
//  MainTabBarController.swift
//  JaliscoSinHambre
//
//  Created by usuario on 22/05/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

var navController = UINavigationController()

let apiConnector = ApiConnector.sharedInstance

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
//        apiConnector.accessToken = "1ba7f432-055b-4c6f-9c01-c5a40345e51b"
        
        if apiConnector.accessToken == nil {
            DispatchQueue.main.async {
                let loginVC = LoginVC()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        self.setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        //agenda
        let agendaNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Agenda_unselected"), selectedImage: #imageLiteral(resourceName: "Agenda_selected"), rootViewController: AgendaContactosVC())
        
        //mapa
        let mapaNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Mapa_unselected"), selectedImage: #imageLiteral(resourceName: "Mapa_selected"), rootViewController: MapaVC())
        
        //agenda
        let acopioNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "Acopio_unselected"), selectedImage: #imageLiteral(resourceName: "Acopio_selected"), rootViewController: AcopioVC())
        
        
        viewControllers = [agendaNavController,
                           mapaNavController,
                           acopioNavController]
        
        tabBar.tintColor = UIColor.mainGreen()
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        navController = UINavigationController(rootViewController: viewController)
        
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
    
}
