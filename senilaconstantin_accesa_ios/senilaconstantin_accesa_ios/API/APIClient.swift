//
//  APIClient.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI
import Foundation
import Alamofire

class APIClient {
    static var shared = APIClient()
    
    func setToken(token: TokenModel) {
        CurrentUser.shared.saveToken(tokenModel: token)
    }
    
    func login(model: LogInModel, responseLogIn: @escaping (_ data: Data?) -> Void) {
        let urlString = "http://localhost:8082/api/v1/auth/authenticate"
        
        let headers: HTTPHeaders = [
            .contentType("application/json")
        ]
        
        AF.request(urlString,
                   method: .post,
                   parameters: model,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .response { response in
            debugPrint(response)
            DispatchQueue.main.async {
                switch response.result {
                case .success(let data):
                    responseLogIn(data)
                case .failure(let err):
                    print(err.localizedDescription)
                    responseLogIn(nil)
                }
            }
        }
    }
    
    func loginUser(email: String,
                   password: String,
                   completionHandler: @escaping (_ tokenModel: TokenModel?, _ error: String?) -> Void) {
        let model: LogInModel = .init(email: email, password: password)
        APIClient.shared.login(model: model) { data in
            if let data = data {
                guard let result = try? JSONDecoder().decode(TokenModel.self, from: data) else {
                    completionHandler(nil, "Decoding error!")
                    return
                }
                DispatchQueue.main.async {
                    print(result)
                    let tokenModel = TokenModel(access_token: result.access_token, refresh_token: result.refresh_token)
                    APIClient.shared.setToken(token: tokenModel)
                    completionHandler(tokenModel, nil)
                }
            } else {
                completionHandler(nil, "Wrong credentials!")
            }
        }
    }
    
    func addQuest(token: TokenModel, quest: QuestModelPost, addTestResponse: @escaping (_ error: Error?) -> Void) {
        let body: [String: Any] = ["quest": quest.quest, "tokens": quest.tokens, "badges": quest.badges]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        let urlString = "http://localhost:8082/quest/"
        guard let url = URL(string: urlString) else {
            print("url found nil")
            return
        }
        print(urlString)
        let accessToken = token.access_token // token is type TokenModel
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil, error == nil, let response = response as? HTTPURLResponse,
                  response.statusCode >= 200, response.statusCode < 300
            else {
                addTestResponse(error)
                print("Response Error!")
                return
            }
            addTestResponse(nil)
        }
        .resume()
    }
    
    func getQuests(token: TokenModel, questResponse: @escaping (_ data: Data?) -> Void) {
        let urlString = "http://localhost:8082/quest/getQuests"
        guard let url = URL(string: urlString) else {
            print("url found nil")
            return
        }
        print(urlString)
        let accessToken = token.access_token // token is type TokenModel
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        print(accessToken as Any)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse,
                  response.statusCode >= 200, response.statusCode < 300
            else {
                questResponse(nil)
                print("Response Error!")
                return
            }
            questResponse(data)
        }
        .resume()
    }
    
    func getQuestsData(token: TokenModel, userResponse: @escaping (_ data: [QuestModel]?) -> Void) {
        getQuests(token: token) { data in
            DispatchQueue.main.async {
                if let dataR = data {
                    guard let result = try? JSONDecoder().decode([QuestModel].self, from: dataR) else {
                        userResponse(nil)
                        return
                    }
                    userResponse(result)
                } else {
                    userResponse(nil)
                }
            }
        }
    }
    
    func updateQuest(token: TokenModel, id: Int, method: String, responseQuest: @escaping (_ error: Error?) -> Void) {
//            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            
            let urlString = "http://localhost:8082/quest/?id=\(id)"
            guard let url = URL(string: urlString) else {
                print("url found nil")
                return
            }
            
            let accessToken = token.access_token // token is type TokenModel
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
//            request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonData
           
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard data != nil, error == nil, let response = response as? HTTPURLResponse,
                      response.statusCode >= 200, response.statusCode < 300
                else {
                    responseQuest(error)
                    print("Response Error!")
                    return
                }
                responseQuest(nil)
            }
            .resume()
        }
    
    func updateQuestUser(token: TokenModel,
                         id: Int,
                         responseUpdateQuest: @escaping (_ error: Error?) -> Void) {
        updateQuest(token: token,
                    id: id,
                    method: "PUT") { error in
                responseUpdateQuest(error)
            }
        }
        
        
    
    func getUserDetails(token: TokenModel, userResponse: @escaping (_ data: Data?) -> Void) {
        let urlString = "http://localhost:8082/user/details"
        guard let url = URL(string: urlString) else {
            print("url found nil")
            return
        }
        print(urlString)
        let accessToken = token.access_token // token is type TokenModel
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        print(accessToken as Any)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse,
                  response.statusCode >= 200, response.statusCode < 300
            else {
                userResponse(nil)
                print("Response Error!")
                return
            }
            userResponse(data)
        }
        .resume()
    }
    
    func getUserDetailsDat(token: TokenModel, userResponse: @escaping (_ data: UserDetails?) -> Void) {
        getUserDetails(token: token) { data in
            DispatchQueue.main.async {
                if let data = data {
                    guard let result = try? JSONDecoder().decode(UserDetails.self, from: data) else {
                        userResponse(nil)
                        return
                    }
                    userResponse(result)
                } else {
                    userResponse(nil)
                }
            }
        }
    }
}
