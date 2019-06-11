//
//  Auth.swift
//  JaliscoSinHambre
//
//  Created by usuario on 28/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import Foundation


struct Auth : Decodable {
    var access_token : String?
    var token_type : String?
    var refresh_token : String?
    var expires_in : Int?
    var scope : String?
}
