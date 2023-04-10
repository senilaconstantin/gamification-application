//
//  AddQuestView.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

struct AddQuestView: View {
    @Binding var isShowing: Bool
    @Binding var quest: String
    @Binding var tokens: String
    @Binding var badges: String
    @EnvironmentObject var dashboardVM: DashboardViewModel
    @State private var isDragging = false
    @State private var errorMessage = ""
    @State private var prevDragTranslation = CGSize.zero
    
    @State private var curHeight: CGFloat = UIScreen.main.bounds.height * 0.8
    
    
    private struct Constants {
        static let minHeight = UIScreen.main.bounds.height * 0.6
        static let maxHeight = UIScreen.main.bounds.height * 0.8
    }
    var dragPercentage: Double {
        let res = Double((curHeight - Constants.minHeight) / (Constants.maxHeight - Constants.minHeight))
        return max(0, min(1, res))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                BackdropView()
                    .blur(radius: 5.0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowing = false
                    }
                
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .alert(isPresented: .constant(errorMessage != "")) {
            Alert(title: Text("Error!"), message: Text(errorMessage), dismissButton: .default(Text("OK"), action: {
                errorMessage = ""
            }))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .animation(.easeInOut, value: 30)
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .fill(Color.black)
                    .frame(width: 50, height: 10)
            }
            .frame(height: 20)
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
            .gesture(dragGesture)
            
            ZStack {
                VStack(alignment: .center, spacing: 5) {
                    Text("Add Quest")
                }
            }
            
            VStack(spacing: 20) {
                TextField("Quest", text: $quest)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Tokens", text: $tokens)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Badges", text: $badges)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    let token : Int = Int(tokens) ?? 0
                    let badge : Int = Int(badges) ?? 0
                    let questM : String = quest
                    badges = ""
                    tokens = ""
                    quest = ""
                    if token == 0 || badge == 0 {
                        errorMessage = "Token and badge must be whole numbers different from 0!"
                    } else if token <= dashboardVM.userDetails.token {
                        if token != 0 && badge != 0 {
                            let questModel: QuestModelPost = .init(quest: questM, tokens: token, badges: badge)
                            dashboardVM.addQuest(quest: questModel)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                DispatchQueue.main.async {
                                    dashboardVM.reloadDetails()
                                }
                            }
                            isShowing = false
                        }
                    } else {
                        errorMessage = "You don't have enough tokens!"
                    }
                    
                }) {
                    HStack{
                        Spacer()
                        Text("Add")
                            .foregroundColor(.white)
                            .padding()
                            
                        Spacer()
                    }
                    .background(Color.blue)
                    .cornerRadius(20)
                }
                
            }
            .padding([.leading, .trailing], 30)
            
            Spacer()
        }
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Rectangle()
                    .cornerRadius(50, corners: [.topLeft, .topRight])
                Rectangle()
                    .frame(height: curHeight / 2)
            }
                .foregroundColor(.gray)
                .edgesIgnoringSafeArea(.all)
        )
        .animation(isDragging ? nil : .easeInOut(duration: 0.45), value: 30)
        .onDisappear {
            curHeight = Constants.maxHeight
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = (val.translation.height - prevDragTranslation.height)
                
                if abs(dragAmount) < (Constants.maxHeight / 9) {
                    if curHeight > Constants.maxHeight || curHeight < Constants.minHeight {
                        curHeight -= dragAmount / 6
                        if curHeight < Constants.minHeight {
                            isShowing = false
                        }
                    } else {
                        curHeight -= dragAmount
                    }
                }
                prevDragTranslation = val.translation
            }
            .onEnded { _ in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > Constants.maxHeight {
                    curHeight = Constants.maxHeight
                } else if curHeight < Constants.minHeight {
                    isShowing = false
                }
            }
    }
}


struct AddQuestView_Previews: PreviewProvider {
    static var previews: some View {
        AddQuestView(isShowing: .constant(true), quest: .constant(""), tokens: .constant(""), badges: .constant(""))
    }
}
