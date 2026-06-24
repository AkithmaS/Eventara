package com.eventara.common.config;

import com.eventara.event.entity.Category;
import com.eventara.event.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final CategoryRepository categoryRepository;

    @Override
    public void run(String... args) {
        if (categoryRepository.count() == 0) {
            log.info("Seeding default categories...");

            List<Category> defaults = List.of(
                    buildCategory("Music & Concerts",          "🎵", "Live music events and concerts"),
                    buildCategory("Sports",                    "🏟️", "Sports matches and tournaments"),
                    buildCategory("Theatre & Performing Arts", "🎭", "Theatre, dance, and stage performances"),
                    buildCategory("Comedy Shows",              "🎤", "Stand-up comedy and comedy events"),
                    buildCategory("Conferences & Seminars",    "🎓", "Professional conferences and seminars"),
                    buildCategory("Workshops",                 "🎨", "Hands-on workshops and training sessions"),
                    buildCategory("Film & Cinema",             "🎬", "Movie screenings and film festivals"),
                    buildCategory("Cultural Events",           "🕌", "Cultural and heritage events"),
                    buildCategory("Family & Kids",             "👶", "Events for families and children"),
                    buildCategory("Other",                     "📌", "Other events")
            );

            categoryRepository.saveAll(defaults);
            log.info("Seeded {} default categories", defaults.size());
        }
    }

    private Category buildCategory(String name, String icon, String description) {
        return Category.builder()
                .name(name)
                .icon(icon)
                .description(description)
                .isActive(true)
                .build();
    }
}
