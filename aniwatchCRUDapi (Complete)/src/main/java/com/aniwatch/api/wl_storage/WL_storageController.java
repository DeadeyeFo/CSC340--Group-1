package com.aniwatch.api.wl_storage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * wl_storageController is a REST controller that handles requests related to the WL_storage entity.
 * It provides endpoints to create, read, update, and delete WL_storage records.
 */
@RestController
@RequestMapping("/wl_storage")
public class WL_storageController {

    @Autowired
    private WL_storageService wl_storageService;

    /**
     * Get all WL_storage records.
     * Endpoint: http://localhost:8080/wl_storage/all
     * @return a list of all WL_storage records.
     * 
     */
    @GetMapping("/all")
    public ResponseEntity<Object> getAllWL_storage() {
        return new ResponseEntity<>(wl_storageService.getAllWL_storage(), HttpStatus.OK);
    }

    /**
     * Get a WL_storage record by id.
     * Endpoint: http://localhost:8080/wl_storage/{id}
     * @param id the id of the WL_storage record.
     * @return the WL_storage record with the specified id.
     */
    @GetMapping("/{id}")
    public ResponseEntity<Object> getWL_storageById(@PathVariable Integer id) {
        return new ResponseEntity<>(wl_storageService.getWL_storageById(id), HttpStatus.OK);
    }

    


}
