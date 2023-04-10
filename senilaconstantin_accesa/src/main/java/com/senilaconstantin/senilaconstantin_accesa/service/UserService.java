package com.senilaconstantin.senilaconstantin_accesa.service;

import com.senilaconstantin.senilaconstantin_accesa.config.SecurityService;
import com.senilaconstantin.senilaconstantin_accesa.dto.UserDetailsDto;
import com.senilaconstantin.senilaconstantin_accesa.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
    private final SecurityService securityService;

    @Autowired
    public UserService(SecurityService securityService) {
        this.securityService = securityService;
    }

    public UserDetailsDto getUserDetails() {
        User user = securityService.getCurrentAccountCredentials();
        return new UserDetailsDto(user);
    }
}
