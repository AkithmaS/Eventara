package com.eventara.booking.repository;

import com.eventara.booking.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    // queries will be added later
}
