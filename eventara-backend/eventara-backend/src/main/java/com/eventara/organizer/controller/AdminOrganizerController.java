package com.eventara.organizer.controller;

import com.eventara.common.enums.OrganizerStatus;
import com.eventara.common.response.ApiResponse;
import com.eventara.organizer.dto.request.RejectOrganizerRequest;
import com.eventara.organizer.dto.request.SuspendOrganizerRequest;
import com.eventara.organizer.dto.response.OrganizerResponse;
import com.eventara.organizer.service.AdminOrganizerService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/organizers")
@RequiredArgsConstructor
@PreAuthorize("hasRole('ADMIN')")
public class AdminOrganizerController {

    private final AdminOrganizerService adminOrganizerService;

    // GET /api/admin/organizers?status=PENDING
    @GetMapping
    public ResponseEntity<ApiResponse<List<OrganizerResponse>>> getAllApplications(
            @RequestParam(required = false) OrganizerStatus status) {

        List<OrganizerResponse> response = adminOrganizerService.getAllApplications(status);
        return ResponseEntity.ok(ApiResponse.success(response, "Organizer applications fetched successfully"));
    }

    // POST /api/admin/organizers/{id}/approve
    @PostMapping("/{id}/approve")
    public ResponseEntity<ApiResponse<OrganizerResponse>> approveOrganizer(
            @PathVariable Long id) {

        OrganizerResponse response = adminOrganizerService.approveOrganizer(id);
        return ResponseEntity.ok(ApiResponse.success(response, "Organizer approved successfully"));
    }

    // POST /api/admin/organizers/{id}/reject
    @PostMapping("/{id}/reject")
    public ResponseEntity<ApiResponse<OrganizerResponse>> rejectOrganizer(
            @PathVariable Long id,
            @Valid @RequestBody RejectOrganizerRequest request) {

        OrganizerResponse response = adminOrganizerService.rejectOrganizer(id, request.getReason());
        return ResponseEntity.ok(ApiResponse.success(response, "Organizer rejected"));
    }

    // POST /api/admin/organizers/{id}/suspend
    @PostMapping("/{id}/suspend")
    public ResponseEntity<ApiResponse<OrganizerResponse>> suspendOrganizer(
            @PathVariable Long id,
            @Valid @RequestBody SuspendOrganizerRequest request) {

        OrganizerResponse response = adminOrganizerService.suspendOrganizer(id, request.getReason());
        return ResponseEntity.ok(ApiResponse.success(response, "Organizer suspended"));
    }

    // POST /api/admin/organizers/{id}/reinstate
    @PostMapping("/{id}/reinstate")
    public ResponseEntity<ApiResponse<OrganizerResponse>> reinstateOrganizer(
            @PathVariable Long id) {

        OrganizerResponse response = adminOrganizerService.reinstateOrganizer(id);
        return ResponseEntity.ok(ApiResponse.success(response, "Organizer reinstated successfully"));
    }
}
