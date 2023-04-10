//
//  QuestModelPost.swift
//  senilaconstantin_accesa_ios
//
//  Created by Constantin Senila on 09.04.2023.
//

import SwiftUI

public struct QuestModelPost: Encodable {
    public var quest: String
    public var tokens: Int
    public var badges: Int
    
    public init(quest: String, tokens: Int, badges: Int) {
        self.quest = quest
        self.tokens = tokens
        self.badges = badges
    }
    
}
