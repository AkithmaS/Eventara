package com.eventara.event.repository;

import com.eventara.event.entity.Event;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EventRepository extends JpaRepository<Event, Long> {
    // queries will be added later
}
