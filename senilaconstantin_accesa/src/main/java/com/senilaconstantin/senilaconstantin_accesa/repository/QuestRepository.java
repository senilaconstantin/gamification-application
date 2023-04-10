package com.senilaconstantin.senilaconstantin_accesa.repository;

import com.senilaconstantin.senilaconstantin_accesa.models.Quest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface QuestRepository extends JpaRepository<Quest, Integer> {
    List<Quest> findAll();
    List<Quest> findAllByUserSolvedIsNull();
    Optional<Quest> findById(Integer id);
}
