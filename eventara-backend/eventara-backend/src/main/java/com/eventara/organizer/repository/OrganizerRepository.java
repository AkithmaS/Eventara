package com.eventara.organizer.repository;

import com.eventara.organizer.entity.Organizer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface OrganizerRepository extends JpaRepository<Organizer, Long> {

    Optional<Organizer> findByUserId(Long userId);
}
