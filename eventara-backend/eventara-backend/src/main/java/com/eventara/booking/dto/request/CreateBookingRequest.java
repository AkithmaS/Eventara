package com.eventara.booking.dto.request;

import lombok.Data;

import java.util.List;

@Data
public class CreateBookingRequest {

    private Long eventId;
    private List<Long> seatIds;
    private Integer quantity;
}
