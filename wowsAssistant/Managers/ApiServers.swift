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

    enum Realm: String {
        case ru = "ru"
        case eu = "eu"
        case na = "na"
        case asia = "asia"
    }
    
    private let host = "https://api.worldofwarships"
    //https://api.worldofwarships.ru/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248
    //https://api.worldofwarships.eu/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248
    //https://api.worldofwarships.com/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248
    //https://api.worldofwarships.asia/wows/encyclopedia/ships/?application_id=a604db0355085bac597c209b459fd0fb&language=zh-cn&limit=6&ship_id=3763255248

    func getDDs(url: String, completion: @escaping(([String:Any]?) -> Void)) {
        getDataFromWows(url, parameters: [:]) { (getDictionary, error) in
            completion(getDictionary)
        }
    }
    
    // MARK: - basic GET and POST by url for wows
    /**
     * ⚓️ get data with url string, return NULL, using Alamofire
     */
    private func getDataFromWows(_ route: String, parameters: [String: Any], completion: @escaping(([String:Any]?, Error?) -> Void)) {
        var urlStr = route
        var parameterLinker = "?"
        
        for pair in parameters {
            urlStr = "\(urlStr)\(parameterLinker)\(pair.key)=\(pair.value)"
            parameterLinker = "&"
        }
        
        guard let url = URL(string: urlStr) else {
            DLog("⛔️ unable to parse url from string: \(urlStr)")
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                DLog("[GET_ERROR] in URLSession dataTask: \(err.localizedDescription)")
                completion(nil, err)
            }
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any],
                        let getObject = json["data"] as? [String:Any] else {
                            
                        DLog("[GET_ERROR] in getDataFromWows: unable to serialize the Data...")
                        completion(nil, nil)
                        return
                    }
                    completion(getObject, nil)
                    
                } catch let error {
                    DLog("[GET_ERROR] in getDataFromWows: \(error.localizedDescription)")
                    completion(nil, error)
                }
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

