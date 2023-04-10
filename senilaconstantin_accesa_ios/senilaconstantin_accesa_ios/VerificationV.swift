//
//  VerificationV.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

struct VerificationV: View {
    @StateObject var verificationVM: VerificationViewModel = .init()
    var body: some View {
        if verificationVM.isLogged {
            DashboardView()
                .environmentObject(verificationVM)
        } else {
            LoginView()
                .environmentObject(verificationVM)
        }
    }
}
