//
//  CurrentUser.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

class CurrentUser {
    static let shared = CurrentUser()
    private let defaults = UserDefaults.standard
    
    func isLoggedIn() -> Bool {
        var tokenR: TokenModel = .init(access_token: "", refresh_token: "")
        if let savedData = defaults.object(forKey: "token") as? Data {
            let decoder = JSONDecoder()
            if let token = try? decoder.decode(TokenModel.self, from: savedData) {
                tokenR = token
            }
        }
        return tokenR.access_token != ""
    }
    
    func getToken() -> TokenModel {
        var tokenR: TokenModel = .init(access_token: "", refresh_token: "")
        if let savedData = defaults.object(forKey: "token") as? Data {
            let decoder = JSONDecoder()
            if let token = try? decoder.decode(TokenModel.self, from: savedData) {
                tokenR = token
            }
        }
        return tokenR
    }
    
    func saveToken(tokenModel: TokenModel) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(tokenModel) {
            defaults.set(encodedData, forKey: "token")
        } else {
            print("Error saveToken!")
        }
    }
    
    func logout() {
        let token = TokenModel(access_token: "", refresh_token: "")
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(token) {
            defaults.set(encodedData, forKey: "token")
        } else {
            print("Error deleteToken!")
        }
    }
}

