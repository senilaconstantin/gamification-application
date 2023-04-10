//
//  VerificationViewModel.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

class VerificationViewModel: ObservableObject {
    @Published var isLogged: Bool = false
    
    init() {
        isLogged = CurrentUser.shared.isLoggedIn()
    }
    func ver() {
        isLogged = CurrentUser.shared.isLoggedIn()
    }
}
