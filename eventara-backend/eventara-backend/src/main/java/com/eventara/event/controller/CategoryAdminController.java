package com.eventara.event.controller;

import com.eventara.common.response.ApiResponse;
import com.eventara.event.dto.request.CategoryRequest;
import com.eventara.event.dto.response.CategoryResponse;
import com.eventara.event.service.CategoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admin/categories")
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class CategoryAdminController {

    private final CategoryService categoryService;

    // GET /api/admin/categories
    @GetMapping
    public ResponseEntity<ApiResponse<List<CategoryResponse>>> getAllCategories() {
        return ResponseEntity.ok(ApiResponse.success(
                categoryService.getAllCategories(), "Categories fetched successfully"));
    }

    // POST /api/admin/categories
    @PostMapping
    public ResponseEntity<ApiResponse<CategoryResponse>> createCategory(
            @Valid @RequestBody CategoryRequest request) {
        CategoryResponse response = categoryService.createCategory(
                request.getName(), request.getIcon(), request.getDescription());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(response, "Category created successfully"));
    }

    // PUT /api/admin/categories/{id}
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<CategoryResponse>> updateCategory(
            @PathVariable Long id,
            @Valid @RequestBody CategoryRequest request) {
        CategoryResponse response = categoryService.updateCategory(
                id, request.getName(), request.getIcon(), request.getDescription());
        return ResponseEntity.ok(ApiResponse.success(response, "Category updated successfully"));
    }

    // PATCH /api/admin/categories/{id}/toggle
    @PatchMapping("/{id}/toggle")
    public ResponseEntity<ApiResponse<Void>> toggleCategoryActive(@PathVariable Long id) {
        categoryService.toggleCategoryActive(id);
        return ResponseEntity.ok(ApiResponse.success("Category status toggled successfully"));
    }
}
