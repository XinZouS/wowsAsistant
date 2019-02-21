//
//  ApiServers.swift
//  wowsAssistant
//
//  Created by Xin Zou on 1/13/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import Foundation
import Alamofire
import Unbox


final class ApiServers: NSObject {
    
    static let shared = ApiServers()
    
    private override init() {
        super.init()
    }
    
    enum ServerKey: String {
        case applicationId = "application_id"
        case shipId = "ship_id"
        case type = "type"
        case language = "language"
        case limit = "limit"
        case page_no = "page_no"
        case nation = "nation"
        case fields = "fields"
        case consumableId = "consumable_id"
        
        case meta = "meta"
        case data = "data"
        case statusCode = "status_code"
        case message = "message"
        case appToken = "app_token"
        case userToken = "user_token"
        case username  = "username"
        case password  = "password"
        case phone     = "phone"
        case email     = "email"
        case timestamp = "timestamp"
        case pageCount = "page_count"
        case offset = "offset"
        case deviceToken = "device_token"
        case userId = "user_id"
        case code = "code"
    }

    private let host = "https://api.worldofwarships"
    //https://api.worldofwarships.ru/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248
    //https://api.worldofwarships.eu/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248
    //https://api.worldofwarships.com/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248
    //https://api.worldofwarships.asia/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248

    private let wowsEncyclopedia = "/wows/encyclopedia"
    
