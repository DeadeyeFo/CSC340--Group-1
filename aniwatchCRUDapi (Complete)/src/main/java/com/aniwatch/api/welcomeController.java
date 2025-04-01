package com.aniwatch.api;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/")
public class welcomeController {

    @GetMapping
    public String getPage() {
        return "Welcome";
    }
}
