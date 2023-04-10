//
//  DashboardViewModel.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 08.04.2023.
//

import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var userDetails: UserDetails = .init(uuid: 0, firstName: "", lastName: "", token: 0, badges: 0, ranking: 0)
    @Published var questList = [QuestModel]()
    
    init() {
        reloadDetails()
    }
    
    func reloadDetails() {
        APIClient.shared.getUserDetailsDat(token: CurrentUser.shared.getToken()) { data in
            DispatchQueue.main.async {
                if let userDetails = data {
                    self.userDetails = userDetails
                    print("------")
                    print(userDetails.uuid)
                    print(self.userDetails.firstName)
                    print(userDetails.lastName)
                    //                    self.userDetails.uuid = userDetails.uuid
                    //                    self.userDetails.firstName = userDetails.firstName
                    //                    self.userDetails.lastName = userDetails.lastName
                } else {
                    print("nu e userDetails")
                }
            }
        }
        
        questList = [QuestModel]()
        APIClient.shared.getQuestsData(token: CurrentUser.shared.getToken()) { data in
            DispatchQueue.main.async {
                if let quests = data {
                    print("---siezeQuestList\(quests.count)")
                    self.questList = quests
                } else {
                    print("Error QuestList!")
                }
            }
        }
    }
    
    func addQuest(quest: QuestModelPost) {
        DispatchQueue.main.async {
            APIClient.shared.addQuest(token: CurrentUser.shared.getToken(), quest: quest) { error in
                if let error = error {
                    print("Error Quest! - \(error.localizedDescription)")
                }
            }
        }
    }
    
    func updateQuest(id: Int) {
        DispatchQueue.main.async {
            APIClient.shared.updateQuestUser(token: CurrentUser.shared.getToken(), id: id) { error in
                if let errorM = error {
                    print("Error Update Quest! \(error?.localizedDescription)")
                }
            }
        }
    }
    
}
