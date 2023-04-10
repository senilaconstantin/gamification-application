package com.senilaconstantin.senilaconstantin_accesa.dto;

import com.senilaconstantin.senilaconstantin_accesa.models.Quest;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class QuestDTO {
    public Integer id;
    private String quest;
    private Integer tokens;
    private Integer badges;

    public QuestDTO(Quest quest) {
        this.id = quest.getId();
        this.quest = quest.getQuest();
        this.tokens = quest.getTokens();
        this.badges = quest.getBadges();
    }

}
