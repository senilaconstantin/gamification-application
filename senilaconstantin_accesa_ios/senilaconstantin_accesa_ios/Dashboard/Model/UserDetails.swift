//
//  UserDetails.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import Foundation

public class UserDetails: Codable, ObservableObject {
    public var uuid: Int
    public var firstName: String
    public var lastName: String
    public var token: Int
    public var badges: Int
    public var ranking: Float
    
    public init(uuid: Int, firstName: String, lastName: String, token: Int, badges: Int, ranking: Float) {
        self.uuid = uuid
        self.firstName = firstName
        self.lastName = lastName
        self.token = token
        self.badges = badges
        self.ranking = ranking
    }
}
