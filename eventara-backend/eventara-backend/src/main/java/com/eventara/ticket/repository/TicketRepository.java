package com.eventara.ticket.repository;

import com.eventara.ticket.entity.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TicketRepository extends JpaRepository<Ticket, Long> {
    // queries will be added later
}
