package com.aniwatch.aniwatch.anime;

import com.aniwatch.aniwatch.user.UserService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/browse-anime")
public class AnimeController {

    @Autowired
    private AnimeService animeService;

    @Autowired
    private UserService userService;

    @GetMapping
    public String browseAnime(Model model) {
        // 1) Fetch & save API results
        List<Anime> animeList = animeService.fetchAndSaveTopAnime();
        model.addAttribute("animeList", animeList);

        // 2) Your existing auth & userService logic...
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuth = auth != null && auth.isAuthenticated()
                         && !"anonymousUser".equals(auth.getName());
        model.addAttribute("isAuthenticated", isAuth);
        if (isAuth) {
            String username = auth.getName();
            model.addAttribute("username", username);
            boolean isProvider = userService.isProvider(username);
            model.addAttribute("isProvider", isProvider);
            if (isProvider) {
                model.addAttribute("providerId", userService.getProviderId(username));
            }
        }
        return "browse-anime";
    }
}