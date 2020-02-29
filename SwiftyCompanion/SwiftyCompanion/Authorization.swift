//
//  Authorization.swift
//  SwiftyCompanion
//
//  Created by Сергей Гусаченко on 2/7/20.
//  Copyright © 2020 SergeiGusachenko. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Authorization: NSObject {

    var token = String()
    let url = "https://api.intra.42.fr/oauth/token"
    let config = [
        "grant_type": "client_credentials",
        "client_id": "af5bea52bff6055c70a9f2d02789047599a40fe4027208bbb9b6ee3867616ec1",
        "client_secret": "c25a44c257a839e494b7b25cd68c9806e3e06d59b81a18fd2420d2b2c70a44d4"]

    func getToken() {
        let verify = UserDefaults.standard.object(forKey: "token")
        if verify == nil {
            Alamofire.request(url, method: .post, parameters: config).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.token = json["access_token"].stringValue
                        UserDefaults.standard.set(json["access_token"].stringValue, forKey: "token")
                        print("NEW token:", self.token)
                        self.checkToken()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.token = verify as! String
            print("SAME token:", self.token)
            checkToken()
        }
    }
    
    private func checkToken() {
        let url = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("The token will expire in:", json["expires_in_seconds"], "seconds.")
                }
            case .failure:
                print("Error: Trying to get a new token...")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
        }
    }
    
    func checkUser(_ user: String, completion: @escaping (JSON?) -> Void) {
        let userUrl = URL(string: "https://api.intra.42.fr/v2/users/" + user)
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: userUrl!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    completion(json)
                }
            case .failure:
                completion(nil)
                print("Error: This login doesn't exists")
            }
        }
    }
}
