package com.aniwatch.aniwatch.anime;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
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

            // Map each node to an Anime (but don’t save), limiting to `limit`
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
     * Fetches up to 20 anime from Jikan, saves each into the DB, and returns the
     * list.
     */
    public List<Anime> fetchAndSaveTopAnime() {
        try {
            String json = restTemplate.getForObject(JIKAN_API, String.class);
            JsonNode data = objectMapper.readTree(json).path("data");

            List<Anime> animeList =
                    // stream over the first 20 entries
                    toList(data).stream()
                            .limit(20)
                            .map(this::toAnimeEntity)
                            .collect(Collectors.toList());

            // saveAll as a batch
            animeRepository.saveAll(animeList);
            return animeList;

        } catch (JsonProcessingException e) {
            // TODO: replace with a proper logger
            System.err.println("Failed parsing Jikan response: " + e.getMessage());
            return List.of();
        }
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
}
