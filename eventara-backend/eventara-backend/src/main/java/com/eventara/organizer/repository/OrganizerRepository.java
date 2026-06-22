package com.eventara.organizer.repository;

import com.eventara.organizer.entity.Organizer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrganizerRepository extends JpaRepository<Organizer, Long> {
    // queries will be added later
}