    private enum WowsRoute: String {
        case ships = "/ships/"
        case consumables = "/consumables/"
        case commanderSkills = "/crewskills/"
    }
    
    
    func getShipById(_ id: Int, realm: ServerRealm, completion: @escaping((ShipInfo?) -> Void)) {
        var params: [String:Any] = [:]
        params[ServerKey.applicationId.rawValue] = AppConfigs.appId.rawValue
        params[ServerKey.language.rawValue] = ServiceManager.shared.getShipDescriptionLanguage()
        params[ServerKey.shipId.rawValue] = id

        let route = "\(host).\(realm.rawValue)\(wowsEncyclopedia)\(WowsRoute.ships.rawValue)"
        
        getDataFromWows(route, parameters: params) { (dictionary, error) in
            if let d = dictionary, let shipDictionary = d["\(id)"] as? [String:Any] {
                do {
                    let shipInfo: ShipInfo = try unbox(dictionary: shipDictionary)
                    completion(shipInfo) // ✅ get dictionary
                    
                } catch let error as NSError {
                    DLog("[ERROR] unboxing ShipInfo failed: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    //https://api.worldofwarships.com/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&fields=ship_id%2C+type%2C+tier%2C+nation&limit=100&page_no=1&ship_id=4291704528%2C+4291737584%2C+4291770064
    func getShipByIdsList(_ ids: [Int], realm: ServerRealm, completion: @escaping([ShipInfo]?) -> Void) {
        var result: [ShipInfo] = []
        if ids.count == 0 {
            completion(nil)
            return
        }
        if ids.count == 1 {
            getShipById(ids[0], realm: realm) { (shipInfo) in
                if let s = shipInfo {
                    result.append(s)
                }
                completion(result)
            }
            return
        }
        
        var params: [String:Any] = [:]
        params[ServerKey.applicationId.rawValue] = AppConfigs.appId.rawValue
        params[ServerKey.language.rawValue] = ServiceManager.shared.getShipDescriptionLanguage()
        
        var idsStr = "\(ids[0])"
        for i in 1..<ids.count {
            idsStr = "\(idsStr)%2C+\(ids[i])"
        }
        params[ServerKey.shipId.rawValue] = idsStr
        
        let route = "\(host).\(realm.rawValue)\(wowsEncyclopedia)\(WowsRoute.ships.rawValue)"
        
        getDataFromWows(route, parameters: params) { (dictionary, error) in
            if let d = dictionary {
                for pair in d {
                    if let getDict = pair.value as? [String:Any] {
                        do {
                            let getInfo: ShipInfo = try unbox(dictionary: getDict)
                            result.append(getInfo)
                            
                        } catch let error as NSError {
                            DLog("[ERROR] unboxing ShipInfo from list failed: \(error)")
                        }
                    }
                }
                completion(result)
                
            } else {
                completion(nil)
            }
        }
    }
    
    func getShipsList(realm: ServerRealm = .na, shipType: ShipType?, nation: ShipNation?, limit: Int = 10, pageNum: Int = 1, completion: @escaping(([ShipInfo]?) -> Void)) {
        var params: [String:Any] = [:]
        params[ServerKey.applicationId.rawValue] = AppConfigs.appId.rawValue
        params[ServerKey.language.rawValue] = ServiceManager.shared.getShipDescriptionLanguage()
        
        if let type = shipType {
            params[ServerKey.type.rawValue] = type.rawValue
        }
        if let nat = nation {
            params[ServerKey.nation.rawValue] = nat.rawValue
        }
        params[ServerKey.limit.rawValue] = limit
        params[ServerKey.page_no.rawValue] = pageNum
        
        let route = "\(host).\(realm.rawValue)\(wowsEncyclopedia)\(WowsRoute.ships.rawValue)"
        var ships: [ShipInfo] = []
        
        getDataFromWows(route, parameters: params) { (dictionary, error) in
            if let d = dictionary {
                do {
                    for pair in d {
                        if let infoDictionary = pair.value as? [String:Any] {
                            let getInfo: ShipInfo = try unbox(dictionary: infoDictionary)
                            ships.append(getInfo)
                        }
                    }
                    completion(ships) // ✅ get dictionary
                    
                } catch let error as NSError {
                    DLog("[ERROR] unboxing ShipList Info failed: \(error)")
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    // https://api.worldofwarships.com/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&fields=ship_id%2C+type%2C+tier%2C+nation&limit=100&page_no=4
    func getShipInfoBasicList(limit: Int = 100, pageNum: Int = 1, completion: @escaping(() -> Void)) {
        var params: [String:Any] = [:]
        params[ServerKey.applicationId.rawValue] = AppConfigs.appId.rawValue
        params[ServerKey.limit.rawValue] = limit
        params[ServerKey.page_no.rawValue] = pageNum
        params[ServerKey.fields.rawValue] = "ship_id%2C+type%2C+tier%2C+nation"
        
        let realm = UserDefaults.getServerRelam()
        let route = "\(host).\(realm.rawValue)\(wowsEncyclopedia)\(WowsRoute.ships.rawValue)"
        getDataFromWows(route, parameters: params) { (dictionary, error) in
            if let d = dictionary {
                for pair in d {
                    if let info = pair.value as? [String:Any] {
                        let getBasic = ShipInfoBasic(context: PersistenceManager.shared.context)
                        getBasic.setupByDictionary(info) // ✅ get
                    } else {
                        DLog("[ERROR] unable to unwarp Basics by dictionary in getShipInfoBasicList()")
                    }
                }
                completion()
                return
            }
            completion()
        }
    }
    
    // https://api.worldofwarships.com/wows/encyclopedia/consumables/?application_id=a604db0355085bac597c209b459fd0fb&consumable_id=4275228592%2C+4281520048
    func getConsumable(ids: [Int]?, type: String? = nil, limit: Int = 100, pageNum: Int = 1, completion: @escaping(([Consumable]) -> Void)) {
        var params: [String:Any] = [:]
        params[ServerKey.limit.rawValue] = limit
        params[ServerKey.page_no.rawValue] = pageNum
        params[ServerKey.applicationId.rawValue] = AppConfigs.appId.rawValue
        if let type = type {
            params[ServerKey.type.rawValue] = type
        }
        
        if let ids = ids, ids.count > 0 {
            var idsStr = "\(ids[0])"
            for i in 1..<ids.count {
                idsStr = "\(idsStr)%2C+\(ids[i])"
            }
            params[ServerKey.consumableId.rawValue] = idsStr
        }
        
        let realm = UserDefaults.getServerRelam()
        let route = "\(host).\(realm.rawValue)\(wowsEncyclopedia)\(WowsRoute.consumables.rawValue)"
        
        getDataFromWows(route, parameters: params) { (dictionary, error) in
            var consumables: [Consumable] = []
            guard let dict = dictionary else {
                completion(consumables)
                return
            }
            for pair in dict {
                if let getDict = pair.value as? [String:Any] {
                    do {
                        let getConsumable: Consumable = try unbox(dictionary: getDict)
                        consumables.append(getConsumable)
                        
                    } catch let error as NSError {
                        DLog("[ERROR] unboxing Consumable from list failed: \(error)")
                    }
                }
            }
            completion(consumables)
        }
    }
    // https://api.worldofwarships.com/wows/encyclopedia/crewskills/?application_id=a604db0355085bac597c209b459fd0fb
    func getCommanderSkills(completion: @escaping([CommanderSkill]) -> Void) {
        var params: [String:Any] = [:]
        params[ServerKey.applicationId.rawValue] = AppConfigs.appId.rawValue
        
        let realm = UserDefaults.getServerRelam()
        let route = "\(host).\(realm.rawValue)\(wowsEncyclopedia)\(WowsRoute.commanderSkills.rawValue)"
        
        getDataFromWows(route, parameters: params) { (dictionary, error) in
            var skills: [CommanderSkill] = []
            guard let dict = dictionary else {
                completion(skills)
                return
            }
            for pair in dict {
                if let getDict = pair.value as? [String:Any] {
                    do {
                        let getSkill: CommanderSkill = try unbox(dictionary: getDict)
                        skills.append(getSkill)
                    } catch let error as NSError {
                        DLog("[ERROR] unboxing CommanderSkill from list failed: \(error)")
                    }
                }
            }
            completion(skills)
        }
    }
    
    
    // MARK: - basic GET and POST by url for wows
    /**
     * ⚓️ 🚢 get data with url string, return NULL, using Alamofire
     */
    private func getDataFromWows(_ route: String, parameters: [String: Any], completion: @escaping(([String:Any]?, Error?) -> Void)) {
        var urlStr = route
        var parameterLinker = "?"
        
        for pair in parameters {
            let val: String = "\(pair.value)"
            if val != "" {
                urlStr = "\(urlStr)\(parameterLinker)\(pair.key)=\(val)"
                parameterLinker = "&"
            }
        }
        
        guard let url = URL(string: urlStr) else {
            DLog("⛔️ unable to parse url from string: \(urlStr)")
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            #if DEBUG
            let printText: String = """
            =========================
            [TIME UTC] \(Date())
            [TIME GMT] \(Date().getCurrentLocalizedDate())
            [GET ROUTE] \(route)
            [RESPONSE] \(response?.url?.debugDescription ?? "")
            """
            print(printText)
            #endif
            
            if let err = error {
                DLog("[GET_ERROR] in URLSession dataTask: \(err.localizedDescription)")
                completion(nil, err)
                return
            }
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any],
                        let getObject = json[ServerKey.data.rawValue] as? [String:Any] else {
                            
                        DLog("[GET_ERROR] in getDataFromWows: unable to serialize the Data...")
                        completion(nil, nil)
                        return
                    }
                    completion(getObject, nil) // ✅ get dictionary
                    
                } catch let error {
                    DLog("[GET_ERROR] in getDataFromWows: \(error.localizedDescription)")
                    DLog("[RESPONSE] \(response.debugDescription)")
                    completion(nil, error)
                }
            } else {
                DLog("[GET_ERROR] error value = \(error?.localizedDescription ?? "NULL")")
                DLog("[FULL RESPONSE] = \(response?.debugDescription ?? "NULL")")
                completion(nil, error)
            }
        }.resume()
    }
    
    
    // MARK: - basic GET and POST by url
    /**
     * ✅ get data with url string, return NULL, using Alamofire
     */
    private func getDataWithUrlRoute(_ route: String, parameters: [String: Any], completion: @escaping(([String : Any]?, Error?) -> Void)) {
        let requestUrlStr = host + route
        
        // TODO: see if we need cookie
        var cookieHeaders: [String: String]?
//        if let cookie = ProfileManager.shared.getCurrentCookie() {
//            cookieHeaders = HTTPCookie.requestHeaderFields(with: [cookie])
//        }
        
        Alamofire.request(requestUrlStr, parameters: parameters, headers: cookieHeaders).responseString { response in
            if let urlRequest = response.request?.url {
                let printText: String = """
                =========================
                [TIME UTC] \(Date())
                [TIME GMT] \(Date().getCurrentLocalizedDate())
                [GET ROUTE] \(route)
                [REQUEST] \(urlRequest)
                """
                DLog(printText)
            }
            
            if let responseValue = response.value?.toJSON() as? [String: Any] {
                
                if let statusCode = responseValue[ServerKey.statusCode.rawValue] as? Int, statusCode != 200 {
                    let message = responseValue[ServerKey.message.rawValue] ?? ""
                    let printText: String = """
                    =========================
                    [STATUS_CODE] \(statusCode)
                    [MESSAGE]: \(message)
                    """
                    DLog(printText)
                    
                    self.handleAbnormalStatusCode(statusCode)
                }
                
                completion(responseValue, nil)
            } else {
                DLog("[GET_ERROR] raw data = \(response.data?.description ?? "NULL")")
                DLog("[GET_ERROR] raw data debug description = \(response.data?.debugDescription ?? "NULL")")
                DLog("[GET_ERROR] description value = \(response.description)")
                DLog("[GET_ERROR] error value = \(response.error?.localizedDescription ?? "NULL")")
                DLog("[FULL RESPONSE] = \(response.value ?? "NULL")")
                completion(nil, response.result.error)
            }
        }
    }
    
    /**
     * ✅ POST data with url string, using Alamofire
     */
    private func postDataWithUrlRoute(_ route: String, parameters: [String: Any], completion: @escaping(([String : Any]?, Error?) -> Void)) {
        
        let requestUrlStr = host + route
        
        // TODO: see if we need cookie
        var cookieHeaders: [String: String]?
//        if let cookie = ProfileManager.shared.getCurrentCookie() {
//            cookieHeaders = HTTPCookie.requestHeaderFields(with: [cookie])
//        }
        
        //headers: cookieHeaders
        Alamofire.request(requestUrlStr,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: cookieHeaders).responseString { (response) in
                            
                            if let requestBody = response.request?.httpBody, let body = NSString(data: requestBody, encoding: String.Encoding.utf8.rawValue) {
                                let printText: String = """
                                =========================
                                [TIME UTC] \(Date())
                                [TIME GMT] \(Date().getCurrentLocalizedDate())
                                [POST ROUTE] \(route)
                                [PARAMETERS] \(parameters)
                                [BODY] \(body)
                                """
                                DLog(printText)
                            }
                            
                            if let responseValue = response.value?.toJSON() as? [String: Any] {
                                
                                if let statusCode = responseValue[ServerKey.statusCode.rawValue] as? Int, statusCode != 200 {
                                    let message = responseValue[ServerKey.message.rawValue] ?? ""
                                    let printText: String = """
                                    =========================
                                    [STATUS_CODE] \(statusCode)
                                    [MESSAGE]: \(message)
                                    """
                                    DLog(printText)
                                    self.handleAbnormalStatusCode(statusCode)
                                }
                                
                                //If there is cookies found in post info, save the cookie
                                if let header = response.response?.allHeaderFields as? [String: String], let responseUrl = response.request?.url,
                                    let cookie = HTTPCookie.cookies(withResponseHeaderFields: header, for: responseUrl).first {
                                    DLog("[INFO] get cookie in postDataWithUrlRoute: \(cookie)")
//                                    ProfileManager.shared.saveCookie(cookie)
                                }
                                
                                completion(responseValue, nil)
                                
                            } else {
                                DLog("[POST_ERROR] raw data = \(response.data?.description ?? "NULL")")
                                if let data = response.data {
                                    let decodedData = String.init(data: data, encoding: String.Encoding.utf8)
                                    DLog("[POST_ERROR] data decoded = \(decodedData ?? "NULL")")
                                }
                                DLog("[POST_ERROR] description value = \(response.description)")
                                DLog("[POST_ERROR] error value = \(response.error?.localizedDescription ?? "NULL")")
                                DLog("[FULL RESPONSE] = \(response.value ?? "NULL")")
                                completion(nil, response.result.error)
                            }
        }
    }
}


    
    

extension ApiServers {
    func handleAbnormalStatusCode(_ statusCode: Int) {
        switch statusCode {
        case 401:
            DLog("⛔️ ApiServers.handleAbnormalStatusCode 401, logout user...")
        default:
            DLog("[Status Code] Not handled: \(statusCode)")
        }
    }
}

