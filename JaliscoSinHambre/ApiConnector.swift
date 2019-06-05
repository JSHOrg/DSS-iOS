//
//  ApiConnector.swift
//  JaliscoSinHambre
//
//  Created by usuario on 05/06/18.
//  Copyright © 2018 Ulab. All rights reserved.
//

import UIKit

//Urls
let urlServer = "http://18.221.249.12:8080/"
let urlBase = "\(urlServer)api/"

var arrayContactosBancoAlimentos : [BancosDeAlimentos] = []
var arrayContactosCentrosComunitarios : [CentrosComunitarios] = []
var arrayContactosCentrosAcopio : [CentrosAcopio] = []

//Benefactores
var arrayBenefactores : [Benefactor] = []

//Entradas y salidas de almacen
var arrayEntradaAlmacen : [EntradaAlmacen] = []
var arraySalidaAlmacen : [SalidaAlmacen] = []
var entradasAlmacenContactos = [Contacto]()
var salidasAlmacenContactos = [Contacto]()

//Detalle donativo
var arrayDetalleDonativo : [DetalleDonativo] = []
var detalleDonativoContactos = [Contacto]()

//solicitud recoleccion
var arraySolicitudRecoleccion : [SolicitudRecoleccion] = []
var detalleSolicitudRecoleccionContactos = [Contacto]()

//Proveedores
var arrayProveedores : [Proveedor] = []
var detalleProveedoresContactos = [Contacto]()

//Contactos
var contactosBancos = [Contacto]()
var contactosCentros = [Contacto]()
var contactosAcopio = [Contacto]()
var contactos = [Contacto]()

class ApiConnector {
    
    static let sharedInstance = ApiConnector()
    
    // MARK: AUTH
    var accessToken : String?
    var refreshToken : String?
    
    var errorDescription : String?
    
    // MARK: - iniciar sesión
    func iniciarSesion(username: String, password: String, completionSucces: @escaping () -> Void, completionError: @escaping () -> Void){
        
        let jsonUrlString: String = "\(urlServer)oauth/token"

        let grantType = "password"
        
        let json:String = "username=\(username)&password=\(password)&grant_type=\(grantType)"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        let request = post(json: json, requestUrl: url, isLogin: true)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            if let err = err {
                print("Error:", err.localizedDescription)        //poner en un alertView              *****
                print("Error al obtener los datos")
                self.errorDescription = "Error al obtener los datos"
                completionError()
                return
            }
            
            guard let data = data else {
                completionError()
                return
                
            }
            
            let httpStatus = response as? HTTPURLResponse
            print(httpStatus?.statusCode ?? "")
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)

                let dico = json as! NSDictionary

                print(dico)
                
