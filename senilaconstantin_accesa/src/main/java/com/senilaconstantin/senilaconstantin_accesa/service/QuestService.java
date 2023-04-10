package com.senilaconstantin.senilaconstantin_accesa.service;

import com.senilaconstantin.senilaconstantin_accesa.config.SecurityService;
import com.senilaconstantin.senilaconstantin_accesa.dto.QuestDTO;
import com.senilaconstantin.senilaconstantin_accesa.models.Quest;
import com.senilaconstantin.senilaconstantin_accesa.repository.QuestRepository;
import com.senilaconstantin.senilaconstantin_accesa.user.User;
import com.senilaconstantin.senilaconstantin_accesa.user.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class QuestService {
    private final QuestRepository questRepository;
    private final SecurityService securityService;
    private final UserRepository userRepository;

    @Autowired
    public QuestService(QuestRepository questRepository, SecurityService securityService, UserRepository userRepository) {
        this.questRepository = questRepository;
        this.securityService = securityService;
        this.userRepository = userRepository;
    }

    public void addQuest(QuestDTO questDTO) {
        Quest quest = new Quest(questDTO);
        quest.setUserCreated(securityService.getCurrentAccountCredentials());
        questRepository.save(quest);
        User user = securityService.getCurrentAccountCredentials();
        user.setToken(user.getToken() - questDTO.getTokens());
        userRepository.save(user);
    }

    public List<QuestDTO> getAllQuest() {
        List<Quest> quests = questRepository.findAll();
        List<QuestDTO> questDTOList = quests.stream()
                .map(quest -> new QuestDTO(quest))
                .collect(Collectors.toList());
        return questDTOList;
    }

    public List<QuestDTO> getAllQuestAvailable() {
        List<Quest> quests = questRepository.findAllByUserSolvedIsNull();
        List<QuestDTO> questDTOList = quests.stream()
                .map(quest -> new QuestDTO(quest))
                .collect(Collectors.toList());
        return questDTOList;
    }

    public void setQuest(Integer idQuest) {
        Optional<Quest> questOPtional = questRepository.findById(idQuest);
        if(!questOPtional.isPresent()) {
            return;
        }
        Quest quest = questOPtional.get();
        User user = securityService.getCurrentAccountCredentials();
        quest.setUserSolved(user);
        questRepository.save(quest);
        user.setToken(user.getToken() + quest.getTokens());
        user.setBadges(user.getBadges() + quest.getBadges());
        userRepository.save(user);

        List<User> userList = userRepository.findAll();
//        Collections.sort(userList, Comparator.comparing(User::getBadges));
        Collections.sort(userList, Comparator.comparing(User::getBadges).reversed());
        Float i = (float) 0;
        for(User useru: userList) {
            useru.setRanking(++i);
            userRepository.save(useru);
            System.out.println("Useru = " + useru.getRanking() + " - " + useru.getEmail());
        }
    }
}
