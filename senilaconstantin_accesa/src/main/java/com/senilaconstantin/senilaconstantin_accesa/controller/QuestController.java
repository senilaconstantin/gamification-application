package com.senilaconstantin.senilaconstantin_accesa.controller;

import com.senilaconstantin.senilaconstantin_accesa.auth.AuthenticationService;
import com.senilaconstantin.senilaconstantin_accesa.dto.QuestDTO;
import com.senilaconstantin.senilaconstantin_accesa.dto.UserDetailsDto;
import com.senilaconstantin.senilaconstantin_accesa.service.QuestService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/quest")
@RequiredArgsConstructor
public class QuestController {
    @Autowired
    private final QuestService questService;

    @PostMapping("/")
    public void addQuest(@RequestBody QuestDTO questDTO) {
        questService.addQuest(questDTO);
    }

    @PutMapping("/")
    @ResponseBody
    public void updateQuest(@RequestParam(name = "id") Integer id) {
        questService.setQuest(id);
    }

    @GetMapping("/")
    public List<QuestDTO> getAllQuests(){
        return questService.getAllQuest();
    }

    @GetMapping("/getQuests")
    public List<QuestDTO> getQuests(){
        return questService.getAllQuestAvailable();
    }

}