                //Si es exitoso
                if let token = dico["access_token"] {
        
                    self.accessToken = token as? String
                    self.refreshToken = dico["refresh_token"] as? String
        
                    completionSucces()
                } else {
                    let errorDescription = dico["error_description"] as! String
                    print(errorDescription)
                    completionError()
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr.localizedDescription)
                completionError()
            }
            
            }.resume()
        
    }
    
    // MARK: Agenda de contactos
    func fetchContacts(urlContactos: String, completionSucces: @escaping (NSDictionary) -> (), completionError: @escaping () -> Void) {
        
        let urlBancoAlimentos = "\(urlBase)\(urlContactos)"
        
        guard let url = URL(string: urlBancoAlimentos) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            let statusCode = self.urlResponse(response: response)        //cachar el error
            
            if statusCode != 200 {
                completionError()
                return
            }
            
            do {
                //                let resumen = try JSONDecoder().decode(bancoAlimentos.self, from: contactData)
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                let _embedded = dico["_embedded"] as! NSDictionary
                
                completionSucces(_embedded)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
    func fetchBancoAlimentos(completionSucces: @escaping ([BancosDeAlimentos]) -> (), completionError: @escaping () -> Void) {
        
        arrayContactosBancoAlimentos.removeAll()
        
        let urlBancoAlimentos = "\(urlBase)bancoalimentos/"
        
        guard let url = URL(string: urlBancoAlimentos) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    let bancoalimentos = _embedded["bancoalimentos"] as! NSArray
                    
                    for bancoActual in bancoalimentos {
                        let jsonBanco:Dictionary<String, AnyObject> = bancoActual as! Dictionary<String, AnyObject>
                        
                        arrayContactosBancoAlimentos.append(BancosDeAlimentos(nombre: jsonBanco["nombre"] as? String, razonSocial: jsonBanco["razonSocial"] as? String, calificacion: jsonBanco["calificacion"] as? String, habilitado: jsonBanco["habilitado"] as? Bool, telefono: jsonBanco["telefono"] as? String, email: jsonBanco["email"] as? String, _links: jsonBanco["_links"] as? NSDictionary, direccion: jsonBanco["direccion"] as? NSDictionary))
                        
                    }
                    
                    completionSucces(arrayContactosBancoAlimentos)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
  
    
    func fetchCentrosComunitarios(completionSucces: @escaping ([CentrosComunitarios]) -> (), completionError: @escaping () -> Void) {
        
        arrayContactosCentrosComunitarios.removeAll()
        
        let urlCentrosComunitarios = "\(urlBase)comunitarios"
        
        guard let url = URL(string: urlCentrosComunitarios) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    let centrosComunitarios = _embedded["comunitarios"] as! NSArray

                    for centroActual in centrosComunitarios {
                        let jsonCentro:Dictionary<String, AnyObject> = centroActual as! Dictionary<String, AnyObject>
                        
                        let contacto = jsonCentro["contacto"] as? NSDictionary
                        let direccion = jsonCentro["direccion"] as? NSDictionary
                        
                        arrayContactosCentrosComunitarios.append((CentrosComunitarios(nombre: jsonCentro["nombre"] as? String, fechaRegistro: jsonCentro["fechaRegistro"] as? String, habilitado: jsonCentro["habilitado"] as? Bool, identifier: jsonCentro["identifier"] as? Int, telefono: contacto!["telefono"] as? String, correo: contacto!["email"] as? String, _links: jsonCentro["_links"] as? NSDictionary, direccion: direccion)))
                        
                        //direccion ya no está dentro de la información del contacto        ******

                    }
                    
                    completionSucces(arrayContactosCentrosComunitarios)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
        
    }
    
    func fetchCentrosAcopio(completionSucces: @escaping ([CentrosAcopio]) -> (), completionError: @escaping () -> Void) {
        
        arrayContactosCentrosAcopio.removeAll()
        
        let urlCentrosAcopio = "\(urlBase)almacenes"
        
        guard let url = URL(string: urlCentrosAcopio) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    let almacenes = _embedded["almacenes"] as! NSArray
                    
                    for almacenActual in almacenes {
                        let jsonBanco:Dictionary<String, AnyObject> = almacenActual as! Dictionary<String, AnyObject>
                        
                        let contacto = jsonBanco["contacto"] as? NSDictionary
                        let direccion = jsonBanco["direccion"] as? NSDictionary
                        
                        arrayContactosCentrosAcopio.append(CentrosAcopio(nombre: contacto!["nombre"] as? String, fechaRegistro: contacto!["fechaRegistro"] as? String, habilitado: contacto!["habilitado"] as? Bool, identifier: contacto!["identifier"] as? Int, telefono: contacto!["telefono"] as? String, correo: contacto!["email"] as? String, _links: jsonBanco["_links"] as? NSDictionary, direccion: direccion))
                        
                    }
                    
                    completionSucces(arrayContactosCentrosAcopio)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
    //Hago las dos llamadas, para tener cargada toda la info 
    func fetchAgendaContactos(completionSucces: @escaping () -> Void, completionError: @escaping () -> Void) {
        
        contactos.removeAll()
        
        fetchBancoAlimentos(completionSucces: { (bancos) in
            
            DispatchQueue.main.async{
                
                contactosBancos.removeAll()
                
                var x = 0
                for _ in bancos {
                    let nombre = bancos[x].nombre
                    let nombreArr = nombre?.components(separatedBy: " ")
                    let segundaInicial = nombreArr?.last?.first
                    
                    let firstCharecter = "\(String(describing: nombreArr![0].first!))\(String(describing: segundaInicial!))"  //.key.first
                    
                    guard let tel = bancos[x].telefono else { return }
                    guard let cor = bancos[x].email else { return }
                    
                    let telefono = "Tel: \(String(describing: tel))"
                    let correo = "Correo: \(String(describing: cor))"
                    
                    contactosBancos.append(Contacto(inicial: "\(firstCharecter.uppercased())", nombreContacto: nombre, direccionContacto: telefono, beneficiariosContacto: correo, identificador: "BancosAlimentos"))
                    
                    x = x + 1
                }
                
                completionSucces()
                
            }
            
        }) {
            
            completionError()
        }
        
        fetchCentrosComunitarios(completionSucces: { (centros) in
            
            DispatchQueue.main.async{
                
                contactosCentros.removeAll()
                
                var x = 0
                for _ in centros {
                    let nombre = centros[x].nombre
                    let nombreArr = nombre?.components(separatedBy: " ")
                    let segundaInicial = nombreArr?.last?.first
                    
                    let firstCharecter = "\(String(describing: nombreArr![0].first!))\(String(describing: segundaInicial!))"  //.key.first
                    
                    contactosCentros.append(Contacto(inicial: "\(firstCharecter.uppercased())", nombreContacto: nombre, direccionContacto: "Tel: \(centros[x].telefono ?? "")", beneficiariosContacto: "Correo: \(centros[x].correo ?? "")", identificador: "CentrosComunitarios"))
                    
                    x = x + 1
                }
                
                completionSucces()
                
            }
            
        }) {
            
            completionError()
        }
        
        fetchCentrosAcopio(completionSucces: { (acopio) in
            
            DispatchQueue.main.async{
                
                contactosAcopio.removeAll()
                
                var x = 0
                for _ in acopio {
                    
                    let nombre = acopio[x].nombre
                    let nombreArr = nombre?.components(separatedBy: " ")
                    let segundaInicial = nombreArr?.last?.first
                    
                    let firstCharecter = "\(String(describing: nombreArr![0].first!))\(String(describing: segundaInicial!))"  //.key.first
                    
                    contactosAcopio.append(Contacto(inicial: "\(firstCharecter.uppercased())", nombreContacto: nombre, direccionContacto: "Tel: \(acopio[x].telefono ?? "")", beneficiariosContacto: "Correo: \(acopio[x].correo ?? "")", identificador: "CentroAcopio"))

                    x = x + 1
                }
                
                completionSucces()
            }
            
        }) {
            
            completionError()
        }
    
    }
    
    // MARK: Contacto por banco
    func fetchContactoBanco(urlContactoBanco: String, completionSucces: @escaping (NSDictionary) -> (), completionError: @escaping () -> Void) {
        
        guard let url = URL(string: urlContactoBanco) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                //                let resumen = try JSONDecoder().decode(bancoAlimentos.self, from: contactData)
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                completionSucces(dico)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
        
    }
    
    // MARK: Benefactores
    func fetchBenefactores(completionSucces: @escaping ([Benefactor]) -> (), completionError: @escaping () -> Void) {
        
        arrayBenefactores.removeAll()
        
        let urlBenefactores = "\(urlBase)Benefactores"
        
        guard let url = URL(string: urlBenefactores) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            let statusCode = self.urlResponse(response: response)        //cachar el error
            
            if statusCode != 200 {
                completionError()
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let benefactores = json as! NSArray
                
                for almacenActual in benefactores {
                    let jsonBenefactor:Dictionary<String, AnyObject> = almacenActual as! Dictionary<String, AnyObject>
                    
                    let contacto = jsonBenefactor["contacto"] as? NSDictionary ?? nil
                    
                    let nombreC = contacto?["nombre"] as? String ?? ""
                    
                    let fechaRegistro = contacto?["fechaRegistro"] as? String
                    
                    var fecha = String()
                    if fechaRegistro != nil {
                        let fechaRegistroArr = fechaRegistro?.components(separatedBy: "T")
                        let fechaCompletaArr = fechaRegistroArr![0].components(separatedBy: "-")
                        fecha = "\(fechaCompletaArr[2])/\(fechaCompletaArr[1])/\(fechaCompletaArr[0])"
                        print("cp", fecha)
                    }
                    
                    let telefono = contacto?["telefono"] as? String ?? ""
                    let email = contacto?["email"] as? String ?? ""
                    
                    let direccion = jsonBenefactor["direccion"] as! NSDictionary
                    
                    let calle = direccion["calle"] as? String
                    let numero = direccion["numero"] as? String
                    
                    let domicilio = "\(calle ?? "") \(numero ?? "")"
                    
                    let ciudad = direccion["ciudad"] as? String
                    let colonia = direccion["colonia"] as? String
                    let estado = direccion["estado"] as? String
                    let cp = direccion["cp"] as? String
                    
                    
                    
                    let razonSocial = jsonBenefactor["razonSocial"] as? String ?? "" //if razonSocial is null
                    let nombre = jsonBenefactor["nombre"] as? String ?? ""
                    let id = jsonBenefactor["id"] as? Int ?? 0
                    
                    arrayBenefactores.append(Benefactor(id: id, nombre: nombre, razonSocial: razonSocial, nombreContacto: nombreC, domicilio: domicilio, ciudad: ciudad!, colonia: colonia!, estado: estado!, cp: cp!, telefono: telefono, email: email, fecha: fecha))
                }
                
                completionSucces(arrayBenefactores)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
    func newBenefactores(id: Int, calle: String, numero: String, ciudad: String, estado: String, colonia: String, cp: String, razonSocial: String, edad: String, nombre: String, telefono: String, correo: String, completionSucces: @escaping () -> Void, completionError: @escaping (String) -> ()) {
        
        let urlBenefactores = "\(urlBase)Benefactores"
        
        guard let url = URL(string: urlBenefactores) else { return }
        
        let today = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" 
        let formattedDate = format.string(from: today)
        print("cp", today, formattedDate)
        
        let json:String = "{\"contacto\": {\"id\": \(id),\"valor\": \"1\",\"nombre\": \"\(nombre)\",\"apellido\": \"\",\"telefono\": \"\(telefono)\",\"extension\": 0,\"celular\": \"\",\"email\": \"\(correo)\",\"grupo\": 0,\"fechaRegistro\": \"\(formattedDate)\",\"habilitado\": true,\"datosExtra\": \"{}\",\"identifier\": 1,\"tipoContacto\": \"PERSONAL\"},\"direccion\": {\"calle\": \"\(calle)\",\"numero\": \"\",\"ciudad\": \"\(ciudad)\",\"estado\": \"\(estado)\",\"latitud\": \"\",\"longitud\": \"\",\"colonia\": \"\(colonia)\",\"identifier\": 1,\"cp\": \"\(cp)\"},\"nombre\": \"\(razonSocial)\",\"razonSocial\": \"\(razonSocial)\"}"
        
        let request = post(json: json, requestUrl: url, isLogin: false)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError("\(err)")
                return
            }
            
            guard let contactData = data else {
                completionError("Error, intente más tarde")
                return
                
            }
            
            
            if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200
            {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
                print("Error del servidor, intente más tarde")
                completionError("Error del servidor, intente más tarde")
                
            } else {
                
                completionSucces()
            }
            
            }.resume()
    }
    
    func editBenefactores(id: Int, calle: String, numero: String, ciudad: String, estado: String, colonia: String, cp: String, razonSocial: String, edad: String, nombre: String, telefono: String, correo: String, completionSucces: @escaping () -> Void, completionError: @escaping (String) -> ()) {
        
        let urlBenefactores = "\(urlBase)Benefactores/\(id)"
        
        guard let url = URL(string: urlBenefactores) else { return }
        print("cp", cp)
        let json:String = "{\"contacto\": {\"id\": \(id),\"valor\": \"1\",\"nombre\": \"\(nombre)\",\"apellido\": \"\",\"telefono\": \"\(telefono)\",\"extension\": 0,\"celular\": \"\",\"email\": \"\(correo)\",\"grupo\": 0,\"fechaRegistro\": \"\",\"habilitado\": true,\"datosExtra\": \"{}\",\"tipoContacto\": \"PERSONAL\"},\"direccion\": {\"id\": \(id),\"calle\": \"\(calle)\",\"numero\": \"\",\"ciudad\": \"\(ciudad)\",\"estado\": \"\(estado)\",\"latitud\": \"\",\"longitud\": \"\",\"colonia\": \"\(colonia)\",\"cp\": \"\(cp)\"},\"nombre\": \"\(razonSocial)\",\"razonSocial\": \"\(razonSocial)\"}"
        
        let request = put(json: json, requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError("\(err)")
                return
            }
            
            guard let contactData = data else {
                completionError("Error, intente más tarde")
                return
                
            }
            
            if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200
            {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
                print("Error del servidor, intente más tarde")
                completionError("Error del servidor, intente más tarde")
                
            } else {
                
                completionSucces()
            }
            
            }.resume()
    }
    
    // MARK: Entrada Almacen
    func fetchEntradasAlmacen(completionSucces: @escaping ([EntradaAlmacen]) -> (), completionError: @escaping () -> Void) {
        
        arrayEntradaAlmacen.removeAll()
        
        let urlEntradaAlmacen = "\(urlBase)entradasalmacen"
        
        guard let url = URL(string: urlEntradaAlmacen) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    
                    let entradasAlmacen = _embedded["entradasalmacen"] as! NSArray
                    
                    for almacenActual in entradasAlmacen {
                        let jsonBanco:Dictionary<String, AnyObject> = almacenActual as! Dictionary<String, AnyObject>
                        
                        let usuario = jsonBanco["usuario"] as? NSDictionary
                        let nombreUsuario = usuario!["nombre"] as? String
                        
                        let folio = jsonBanco["folioInterno"] as? String
                        let fechaArr = jsonBanco["fechaEntrada"] as? String
                        
                        let fechaEntradaArr = fechaArr?.components(separatedBy: "T")
                        let fechaCompletaArr = fechaEntradaArr![0].components(separatedBy: "-")
                        let fecha = "\(fechaCompletaArr[2])/\(fechaCompletaArr[1])/\(fechaCompletaArr[0])"
                        
                        let detalleDonativo = jsonBanco["detalleDonativo"] as? NSDictionary
                        
                        let cantidadKg = detalleDonativo!["cantidadKg"] as? String
                        let cantidadPza = detalleDonativo!["cantidadPza"] as? String
                        let fechaConsumoLimite = detalleDonativo!["fechaConsumoLimite"] as? String
                        let pagoCosecha = detalleDonativo!["pagoCosecha"] as? Int
                        let comentarios = detalleDonativo!["comentarios"] as? String
                        let cantidadRecibidaBuenEstado = detalleDonativo!["cantidadRecibidaBuenEstado"] as? String
                        let costoOperativoAcopio = detalleDonativo!["costoOperativoAcopio"] as? String
                        
                        let bancoAlimentos = jsonBanco["bancoAlimentos"] as? NSDictionary
                        let telefonoUsuario = bancoAlimentos!["telefono"] as? String
                        
                        let direccion = bancoAlimentos!["direccion"] as? NSDictionary
                        let calle = "" //direccion!["calle"] as? String
                        let numero = "" //direccion!["numero"] as? String
                        
                        let direccionUsuario = "\(calle ?? "") #\(numero ?? "")"
                        
                        let _links = jsonBanco["_links"] as? NSDictionary
                        
                        let producto = ""
                        
                        let pesoUnitario = Float(cantidadKg!)! / Float(cantidadPza!)!
                        
                        arrayEntradaAlmacen.append(EntradaAlmacen(nombreProducto: producto, nombreUsuario: nombreUsuario!, direccionUsuario: direccionUsuario, telefonoUsuario: telefonoUsuario!, folio: folio!, fechaEntrada: fecha, cantidadKg: cantidadKg!, cantidadPza: cantidadPza!, fechaConsumoLimite: fechaConsumoLimite!, pagoCosecha: pagoCosecha!, comentarios: comentarios!, cantidadBuenEstado: cantidadRecibidaBuenEstado!, costoOperativoAcopio: costoOperativoAcopio!, pesoUnitario: pesoUnitario, pesoTotal: Int(cantidadKg!), _links: _links))
                        
                        
                    }
                    completionSucces(arrayEntradaAlmacen)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
    func fetchLinksProducto(links: NSDictionary, completionSucces: @escaping ((String, String, String, String, String, String)) -> (), completionError: @escaping () -> Void) {
        
        let detalleDonativo = links["detalleDonativo"] as? NSDictionary
        
        let href = detalleDonativo!["href"] as? String
        
        let detalleArr = href?.components(separatedBy: "{")
        
        guard let urlLink = detalleArr?.first else { return }
        
        guard let url = URL(string: urlLink) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            //perhaps check err
            //also perhaps check response status 200 OK
            
            if let err = err {
                print("Error:", err.localizedDescription)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let data = data else {
                completionError()
                return
                
            }
            
            let httpStatus = response as? HTTPURLResponse
            print(httpStatus?.statusCode ?? "")
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                let cantidadKg = dico["cantidadKg"] as? String
                
                let _embedded = dico["_embedded"] as? NSDictionary
                
                let productoDict = _embedded!["producto"] as? NSDictionary
                
                let nombreProducto = productoDict!["nombre"] as? String
                
                let donativo = _embedded!["donativo"] as? NSDictionary
                
                let contactoDonador = donativo!["contactoDonador"] as? NSDictionary
                let nombreDonador = contactoDonador!["nombre"] as? String
                let apellidoDonador = contactoDonador!["apellido"] as? String
                
                let nombreCompletoDonador = "\(nombreDonador ?? "") \(apellidoDonador ?? "")"
                
                let direccionAcopio = donativo!["direccionAcopio"] as? NSDictionary
                let calle = direccionAcopio!["calle"] as? String
                let numero = direccionAcopio!["numero"] as? String
                
                let domicilioAcopio = "\(calle ?? "") #\(numero ?? "")"
                
                let ciudad = direccionAcopio!["ciudad"] as? String
                let estado = direccionAcopio!["estado"] as? String
                
                let ciudadAcopio = "\(ciudad ?? ""), \(estado ?? "")"
                
                let transportesUnidades = donativo!["transportesUnidades"] as? NSDictionary
                let tipoUnidad = transportesUnidades!["tipoUnidad"] as? String
                
                completionSucces((nombreProducto!, cantidadKg!, tipoUnidad!, domicilioAcopio, ciudadAcopio, nombreCompletoDonador))
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr.localizedDescription)
                completionError()
            }
            
            }.resume()
        
    }
    
    // MARK: Salidas Almacen
    func fetchSalidaAlmacen(completionSucces: @escaping ([SalidaAlmacen]) -> (), completionError: @escaping () -> Void) {
        
        arraySalidaAlmacen.removeAll()
        
        let urlSalidaAlmacen = "\(urlBase)salidasalmacen"
        
        guard let url = URL(string: urlSalidaAlmacen) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    
                    let entradasAlmacen = _embedded["salidasalmacen"] as! NSArray
                    
                    for almacenActual in entradasAlmacen {
                        let jsonBanco:Dictionary<String, AnyObject> = almacenActual as! Dictionary<String, AnyObject>
                        
                        let usuario = jsonBanco["usuario"] as? NSDictionary
                        let nombreUsuario = usuario!["nombre"] as? String
                        
                        let cantidad = jsonBanco["cantidad"] as? String
                        let motivo = jsonBanco["motivo"] as? String
                        
                        let fechaArr = jsonBanco["fechaSalida"] as? String
                        
                        let fechaSalidaArr = fechaArr?.components(separatedBy: "T")
                        let fechaCompletaArr = fechaSalidaArr![0].components(separatedBy: "-")
                        let fecha = "\(fechaCompletaArr[2])/\(fechaCompletaArr[1])/\(fechaCompletaArr[0])"
                        
                        
                        arraySalidaAlmacen.append(SalidaAlmacen(nombreUsuario: nombreUsuario!, cantidad: cantidad!, motivo: motivo!, fechaSalida: fecha))
                        
                    }
                    
                    completionSucces(arraySalidaAlmacen)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
    // MARK: Oferta Donativo
    func fetchOfertaDonativo(completionSucces: @escaping ([DetalleDonativo]) -> (), completionError: @escaping () -> Void) {
        
        arrayDetalleDonativo.removeAll()
        
        let urlSalidaAlmacen = "\(urlBase)detalledonativo"
        
        guard let url = URL(string: urlSalidaAlmacen) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    
                    let detalleDonativo = _embedded["detalledonativo"] as! NSArray
                    
                    for almacenActual in detalleDonativo {
                        let jsonBanco:Dictionary<String, AnyObject> = almacenActual as! Dictionary<String, AnyObject>
                        
                        let _embedded = jsonBanco["_embedded"] as? NSDictionary
                        
                        let cantidadKg = jsonBanco["cantidadKg"] as? String
                        
                        let fechaConsumoLimiteString = jsonBanco["fechaConsumoLimite"] as? String
                        
                        let fechaLimiteArr = fechaConsumoLimiteString?.components(separatedBy: "T")
                        let fechaLimiteCompletaArr = fechaLimiteArr![0].components(separatedBy: "-")
                        let fechaConsumoLimite = "\(fechaLimiteCompletaArr[2])/\(fechaLimiteCompletaArr[1])/\(fechaLimiteCompletaArr[0])"
                        
                        let cosecha = jsonBanco["cosecha"] as? Bool
                        var cosechado = ""
                        
                        if cosecha == true {
                            cosechado = "Se necesitó cosechar"
                        } else {
                            cosechado = "No se necesitó cosechar"
                        }
                        
                        let pagoCosecha = "\((jsonBanco["pagoCosecha"] as? Int) ?? 0)"
                        
                        let cantidadEmbalaje = "\((jsonBanco["cantidadEmbalaje"] as? Int) ?? 0)"
                        
                        
                        //Producto
                        let producto = _embedded!["producto"] as? NSDictionary
                        
                        let nombreProducto = producto!["nombre"] as? String
                        
                        //donativo
                        let donativo = _embedded!["donativo"] as? NSDictionary
                        let especificacionesString = donativo!["especificaciones"] as? String
                        let fechaAcopioString = donativo!["fechaAcopio"] as? String
                        
                        let fechaAcopioArr = fechaAcopioString?.components(separatedBy: "T")
                        let fechaCompletaArr = fechaAcopioArr![0].components(separatedBy: "-")
                        let fechaAcopio = "\(fechaCompletaArr[2])/\(fechaCompletaArr[1])/\(fechaCompletaArr[0])"
                        
                        let transportesUnidades = donativo!["transportesUnidades"] as? NSDictionary
                        let tipoTransporte = transportesUnidades!["tipoUnidad"] as? String
                        
                        let transportesCajas = donativo!["transportesCajas"] as? NSDictionary
                        let tipoCaja = transportesCajas!["tipoCaja"] as? String
                        let tipoEmbalaje = "Caja \(tipoCaja ?? "")"
                        
                        //procurador
                        let bancoAlimentos = _embedded!["bancoAlimentos"] as? NSDictionary
                        let telefonoAcopio = bancoAlimentos!["telefono"] as? String
                        
                        let contacto = bancoAlimentos!["contacto"] as? NSDictionary
                        let nombreProcurador = contacto!["nombre"] as? String
                        let telefonoProcurador = contacto!["telefono"] as? String
                        let extensionAcopio = "\((contacto!["extension"] as? Int) ?? 0)"
                        let celularProcurador = contacto!["celular"] as? String
                        let correoAcopio = contacto!["email"] as? String
                        
                        let direccion = bancoAlimentos!["direccion"] as? NSDictionary
                        let calle = direccion!["calle"] as? String
                        let numero = direccion!["numero"] as? String
                        
                        let domicilioAcopio = "\(calle ?? "") #\(numero ?? "")"
                        
                        arrayDetalleDonativo.append(DetalleDonativo(nombreProducto: nombreProducto!, fechaAcopio: fechaAcopio, tipoTransporte: tipoTransporte!, nombreProcurador: nombreProcurador!, cantidadKG: cantidadKg!, fechaConsumoLimite: fechaConsumoLimite, cosechado: cosechado, pagoCosecha: pagoCosecha, embalaje: cantidadEmbalaje, tipoEmbalaje: tipoEmbalaje, domicilioAcopio: domicilioAcopio, telefonoAcopio: telefonoAcopio!, extensionAcopio: extensionAcopio, celularAcopio: celularProcurador!, proveedorSugerido: "", especificaciones: especificacionesString!, correoProcurador: correoAcopio!, telefonoProcurador: telefonoProcurador!, celularProcurador: celularProcurador))
                        
                    }
                    
                    completionSucces(arrayDetalleDonativo)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
    // MARK: Solicitd de recoleccion
    func fetchSolicitudRecoleccion(completionSucces: @escaping ([SolicitudRecoleccion]) -> (), completionError: @escaping () -> Void) {
        
        arraySolicitudRecoleccion.removeAll()
        
        let urlSalidaAlmacen = "\(urlBase)solicitudesrecoleccion"
        
        guard let url = URL(string: urlSalidaAlmacen) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    
                    let solicitudesRecoleccion = _embedded["solicitudesrecoleccion"] as! NSArray
                    
                    for almacenActual in solicitudesRecoleccion {
                        let jsonBanco:Dictionary<String, AnyObject> = almacenActual as! Dictionary<String, AnyObject>
                        
                        let proveedor = jsonBanco["proveedor"] as? NSDictionary
                        let nombreEmpresa = proveedor!["nombre"] as? String
                        
                        let fechaProgramada = jsonBanco["fechaProgramada"] as? String
                        
//
                        let fechaRecoleccionArr = fechaProgramada?.components(separatedBy: "T")
                        let fechaRecoleccionCompletaArr = fechaRecoleccionArr![0].components(separatedBy: "-")
                        let fechaRecoleccion = "\(fechaRecoleccionCompletaArr[2])/\(fechaRecoleccionCompletaArr[1])/\(fechaRecoleccionCompletaArr[0])"
                        
                        let horaRecoleccionArr = fechaRecoleccionArr?.last?.components(separatedBy: "+")
                        let horaRecoleccionCompletaArr = horaRecoleccionArr![0].components(separatedBy: ":")
                        let horaRecoleccion = "\(horaRecoleccionCompletaArr[0]):\(horaRecoleccionCompletaArr[1])"
                        
                        
                        let _links = jsonBanco["_links"] as? NSDictionary
                        
                        let tipoProducto = ""
                        let cantidadProducto = ""
                        let tipoVehiculo = ""
                        
                        arraySolicitudRecoleccion.append(SolicitudRecoleccion(nombreEmpresa: nombreEmpresa!, domicilioEmpresa: "-", fechaRecoleccion: fechaRecoleccion, ciudadRecoleccion: "-", nombreContacto: nombreEmpresa!, tipoProducto: tipoProducto, cantidadProducto: cantidadProducto, horaRecoleccion: horaRecoleccion, tipoVehiculo: tipoVehiculo, nombreEntrega: nombreEmpresa!, _links: _links!))
                    }
                    
                    completionSucces(arraySolicitudRecoleccion)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
   
    // MARK: Proveedores
    func fetchProveedores(completionSucces: @escaping ([Proveedor]) -> (), completionError: @escaping () -> Void) {
        
        arrayProveedores.removeAll()
        
        let urlSalidaAlmacen = "\(urlBase)proveedores"
        
        guard let url = URL(string: urlSalidaAlmacen) else { return }
        
        let request = get(requestUrl: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Error:", err)        //poner en un alertView              *****
                completionError()
                return
            }
            
            guard let contactData = data else {
                completionError()
                return
                
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: contactData, options: JSONSerialization.ReadingOptions.mutableLeaves)
                
                let dico = json as! NSDictionary
                
                //Si el token es inválido
                if let err = dico["error"] {
                    self.errorDescription = err as? String
                    completionError()
                } else {
                    
                    let _embedded = dico["_embedded"] as! NSDictionary
                    
                    let proveedores = _embedded["proveedores"] as! NSArray
                    
                    for almacenActual in proveedores {
                        let jsonBanco:Dictionary<String, AnyObject> = almacenActual as! Dictionary<String, AnyObject>
                        
                        let nombreProveedor = jsonBanco["nombre"] as? String
                        
                        let contacto = jsonBanco["contacto"] as? NSDictionary
                        let nombreContacto = contacto!["nombre"] as? String
                        let apellidoContacto = contacto!["apellido"] as? String
                        let telefonoContacto = contacto!["telefono"] as? String
                        let extensionContacto = "\(contacto!["extension"] as? Int ?? 0)"
                        let celularContacto = contacto!["celular"] as? String
                        let correoContacto = contacto!["email"] as? String
                        
                        arrayProveedores.append(Proveedor(nombreProveedor: nombreProveedor!, nombreContactoProveedor: nombreContacto!, apellidoContactoProveedor: apellidoContacto!, telefonoContactoProveedor: telefonoContacto!, extensionContactoProveedor: extensionContacto, celularContactoProveedor: celularContacto!, correoContactoProveedor: correoContacto!))
                    }
                    
                    completionSucces(arrayProveedores)
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                completionError()
            }
            
            }.resume()
    }
    
    // MARK: - Post
    func post(json: String, requestUrl: URL, isLogin: Bool) -> URLRequest {
        
        var request = URLRequest(url:requestUrl)
        
        request.httpMethod = "POST"
        
        //Agrega encabezados
        if isLogin {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("Basic dXNlcjpwYXNzd29yZA==", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        } else {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(String(describing: self.accessToken!))", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = json.data(using: String.Encoding.utf8)
        
        return request
    }
    
    // MARK: - Put
    func put(json: String, requestUrl: URL) -> URLRequest {
        
        var request = URLRequest(url:requestUrl)
        
        request.httpMethod = "Put"
        
        //Agrega encabezados
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(String(describing: self.accessToken!))", forHTTPHeaderField: "Authorization")
        request.httpBody = json.data(using: String.Encoding.utf8)
        
        return request
    }
    
    // MARK: - Get
    func get(requestUrl: URL) -> URLRequest {
        
        var request = URLRequest(url:requestUrl)
        
        request.httpMethod = "GET"
        
        //Agrega encabezados
        request.setValue("Bearer \(String(describing: self.accessToken!))", forHTTPHeaderField: "Authorization")
//        request.httpBody = json.data(using: String.Encoding.utf8)
        
        return request
    }
    
    // MARK: - Response
    func urlResponse(response: URLResponse?) -> Int {
        //obtener la cookie
        var statusCode = 200
        
        //Si statusCode es diferente a 200 se originó un error y se le notificará al usuario
        if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200
        {           // check for http errors
            statusCode = httpStatus.statusCode
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
            //            self.statusCode = httpStatus.statusCode
            
        }
        
        return statusCode
    }
    
}
