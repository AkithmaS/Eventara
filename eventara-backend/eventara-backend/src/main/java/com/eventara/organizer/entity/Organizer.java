package com.eventara.organizer.entity;

import com.eventara.common.enums.OrganizerStatus;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "organizers")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Organizer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false)
    private String organizationName;

    @Column
    private String organizationType;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column
    private String websiteUrl;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    @Builder.Default
    private OrganizerStatus status = OrganizerStatus.PENDING;

    @Column
    private String rejectionReason;

    @CreationTimestamp
    private LocalDateTime appliedAt;

    @Column
    private LocalDateTime reviewedAt;

    @CreationTimestamp
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;
}
