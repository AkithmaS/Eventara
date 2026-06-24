package com.eventara.event.controller;

import com.eventara.common.enums.EventStatus;
import com.eventara.common.response.ApiResponse;
import com.eventara.event.dto.request.RejectEventRequest;
import com.eventara.event.dto.response.EventResponse;
import com.eventara.event.service.AdminEventService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/events")
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminEventController {

    private final AdminEventService adminEventService;

    // GET /api/admin/events
    @GetMapping
    public ResponseEntity<ApiResponse<List<EventResponse>>> getAllEvents() {
        return ResponseEntity.ok(ApiResponse.success(
                adminEventService.getAllEvents(), "Events fetched successfully"));
    }

    // GET /api/admin/events/status?status=SUBMITTED
    @GetMapping("/status")
    public ResponseEntity<ApiResponse<List<EventResponse>>> getEventsByStatus(
            @RequestParam EventStatus status) {
        return ResponseEntity.ok(ApiResponse.success(
                adminEventService.getEventsByStatus(status), "Events fetched successfully"));
    }

    // POST /api/admin/events/{id}/approve
    @PostMapping("/{id}/approve")
    public ResponseEntity<ApiResponse<EventResponse>> approveEvent(@PathVariable Long id) {
        EventResponse response = adminEventService.approveEvent(id);
        return ResponseEntity.ok(ApiResponse.success(response, "Event approved successfully"));
    }

    // POST /api/admin/events/{id}/reject
    @PostMapping("/{id}/reject")
    public ResponseEntity<ApiResponse<EventResponse>> rejectEvent(
            @PathVariable Long id,
            @Valid @RequestBody RejectEventRequest request) {
        EventResponse response = adminEventService.rejectEvent(id, request.getNotes());
        return ResponseEntity.ok(ApiResponse.success(response, "Event rejected"));
    }
}
