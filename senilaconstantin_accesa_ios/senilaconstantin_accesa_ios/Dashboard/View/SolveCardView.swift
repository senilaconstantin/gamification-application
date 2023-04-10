//
//  SolveCardView.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 09.04.2023.
//

import SwiftUI

struct SolveCardView: View {
    @Binding var isShowing: Bool
    @Binding var quest: QuestModel
    @EnvironmentObject var dashboardVM: DashboardViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                BackdropView()
                    .blur(radius: 5.0)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    mainView
                        .transition(.move(edge: .bottom))
                    
                    Spacer()
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    var mainView: some View {
        VStack (spacing: 10){
            HStack{
                Button {
                    isShowing = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                }
                Spacer()
            }
            .padding([.leading, .trailing, .top], 20)
            
            
            Text("Quest: \(quest.quest)")
                .font(.system(size: 25))
                .padding([.leading, .trailing], 20)
            HStack {
                Text("tokens: \(quest.tokens)")
                    .font(.system(size: 20))
                Text("badges: \(quest.badges)")
                    .font(.system(size: 20))
                
            }
            .padding([.leading, .trailing], 20)
            Spacer()
            
            Button {
                dashboardVM.updateQuest(id: quest.id)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    DispatchQueue.main.async {
                        dashboardVM.reloadDetails()
                    }
                }
                isShowing = false
            } label: {
                HStack{
                    Spacer()
                    Text("Solve")
                        .foregroundColor(.white)
                        .padding()
                    
                    Spacer()
                }
                .background(Color.blue)
                .cornerRadius(20)
                .padding([.all], 20)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 4)
        .background(Color.gray)
        .cornerRadius(20)
        .padding([.leading, .trailing], 15)
        
    }
}

struct SolveCardView_Previews: PreviewProvider {
    static var previews: some View {
        SolveCardView(isShowing: .constant(true), quest: .constant(QuestModel(id: 1, quest: "Quest 1", tokens: 2, badges: 3)))
    }
}
