//
//  CardView.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 09.04.2023.
//

import SwiftUI

struct CardView: View {
    @Binding var quest: QuestModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(quest.quest)
                    .font(.system(size: 25))
                //                    .padding([.top, .bottom], 25)
                    .padding([.trailing], 10)
                HStack {
                    Text("tokens: \(quest.tokens)")
                        .font(.system(size: 20))
                    Text("badges: \(quest.badges)")
                        .font(.system(size: 20))
                }
                
            }.padding([.top, .bottom], 25)
            
            Spacer()
            
        }
        .background(Color.yellow.cornerRadius(15))
        .padding([.leading, .trailing], 20)
//        .cornerRadius(15)
        
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(quest: .constant(QuestModel(id: 1, quest: "Coco Quest", tokens: 2, badges: 1)))
    }
}
