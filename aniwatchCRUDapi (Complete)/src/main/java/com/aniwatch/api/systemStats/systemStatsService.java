package com.aniwatch.api.systemStats;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class systemStatsService {

    @Autowired
    private systemStatsRepository systemRepository;

    public List<systemStats> getAllSystemStats(){
        return systemRepository.findAll();
    }
}
