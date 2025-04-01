package com.aniwatch.api.systemStats;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/")
public class systemStatsController {
    @Autowired
    private systemStatsService systemService;

    @GetMapping("stats")
    public Object getAllStatLogs(){
        return new ResponseEntity<>(systemService.getAllSystemStats(), HttpStatus.OK);
    }

}
