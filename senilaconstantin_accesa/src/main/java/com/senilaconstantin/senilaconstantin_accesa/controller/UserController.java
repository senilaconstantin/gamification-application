package com.senilaconstantin.senilaconstantin_accesa.controller;

import com.senilaconstantin.senilaconstantin_accesa.dto.UserDetailsDto;
import com.senilaconstantin.senilaconstantin_accesa.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin
@RestController
@RequestMapping("/user")
public class UserController {
    private final UserService userDetailsService;

    @Autowired
    public UserController(UserService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @GetMapping("/details")
    public UserDetailsDto getUserDetails(){
        return userDetailsService.getUserDetails();
    }
}
