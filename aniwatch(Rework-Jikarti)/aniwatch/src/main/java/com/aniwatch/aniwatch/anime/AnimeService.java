package com.aniwatch.aniwatch.anime;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class AnimeService {

    private static final String JIKAN_API = "https://api.jikan.moe/v4/anime?limit=20&sfw=true";

    private static final String SEASON_URL_TEMPLATE = "https://api.jikan.moe/v4/seasons/%d/%s?limit=20&sfw=true&rating=pg-13";

    private final AnimeRepository animeRepository;
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    @Autowired
    public AnimeService(AnimeRepository repo, RestTemplate rt, ObjectMapper om) {
        this.animeRepository = repo;
        this.restTemplate = rt;
        this.objectMapper = om;
    }

    /**
     * Fetches (but does NOT save) up to `limit` anime for the given year+season.
     */
    public List<Anime> fetchSeasonalAnime(int year, String season, int limit) {
        try {
            // Build the URL using your new constant
            String url = String.format(SEASON_URL_TEMPLATE, year, season.toLowerCase());

            // Call the Jikan API
            String json = restTemplate.getForObject(url, String.class);

            // Parse the "data" array
            JsonNode data = objectMapper.readTree(json).path("data");

            // Map each node to an Anime (but don't save), limiting to `limit`
            return StreamSupport.stream(data.spliterator(), false)
                    .limit(limit)
                    .map(this::mapNodeToAnime)
                    .collect(Collectors.toList());

        } catch (JsonProcessingException e) {
            // Log and return empty fallback on parse errors
            System.err.println("Error fetching seasonal anime: " + e.getMessage());
            return List.of();
        }
    }

    /** Helper to turn a single JSON node into an Anime instance. */
    private Anime mapNodeToAnime(JsonNode node) {
        Anime a = new Anime();

        // Title (fallback to the canonical "title" if English is missing)
        String eng = node.path("title_english").asText(null);
        String fallback = node.path("title").asText("Untitled");
        a.setTitle((eng != null && !eng.isEmpty()) ? eng : fallback);

        // Alternate title and image URL
        a.setAlternateTitle(node.path("title_japanese").asText(""));
        a.setImageUrl(node.path("images")
                .path("webp")
                .path("large_image_url")
                .asText());

        return a;
    }

    /**
     * Fetches up to 20 anime from Jikan, saves each into the DB if it doesn't already exist,
     * and returns the list.
     */
    public List<Anime> fetchAndSaveTopAnime() {
        try {
            String json = restTemplate.getForObject(JIKAN_API, String.class);
            JsonNode data = objectMapper.readTree(json).path("data");

            List<Anime> animeList = toList(data).stream()
                    .limit(20)
                    .map(this::toAnimeEntity)
                    .collect(Collectors.toList());

            // Collect the modified list with saved entities
            List<Anime> savedList = animeList.stream()
                    .map(this::saveIfNotExists)
                    .collect(Collectors.toList());

            return savedList;

        } catch (JsonProcessingException e) {
            System.err.println("Failed parsing Jikan response: " + e.getMessage());
            return List.of();
        }
    }

    /**
     * Save the anime if it doesn't already exist in the database
     */
    private Anime saveIfNotExists(Anime anime) {
        // Try to find an existing anime with the same externalId
        List<Anime> existingAnime = animeRepository.findByExternalId(anime.getExternalId());

        if (!existingAnime.isEmpty()) {
            // If it exists, return the existing entity
            return existingAnime.get(0);
        }

        // Otherwise, save and return the new entity
        return animeRepository.save(anime);
    }

    public Anime getAnimeById(Long id) {
        return animeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Anime not found: " + id));
    }

    // -- private helpers -----------------------------------------

    /** Converts a JsonNode into your Anime entity. */
    private Anime toAnimeEntity(JsonNode node) {
        Anime a = new Anime();
        a.setExternalId(node.path("mal_id").asLong());
        a.setTitle(node.path("title").asText(null));
        a.setAlternateTitle(node.path("title_japanese").asText(null));
        a.setImageUrl(node.path("images")
                .path("webp")
                .path("large_image_url")
                .asText());
        return a;
    }

    /** Utility to turn a JsonNode iterable into a List<JsonNode>. */
    private List<JsonNode> toList(JsonNode arrayNode) {
        return StreamSupport.stream(arrayNode.spliterator(), false)
                .collect(Collectors.toList());
    }

    /**
     * Returns all anime stored in the database, ordered by title
     */
    public List<Anime> getAllAnime() {
        try {
            return animeRepository.findAll(Sort.by(Sort.Direction.ASC, "title"));
        } catch (Exception e) {
            System.err.println("Error retrieving all anime: " + e.getMessage());
            return List.of(); // Return empty list on error
        }
    }

    /**
     * Returns a paginated list of all anime
     */
    public List<Anime> getAnimeWithPagination(int page, int size) {
        try {
            // Create a pageRequest with pagination and sorting
            PageRequest pageRequest = PageRequest.of(
                    page,
                    size,
                    Sort.by(Sort.Direction.ASC, "title")
            );

            // Return the page content as a list
            return animeRepository.findAll(pageRequest).getContent();
        } catch (Exception e) {
            System.err.println("Error retrieving paginated anime: " + e.getMessage());
            return List.of(); // Return empty list on error
        }
    }

    /**
     * Returns a count of all anime in the database
     */
    public long getAnimeCount() {
        try {
            return animeRepository.count();
        } catch (Exception e) {
            System.err.println("Error counting anime: " + e.getMessage());
            return 0;
        }
    }

    /**
     * Search anime by title or alternate title
     */
    public List<Anime> searchAnime(String searchTerm) {
        if (searchTerm == null || searchTerm.trim().isEmpty()) {
            return getAllAnime();
        }

        try {
            String termLike = "%" + searchTerm.trim().toLowerCase() + "%";
            return animeRepository.findByTitleContainingIgnoreCaseOrAlternateTitleContainingIgnoreCase(
                    searchTerm, searchTerm);
        } catch (Exception e) {
            System.err.println("Error searching anime: " + e.getMessage());
            return List.of();
        }
    }
}