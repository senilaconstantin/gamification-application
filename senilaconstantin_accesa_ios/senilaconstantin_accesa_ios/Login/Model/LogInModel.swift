//
//  LogInModel.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

public struct LogInModel: Encodable {
    public var password: String
    public var email: String
    
    public init(email: String, password: String) {
        self.password = password
        self.email = email
    }
    enum CodingKeys: String, CodingKey {
        case password, email
    }
}
