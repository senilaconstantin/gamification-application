package com.senilaconstantin.senilaconstantin_accesa.dto;

import com.senilaconstantin.senilaconstantin_accesa.user.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;
@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserDetailsDto {
    private Integer uuid;
    private String firstName;
    private String lastName;
    private Integer token;
    private Integer badges;
    private Float ranking;

    public UserDetailsDto(User user) {
        this.uuid = user.getId();
        this.firstName = user.getFirstname();
        this.lastName = user.getLastname();
        this.token = user.getToken();
        this.badges = user.getBadges();
        this.ranking = user.getRanking();
    }

}
