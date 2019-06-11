//
//  Switcher.swift
//  JaliscoSinHambre
//
//  Created by usuario on 23/03/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

class Switcher {
    
    static func updateRootVC(identifier: String) {
        
        var rootVC : UIViewController?
        
        rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
