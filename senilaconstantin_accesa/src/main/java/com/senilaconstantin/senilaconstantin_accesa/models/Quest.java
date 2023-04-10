package com.senilaconstantin.senilaconstantin_accesa.models;

import com.senilaconstantin.senilaconstantin_accesa.dto.QuestDTO;
import com.senilaconstantin.senilaconstantin_accesa.user.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Quest {
    @Id
    @GeneratedValue
    public Integer id;
    private String quest;
    private Integer tokens;
    private Integer badges;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id_c")
    private User userCreated;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id_s")
    private User userSolved;

    public Quest(QuestDTO questDTO) {
//        this.id = questDTO.getId();
        this.quest = questDTO.getQuest();
        this.tokens = questDTO.getTokens();
        this.badges = questDTO.getBadges();
    }
}
