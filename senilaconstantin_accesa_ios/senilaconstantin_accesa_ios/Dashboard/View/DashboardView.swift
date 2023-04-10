//
//  DashboardView.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var verificationVM: VerificationViewModel
    @StateObject var dashboardVM: DashboardViewModel = .init()
    @State var isShowing: Bool = false
    @State var isShowingSolveCard: Bool = false
    @State var cardSelected: QuestModel = .init(id: 0, quest: "", tokens: 0, badges: 0)
    
    @State var quest: String = ""
    @State var tokens: String = ""
    @State var badges: String = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    Text("\(dashboardVM.userDetails.firstName) \(dashboardVM.userDetails.lastName)")
                    Spacer()
                    Text("LogOut")
                        .onTapGesture {
                            CurrentUser.shared.logout()
                            verificationVM.ver()
                        }
                }
                HStack {
                    Text("tokens:")
                        .background(Color.blue)
                    Text("\(dashboardVM.userDetails.token)")
                    
                    Text("badges:")
                        .background(Color.blue)
                    Text("\(dashboardVM.userDetails.badges)")
                    
                    Text("ranking:")
                        .background(Color.blue)
                    Text(String(format: "%.2f", dashboardVM.userDetails.ranking))
                    Spacer()
                }
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isShowing = true
                        } label: {
                            Image(systemName: "plus")
                                .renderingMode(.template)
                                .foregroundColor(Color.black)
                                .frame(width: 30, height: 30)
                            
                        }
                    }
                    
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(dashboardVM.questList.indices, id: \.self) { index in
                            CardView(quest: $dashboardVM.questList[index])
                                .onTapGesture {
                                    cardSelected = dashboardVM.questList[index]
                                    isShowingSolveCard = true
                                }
                        }
                        //                    ForEach(self.$dashboardVM.questList, id: \.self) { $quest in
                        //                        CardView(quest: $quest)
                        //                    }
                    }
                }
                
                //                Spacer()
            }
            .padding([.leading, .trailing], 20)
      
            AddQuestView(isShowing: $isShowing, quest: $quest, tokens: $tokens, badges: $badges)
                .environmentObject(dashboardVM)
            SolveCardView(isShowing: $isShowingSolveCard, quest: $cardSelected)
                .environmentObject(dashboardVM)
            
            
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
