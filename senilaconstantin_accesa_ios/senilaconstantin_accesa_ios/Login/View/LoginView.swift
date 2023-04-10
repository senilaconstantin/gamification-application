//
//  ContentView.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var verificationVM: VerificationViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.system(size: 45))
            VStack {
                TextField("E-mail", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                SecureField("Parola", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                Button(action: {
                    APIClient.shared.loginUser(email: email, password: password) { tokenModel, error in
                        DispatchQueue.main.async {
                            if let tokenModel = tokenModel {
                                verificationVM.ver()
                                print("Succes Login: \(tokenModel.access_token)")
                            } else {
                                print("Error \(error ?? "")")
                                errorMessage = "Wrong email or password!"
                            }
                        }
                    }
                }) {
                    HStack{
                        Spacer()
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            
                        Spacer()
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                    
                }
            }
            .padding([.leading, .trailing, .top], 30)
            Spacer()
        }
        .padding()
        .alert(isPresented: .constant(errorMessage != "")) {
            Alert(title: Text("Error!"), message: Text(errorMessage), dismissButton: .default(Text("OK"), action: {
                errorMessage = ""
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
