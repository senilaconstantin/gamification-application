//
//  QuestModel.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 09.04.2023.
//

import SwiftUI

public class QuestModel: Decodable, ObservableObject {
    public var id: Int
    public var quest: String
    public var tokens: Int
    public var badges: Int
    
    init(id: Int, quest: String, tokens: Int, badges: Int) {
        self.id = id
        self.quest = quest
        self.tokens = tokens
        self.badges = badges
    }
}
